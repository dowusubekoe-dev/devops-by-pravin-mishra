# Managing Blog Website on Linux Server

## Step 1: Verify Logged-In User

```bash
whoami  # ec2-user
```

## Step 2: Check the Current Working Directory

```bash
pwd  # /home/ec2-user
```

## Step 3: Switch to Root User

```bash
sudo su
```

## Step 4: Verify Directory After Switching to Root

```bash
pwd   # /home/ec2-user
```

## Step 5: Install Nginx

```bash
yum install nginx -y
```

- `yum` is the package manager for Amazon Linux.
- `install` nginx specifies the package to install.
- `-y` automatically confirms the installation.

## Step 6: Confirm status of Nginx Server

```bash
sudo systemctl status nginx
```

## Step 7: Start Nginx Server

```bash
sudo systemctl start nginx
```

## Step 8: Enable Nginx to Start on Boot

```bash
sudo systemctl enable nginx
```

## Step 9: Adjust Firewall Settings to Allow HTTP Traffic

```bash
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload
```

## Step 10: Verify Nginx Installation

Open a web browser and navigate to your server's Public DNS IP address from the AWS console. You should see the Nginx welcome page.

```bash
ec2-xx-xxx-xxx-xxx.compute-1.amazonaws.com
```

## Location of Website files

For `**nginx**`, the destination of the website files are in `/usr/share/nginx/html`.

Run `cat -n index.html` to display the content with line numbers.
