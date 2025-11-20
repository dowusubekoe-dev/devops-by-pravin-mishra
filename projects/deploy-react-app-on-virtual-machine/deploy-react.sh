#!/usr/bin/env bash
#
# deploy-react.sh
# Usage (non-interactive): ./deploy-react.sh "Derek Owusu Bekoe" "https://github.com/pravinmishraaws/my-react-app.git" [-v] [-d]
# Or run without args to use the interactive menu.
#
set -euo pipefail

LOG_FILE="/var/log/react_deploy.log"
HISTORY_FILE="$HOME/.deploy_history"
ROLLBACK_DIR_BASE="/tmp/react_rollback"
TMP_WORKDIR="/tmp/react_app_src"
NGINX_ROOT="/var/www/html"

# Colors
GREEN="\e[32m"; YELLOW="\e[33m"; RED="\e[31m"; BLUE="\e[34m"; MAGENTA="\e[35m"; RESET="\e[0m"

info()    { echo -e "${BLUE}[INFO]${RESET} $*"; }
ok()      { echo -e "${GREEN}[OK]${RESET} $*"; }
warn()    { echo -e "${YELLOW}[WARN]${RESET} $*"; }
err()     { echo -e "${RED}[ERROR]${RESET} $*" >&2; }
debugln() { [ "$DEBUG" = true ] && echo -e "${MAGENTA}[DEBUG]${RESET} $*"; }

# defaults
VERBOSE=false
DEBUG=false

# spinner helpers
spinner_pid=""
spinner() {
  local pid="$1"; local msg="$2"
  local delay=0.12
  local spin='|/-\'
  printf "%s " "$msg"
  while kill -0 "$pid" 2>/dev/null; do
    for c in ${spin}; do
      printf "\b%s" "$c"
      sleep $delay
    done
  done
  printf "\b"
}

run_bg_with_spinner() {
  local cmd="$1"; shift
  local msg="$*"
  bash -c "$cmd" &
  local pid=$!
  spinner "$pid" "$msg"
  wait "$pid"
  return $?
}

# timing/progress helpers
record_step_time() {
  mkdir -p "$(dirname "$HISTORY_FILE")"
  echo "$1 $2" >> "$HISTORY_FILE"
}

estimate_total_time() {
  awk '{sum[$1]+=$2; cnt[$1]++}
       END{ for (s in sum) printf "%s %.0f %.0f\n", s, sum[s]/cnt[s], cnt[s] }' "$HISTORY_FILE" 2>/dev/null || true
}

estimate_remaining() {
  local cur_idx="$1"; shift
  local -a steps=("$@")
  local total_est=0
  local i=1
  for s in "${steps[@]}"; do
    local avg
    avg=$(awk -v key="$s" '$1==key{sum+=$2;cnt++} END{ if(cnt) printf "%.0f", sum/cnt; else print 0 }' "$HISTORY_FILE" 2>/dev/null || echo 0)
    if [ "$i" -ge "$cur_idx" ]; then total_est=$((total_est + avg)); fi
    i=$((i+1))
  done
  echo "$total_est"
}

# logging
exec > >(tee -a "$LOG_FILE") 2>&1

# rollback
ROLLBACK_SNAPSHOT=""

rollback_restore() {
  if [ -n "$ROLLBACK_SNAPSHOT" ] && [ -d "$ROLLBACK_SNAPSHOT" ]; then
    warn "Performing rollback from $ROLLBACK_SNAPSHOT ..."
    sudo rm -rf "${NGINX_ROOT:?}"/*
    sudo cp -a "$ROLLBACK_SNAPSHOT"/* "$NGINX_ROOT"/ || true
    sudo chown -R www-data:www-data "$NGINX_ROOT"
    ok "Rollback completed."
  else
    warn "No rollback snapshot available."
  fi
}

on_exit() {
  local rc=$?
  if [ $rc -ne 0 ]; then
    err "Script exited with error code $rc"
    rollback_restore
  fi
  exit $rc
}
trap on_exit EXIT

ensure_privileges() {
  if [ "$EUID" -ne 0 ]; then
    warn "Some actions require sudo. You will be prompted for your password."
  fi
}

install_prereqs() {
  local step="apt_update"
  local start=$(date +%s)
  run_bg_with_spinner "sudo apt update -y" "Updating apt..."
  local rc=$?
  local elapsed=$(( $(date +%s) - start ))
  record_step_time "$step" "$elapsed"

  step="install_node_nginx"
  start=$(date +%s)
  run_bg_with_spinner "sudo apt install -y nodejs npm nginx git" "Installing nodejs npm nginx git..."
  rc=$?
  elapsed=$(( $(date +%s) - start ))
  record_step_time "$step" "$elapsed"
  return $rc
}

clone_and_patch() {
  local repo="$1"; local fullname="$2"; local today="$3"
  rm -rf "$TMP_WORKDIR"

  local step="git_clone"
  local start=$(date +%s)
  run_bg_with_spinner "git clone \"$repo\" \"$TMP_WORKDIR\"" "Cloning repository..."
  local rc=$?; local elapsed=$(( $(date +%s) - start ))
  record_step_time "$step" "$elapsed"
  if [ $rc -ne 0 ]; then err "git clone failed"; return $rc; fi

  local app_path="$TMP_WORKDIR/src/App.js"
  if [ -f "$app_path" ]; then
    debugln "Patching $app_path"
    cp -a "$app_path" "${app_path}.bak" || true
    sed -i "s|<h2>Deployed by:.*</h2>|<h2>Deployed by: <strong>${fullname}</strong></h2>|g" "$app_path"
    sed -i "s|<p>Date:.*</p>|<p>Date: <strong>${today}</strong></p>|g" "$app_path"
  else
    warn "App.js not found; continuing without patch."
  fi
}

build_react() {
  pushd "$TMP_WORKDIR" >/dev/null

  local step="npm_install"
  local start=$(date +%s)
  run_bg_with_spinner "npm install --no-audit --no-fund" "Installing npm dependencies..."
  local rc=$?; local elapsed=$(( $(date +%s) - start ))
  record_step_time "$step" "$elapsed"
  if [ $rc -ne 0 ]; then popd >/dev/null; return $rc; fi

  step="npm_build"
  start=$(date +%s)
  run_bg_with_spinner "npm run build" "Running npm build..."
  rc=$?; elapsed=$(( $(date +%s) - start ))
  record_step_time "$step" "$elapsed"

  popd >/dev/null
  return $rc
}

prepare_rollback_snapshot() {
  local ts
  ts=$(date +%s)
  ROLLBACK_SNAPSHOT="${ROLLBACK_DIR_BASE}_${ts}"
  sudo mkdir -p "$ROLLBACK_SNAPSHOT"
  sudo cp -a "${NGINX_ROOT}/." "$ROLLBACK_SNAPSHOT/" 2>/dev/null || true
}

deploy_to_nginx() {
  local step="deploy_copy"
  local start=$(date +%s)

  if [ ! -d "${TMP_WORKDIR}/build" ]; then
    err "Build directory not found."
    return 1
  fi

  run_bg_with_spinner "sudo rm -rf ${NGINX_ROOT}/*" "Cleaning $NGINX_ROOT ..."
  run_bg_with_spinner "sudo cp -a ${TMP_WORKDIR}/build/. ${NGINX_ROOT}/" "Copying build files..."
  local rc=$?; local elapsed=$(( $(date +%s) - start ))
  record_step_time "$step" "$elapsed"

  sudo chown -R www-data:www-data "$NGINX_ROOT"
  sudo chmod -R 755 "$NGINX_ROOT"
  return $rc
}

configure_nginx() {
  sudo tee /etc/nginx/sites-available/default >/dev/null <<'EOF'
server {
    listen 80;
    server_name _;
    root /var/www/html;
    index index.html;
    location / {
        try_files $uri /index.html;
    }
    error_page 404 /index.html;
}
EOF

  sudo nginx -t >/dev/null
  sudo systemctl restart nginx
}

health_check() {
  local public_ip
  public_ip=$(curl -s http://checkip.amazonaws.com || echo "")
  local url="http://${public_ip:-localhost}"

  info "Health check URL: $url"

  for i in $(seq 1 10); do
    if curl -fsS "$url" -m 5 | grep -iq "<html"; then
      ok "Health check succeeded"
      return 0
    fi
    sleep 1
  done

  err "Health check failed"
  return 1
}

menu() {
  while true; do
    echo
    echo -e "${BLUE}React Deploy Menu${RESET}"
    echo " 1) Full deploy"
    echo " 2) Build only"
    echo " 3) Deploy only"
    echo " 4) Rollback last snapshot"
    echo " 5) Show logs"
    echo " 6) Show historical estimates"
    echo " 7) Quit"
    read -rp "Choose [1-7]: " choice
    case "$choice" in
      1) full_deploy && break ;;
      2) clone_and_patch "$REPO_URL_INTERACTIVE" "$FULLNAME_INTERACTIVE" "$TODAY_INTERACTIVE"; build_react; break ;;
      3) prepare_rollback_snapshot; deploy_to_nginx; configure_nginx; health_check || rollback_restore; break ;;
      4) rollback_restore; break ;;
      5) sudo less "$LOG_FILE" ; break ;;
      6) estimate_total_time | awk '{printf "%-30s avg(s)=%s count=%s\n", $1,$2,$3}' ; break ;;
      7) exit 0 ;;
      *) warn "Invalid choice" ;;
    esac
  done
}

full_deploy() {
  ensure_privileges
  install_prereqs

  if [ -z "${FULLNAME_INTERACTIVE:-}" ]; then read -rp "Full name: " FULLNAME_INTERACTIVE; fi
  if [ -z "${REPO_URL_INTERACTIVE:-}" ]; then read -rp "Git repo URL: " REPO_URL_INTERACTIVE; fi

  TODAY_INTERACTIVE=$(date +"%d/%m/%Y")

  clone_and_patch "$REPO_URL_INTERACTIVE" "$FULLNAME_INTERACTIVE" "$TODAY_INTERACTIVE"
  build_react
  prepare_rollback_snapshot
  deploy_to_nginx
  configure_nginx

  local est
  est=$(estimate_remaining 1 apt_update install_node_nginx git_clone npm_install npm_build deploy_copy)
  info "Estimated remaining time (s): $est"

  if health_check; then
    ok "Full deploy completed"
  else
    rollback_restore
    return 1
  fi
}

usage() {
  cat <<EOF
Usage:
  $0 [-v] [-d] ["Full Name"] ["Git Repo URL"]
EOF
}

POSITIONAL=()
while getopts ":vdh" opt; do
  case $opt in
    v) VERBOSE=true ;;
    d) DEBUG=true; set -x ;;
    h) usage; exit 0 ;;
    \?) err "Invalid option"; exit 1 ;;
  esac
done
shift $((OPTIND-1))

if [ $# -eq 2 ]; then
  FULLNAME_CLI="$1"; REPO_CLI="$2"
  FULLNAME_INTERACTIVE="$FULLNAME_CLI"
  REPO_URL_INTERACTIVE="$REPO_CLI"
  TODAY_INTERACTIVE=$(date +"%d/%m/%Y")

  ensure_privileges
  install_prereqs
  clone_and_patch "$REPO_URL_INTERACTIVE" "$FULLNAME_INTERACTIVE" "$TODAY_INTERACTIVE"
  build_react
  prepare_rollback_snapshot
  deploy_to_nginx
  configure_nginx

  est=$(estimate_remaining 1 apt_update install_node_nginx git_clone npm_install npm_build deploy_copy)
  info "Estimated remaining time (s): $est"

  if health_check; then
    ok "Non-interactive deploy complete"
    exit 0
  else
    rollback_restore
    exit 1
  fi

else
  read -rp "Default Git repo URL: " REPO_URL_INTERACTIVE
  read -rp "Default Full Name: " FULLNAME_INTERACTIVE
  TODAY_INTERACTIVE=$(date +"%d/%m/%Y")
  menu
fi