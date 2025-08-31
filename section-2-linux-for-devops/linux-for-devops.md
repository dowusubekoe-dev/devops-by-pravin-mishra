# Linux for DevOps

## Basic Linux Commands

### Step 1: Verify Logged-In User

```bash
whoami  # ec2-user
```

### Step 2: Check the Current Working Directory

```bash
pwd  # /home/ec2-user
```

### Step 3: Switch to Root User

```bash
sudo su
```

### Step 4: Verify Directory After Switching to Root

```bash
pwd   # /home/ec2-user
```

### Step 5: Install Nginx

```bash
yum install nginx -y
```

### Terminologies/Commands

- `yum` is the package manager for Amazon Linux.
- `install` nginx specifies the package to install.
- `-y` automatically confirms the installation.
- `daemons` background processes or services that run continuously without the need for user interaction.
- `systemctl` command used to manage a service on a linux system. `**systemctl status nginx**`

Here’s a clean breakdown for you:

---

### **1. `ls`**

**Main function:** Lists files and directories in the current working directory.
**Example:**

```bash
ls
```

Output might look like:

```bash
file1.txt  file2.log  folder1  folder2
```

---

### **2. `ls -l`**

**Main function:** Lists files in **long format**, showing details like permissions, owner, group, size, and modification date.
**Example:**

```bash
ls -l
```

Output:

```bash
-rw-r--r--  1 dorbsyfx users   120 Aug 22 06:10 file1.txt
-rw-r--r--  1 dorbsyfx users   580 Aug 22 06:12 file2.log
drwxr-xr-x  2 dorbsyfx users  4096 Aug 22 06:15 folder1
```

---

### **3. `ls -a`**

**Main function:** Lists **all files**, including hidden files (those starting with a dot `.`).
**Example:**

```bash
ls -a
```

Output:

```bash
.  ..  .bashrc  .profile  file1.txt  file2.log  folder1
```

(`.` = current directory, `..` = parent directory, `.bashrc` = hidden file).

---

### **4. `ls -lh`**

**Main function:** Lists files in long format with **human-readable sizes** (KB, MB, GB instead of bytes).
**Example:**

```bash
ls -lh
```

Output:

```bash
-rw-r--r--  1 dorbsyfx users  2.1K Aug 22 06:10 file1.txt
-rw-r--r--  1 dorbsyfx users  1.2M Aug 22 06:12 file2.log
drwxr-xr-x  2 dorbsyfx users  4.0K Aug 22 06:15 folder1
```

---

Advanced `ls` command combo:

### **`ls -lha`**

**Main function:** Lists **all files** (including hidden), in **long format**, with **human-readable sizes**. It’s basically the most informative everyday version of `ls`.

**Example:**

```bash
ls -lha
```

**Output:**

```bash
drwxr-xr-x  4 dorbsyfx users  4.0K Aug 22 06:20 .
drwxr-xr-x 15 dorbsyfx users  4.0K Aug 21 22:10 ..
-rw-r--r--  1 dorbsyfx users  2.1K Aug 22 06:10 file1.txt
-rw-r--r--  1 dorbsyfx users  1.2M Aug 22 06:12 file2.log
drwxr-xr-x  2 dorbsyfx users  4.0K Aug 22 06:15 folder1
-rw-r--r--  1 dorbsyfx users   807 Aug 21 21:59 .bashrc
-rw-r--r--  1 dorbsyfx users   220 Aug 21 21:59 .profile
```

You get:

- `.` (current dir) and `..` (parent dir)
- Hidden files (`.bashrc`, `.profile`)
- Permissions, ownership, size in KB/MB/GB, and timestamps

Good call — the `ls -l` (and by extension `ls -lha`) output can look like a wall of text until you know how to read it. Let’s take one line and break it apart:

```bash
-rw-r--r--  1 dorbsyfx users  2.1K Aug 22 06:10 file1.txt
```

---

### **Column Breakdown**

1. **File type and permissions**: `-rw-r--r--`

   - First character: file type

     - `-` = regular file
     - `d` = directory
     - `l` = symbolic link

   - Next 9 characters = permissions, split into three groups:

     - `rw-` → owner (read, write)
     - `r--` → group (read only)
     - `r--` → others (read only)

2. **Link count**: `1`

   - Number of hard links pointing to the file.
   - For directories, this will be higher (each subfolder and parent counts as a link).

3. **Owner**: `dorbsyfx`

   - The username of the file’s owner.

4. **Group**: `users`

   - The group that owns the file.

5. **File size**: `2.1K`

   - Size in bytes by default, but with `-h` it’s human-readable (K, M, G).

6. **Last modified date/time**: `Aug 22 06:10`

   - When the file was last changed.

7. **File name**: `file1.txt`

   - The actual name of the file or directory.

---

### Quick glance at the others in your example

```bash
drwxr-xr-x  2 dorbsyfx users  4.0K Aug 22 06:15 folder1
```

- `d` at the start = it’s a directory
- `rwxr-xr-x` = owner has full rights, group/others can read and execute (enter the directory)
- Size shows `4.0K` because directories themselves just store metadata about files inside

---

Here’s a visual breakdown of one `ls -lha` line, with arrows showing each field:

```markdown
-rw-r--r--   1   dorbsyfx   users   2.1K   Aug 22 06:10   file1.txt
|           |   |          |       |      |              |
|           |   |          |       |      |              +-- File name
|           |   |          |       |      +---------------- Last modified date/time
|           |   |          |       +----------------------- File size (human-readable)
|           |   |          +------------------------------- Group owner
|           |   +------------------------------------------ User owner
|           +---------------------------------------------- Link count
+---------------------------------------------------------- File type & permissions
```

And for a directory example:

```markdown
drwxr-xr-x   2   dorbsyfx   users   4.0K   Aug 22 06:15   folder1
|           |   |          |       |      |              |
|           |   |          |       |      |              +-- Directory name
|           |   |          |       |      +---------------- Last modified date/time
|           |   |          |       +----------------------- Size of directory metadata
|           |   |          +------------------------------- Group owner
|           |   +------------------------------------------ User owner
|           +---------------------------------------------- Link count
+---------------------------------------------------------- File type (d = directory) & permissions
```

So when you scan left to right: **type/permissions → links → owner → group → size → date → name**.

### Relative and Absolute Path

- **Absolute Path**: The full path from the root directory to the target file or directory. It always starts with a `/`.

  - Example: `/home/ec2-user/projects`

- **Relative Path**: The path relative to the current working directory. It does not start with a `/`.

  - Example: If you are in `/home/ec2-user`, the relative path to `projects` is simply `projects`.

### Package Manager

A package manager is a tool that automates the process of installing, updating, configuring, and removing software packages on a computer system. It helps manage dependencies and ensures that the correct versions of software are installed.

Checking Installed Text Editors
Run the following commands:

```bash
vim --version
nano --version
vi --version
```

If any editor is missing, install it using:

```bash
sudo yum install nano -y  # For RHEL-based Linux (Amazon Linux 2)
sudo apt install nano -y  # For Debian-based Linux (Ubuntu)
```

### Managing User Privileges with Sudo

The `sudo` command allows a permitted user to execute a command as the superuser or another user, as specified by the security policy. It is commonly used to perform administrative tasks without needing to log in as the root user.

Checking If a User Has Sudo Access:

```bash
id # uid=1000(dorbsyfx-sys-admin_svr) gid=1000(dorbsyfx-sys-admin_svr) groups=1000(dorbsyfx-sys-admin_svr),
```

Editing the Sudoers File Safely
To modify user permissions, use visudo:

```bash
sudo visudo   # Locate: %wheel  ALL=(ALL)       ALL
```

Adding a User to the Sudo Group

To grant full root privileges, add the user in the sudoers file:

```bash
ec2-user  ALL=(ALL)  ALL
```

Save and exit (Esc, then :wq).

### Understanding File and Directory Permissios in Linux

File and directory permissions in Linux determine who can read, write, or execute a file or directory. Permissions are represented by a string of characters, such as `-rwxr-xr--`, which can be broken down into three sets of permissions for the owner, group, and others.

#### 1. Linux File Permissions: The Basics

Each file and directory in Linux has three permission levels:

- Read (r) → Allows viewing the file content or listing a directory.
- Write (w) → Allows modifying the file content or adding/removing files in a directory.
- Execute (x) → Allows executing a file as a program or accessing a directory.

These permissions apply to three categories of users:

- Owner (User - u) → The user who created the file.
- Group (g) → A collection of users with shared access.
- Others (o) → Everyone else on the system.

#### 2. Viewing File and Directory Permissions

To check the permissions of files and directories, use:

```bash
ls -l
```

This command lists all files and displays their permissions.

Example Output

```bash
-rw-r--r-- 1 ec2-user ec2-user 1024 Feb 28 12:00 myfile.txt
```

Breaking it down:

| Symbol  | Meaning |
|---------|---------|
| `-` | Regular file (`d` for directory) |
| `rw-` | Owner has **read (r) and write (w)** permission |
| `r--` | Group has **read-only (r)** permission |
| `r--` | Others have **read-only (r)** permission |

The first character (- or d) represents whether it is a file (-) or directory (d). The next nine characters define the owner, group, and others permissions.

### 3. Modifying Permissions with chmod

The chmod command is used to change file and directory permissions.

Linux provides two ways to modify permissions:

- Absolute Mode (Using Numbers)
- Symbolic Mode (Using Letters)

Authored comprehensive technical documentation, including system configurations, root cause analyses (RCAs), and client-facing project plans, to ensure clarity, knowledge sharing, and seamless project handoffs.

#### A. Absolute Mode (Numeric)

Each permission type is assigned a number:

- `Read (r) = 4`
- `Write (w) = 2`
- `Execute (x) = 1`
- **Sum the values** to set permissions.

#### **Example: Changing Permissions**

1; **Give the owner read/write (6), group read-only (4), others no access (0)**:

```bash
chmod 640 myfile.txt
```

2; **Give full permissions to owner (7), read/execute to group (5), and others (5)**:

```bash
chmod 755 myscript.sh
```

### B. Symbolic Mode (Using Letters)

In **symbolic mode**, permissions are modified using letters.

**Syntax:**

```bash
chmod [User] [Operator] [Permission] filename
```

**User Types:**

- `u` → Owner
- `g` → Group
- `o` → Others
- `a` → All (Owner, Group, Others)

**Operators:**

- `+` → Add a permission
- `-` → Remove a permission
- `=` → Set exact permissions

#### Example: Modifying Permissions

1; **Grant execute (`x`) permission to the owner**:

```bash
chmod u+x myfile.txt
```

2; **Remove write (`w`) permission from the group**:

```bash
chmod g-w myfile.txt
```

3; **Set exact permissions for all**:

```bash
chmod a=r myfile.txt
```

### C. Changing Directory Permissions Recursively

If you need to modify **permissions for all files inside a directory**, use the `-R` option.

```bash
chmod -R 644 mydir
```

This applies **read/write permissions to the owner and read-only permissions to others** for all files inside `mydir`.

4; **Changing File Ownership with `chown`**

The `chown` command allows changing **the owner of a file or directory**.

**Syntax:**

```bash
chown new_owner filename
```

#### Example: Change File Owner

```bash
chown ec2-user myfile.txt
```

### Changing Both Owner and Group

```bash
chown new_owner:new_group myfile.txt
```

### Changing Ownership Recursively

To apply ownership change to all files inside a directory:

```bash
chown -R new_owner:new_group mydir
```

5; **Changing Group Ownership with `chgrp`**

The `chgrp` command changes **group ownership**.

**Syntax:**

```bash
chgrp new_group filename
```

#### Example: Change Group Ownership

```bash
chgrp developers myfile.txt
```

---

6; **Using Access Control Lists (ACLs) for Advanced Permissions**

Sometimes, the standard **owner/group/others** model is not enough. **ACLs (Access Control Lists)** allow assigning **specific** permissions to multiple users.

### **Viewing ACLs**

To check ACL permissions of a file or directory, use:

```bash
getfacl myfile.txt
```

### **Setting ACLs**

To **grant specific permissions** to a user:

```bash
setfacl -m u:ec2-user:rw myfile.txt
```

- `-m` → Modify ACL
- `u:ec2-user:rw` → **Grant read & write** to `ec2-user`

### **Removing ACL Entries**

```bash
setfacl -x u:ec2-user myfile.txt
```

### **Applying ACL Changes Recursively**

To apply changes to **all files inside a directory**:

```bash
setfacl -R -m u:ec2-user:rw mydir
```

---

### Creating and Managing User Accounts and Groups in Linux

Managing user accounts and groups is essential for maintaining system security and organization. Here’s a guide on how to create and manage users and groups in Linux.

#### 1. Understanding Users and Groups

Before we dive into commands, let's first understand what **users** and **groups** are in Linux.

##### Users

A **user** is an individual who can log into a Linux system. Each user has:

- **A unique username**
- **A user ID (UID)**
- **A home directory** (e.g., `/home/username`)
- **A default shell** (e.g., `/bin/bash`)

For example, on a Linux system:

```bash
/home/aj
/home/vijay
```

Here, **Aj** and **Vijay** are different users, each with a **personal home directory**.

##### Groups

A **group** is a collection of users with shared permissions. Groups make it easier to manage file permissions across multiple users.

Example:

```bash
- A **developers group** can include multiple users (`aj`, `vijay`), allowing them to share files and access common directories.
```

Now, let’s move on to **creating and managing user accounts**.

#### 2. Creating a New User

To create a user in Linux, use the **`useradd`** command.

#### **Syntax:**

```bash
useradd username
```

#### **Example: Creating a user named "aj"**

```bash
sudo useradd aj
```

Since this action modifies system files, **sudo privileges** are required.
