# **The EpicBook! – Ubuntu Installation, Configuration & Troubleshooting Guide**

## **Introduction**

This guide provides step-by-step instructions to install, configure, and troubleshoot **The EpicBook!** application on **Ubuntu Server** (20.04 / 22.04).

---

### **1. Prerequisites**

Ensure your Ubuntu server has:

* Ubuntu Server 20.04 or 22.04
* MySQL Server 5.7
* Node.js & npm
* Git
* Nginx
* Internet access
* `sudo` privileges

---

### **Step 1: Create a VPC**

* VPC CIDR: `10.0.0.0/16`

![Create-Epic-VPC](/img/create-epic-book-vpc-existing.PNG)

### **Step 2: Create Subnets**

| Subnet    | Type    | CIDR        | Purpose                      |
| --------- | ------- | ----------- | ---------------------------- |
| Public-A  | Public  | 10.0.0.0/24 | EC2                          |
| Public-B  | Public  | 10.0.1.0/24 | ALB HA (optional)            |
| Private-A | Private | 10.0.2.0/24 | RDS MySQL                    |
| Private-B | Private | 10.0.3.0/24 | RDS Multi-AZ (optional)      |

### **Step 3: Create an Internet Gateway**

![Create-Epic-IGW](/img/create-epic-book-igw.PNG)

* Attach it to the VPC.

### **Step 4: Route Tables**

* Public RT → 0.0.0.0/0 → IGW
* Private RT → 0.0.0.0/0 → (optional NAT Gateway for EC2 outbound)

---

## 1️⃣ **Create RDS Subnet Group for MySQL Database**

### Create Subnet Group

1. Go to the AWS console --> **Aurora and RDS**
2. Click on **Create DB Subnet group** and assign a name to the subnet group. E.g. `epic-book-subnet`
3. Add a meaningful description. E.g. Subnet group for MySQL
4. Select a previous created VPC. E.g. vpc-0afg73...
5. Next, select all the **Availability Zones** where the database needs to be deployed. E.g. **us-east-1a**, **us-east-1b**
6. Select subnets for the database, usually the **private** subnets must be selected.

![Create-DB-Subnet](/img/create-epic-book-rds-subnet.PNG)

7. Click on **Create** to create the DB subnet.

---

## 2️⃣ **Create AWS RDS MySQL 5.7 Database**

### Step 1: Create RDS Instance

* Engine: **MySQL 5.7**
* Instance class: `db.t3.micro` (free-tier eligible)
* Storage: 20GB GP3
* Multi-AZ: optional
* Subnet group → select **Private-A & Private-B**
* Public access → **No**
* Create a Security Group: `epic-book-db`

  * Allow inbound MySQL (3306) **from EC2 SG only**

![Create-Epic-DB-SG](/img/create-epic-book-db-sg.PNG)

### Step 2: Save these values (you’ll need them later):

* **DB endpoint**
* **DB username**
* **DB password**

---

## 3️⃣ **Create EC2 Server for Node.js + Nginx**

### Step 1: Launch EC2

* AMI: **Ubuntu**
* Type: `t2.micro`

![Create-EC2-Instance](/img/create-ec2-epic-book-web.PNG)

* Network: **Public Subnet-A**
* Security Group: `packtup-sg`. For this task, I used an existing security group

  * Inbound:

    * SSH → your IP only
    * HTTP → 80
    * Customize -> 8080

![Security-Group-Inbound](/img/updated-inbound-sg.PNG)

  * Outbound:

    * Allow all

![Security-Group-Outbound](/img/create-epic-book-sg-outbound.PNG)

---

## 4️⃣ **Install/Update System Packages on EC2**

### **Update packages**

```bash
sudo apt update && sudo apt upgrade -y
```

### **Install Nodejs**

```bash
sudo apt install nodejs
```

### **Install Git**

```bash
sudo apt install git -y
```

### **Clone Application**

```bash
git clone https://github.com/pravinmishraaws/theepicbook
cd theepicbook
```
---

## **Install MySQL Server 5.7 Pre Assignment Request**

Run the following commands to install and start **MySQL Server** (Ubuntu 24.04 uses MySQL 8.0 by default):

**Update and Upgrade System**

```bash
# 1. Update the system
sudo apt update
sudo apt upgrade -y
```

**Use Ubuntu 18.04 Packages (Bionic) to install MySQL 5.7 on Ubuntu 20.04**

In order not to run into OS compatibility issue, I decided to use Ubuntu 20.04 to achieve the installation of MySQL 5.7.


```bash
# Add Bionic repository temporarily
echo "deb http://archive.ubuntu.com/ubuntu bionic main universe" | sudo tee /etc/apt/sources.list.d/bionic-mysql.list

# Import the key
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32

# Update and install
sudo apt update
sudo apt install mysql-server-5.7

# Remove the temporary repository after installation
sudo rm /etc/apt/sources.list.d/bionic-mysql.list
sudo apt update
```

**Start MySQL**

```bash
sudo systemctl start mysql
sudo systemctl enable mysql
sudo systemctl status mysql
```

**Log into MySQL**

```bash
mysql -u root -p 'StrongPassword1234!

ALTER USER 'root'@'localhost' IDENTIFIED BY 'NewStrongPassword123!';

SHOW DATABASES;

EXIT;
```

**Install Node.js & npm**

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ~/.nvm/nvm.sh
nvm install v17
node -v

# nstall Project Dependencies

npm install
```

**Set Up MySQL Database**

Login to mysql

```bash
mysql -u root -p 'StrongPassword1234!
```

```bash
CREATE DATABASE bookstore;

EXIT;
```

Navigate to the project directory **~/theepicbook**


Update **config.json** with the correct MySQL username and password

```bash
sudo nano config.json
```

Run the database scripts from **~/theepicbook** directory

```bash
mysql -u root -p < db/BuyTheBook_Schema.sql
mysql -u root -p < db/author_seed.sql
mysql -u root -p < db/books_seed.sql
```

Start the application by running the command;

```bash
node server.js

# Enter the public ip and port in browser to launch the Epic Book website

http://<public-ip>:8080
```

**Set Up Nginx as a Reverse Proxy (Ubuntu)**

```bash
# Navigate to your project
cd ~/theepicbook

# Install Nginx
sudo apt update
sudo apt install nginx -y

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Check status
sudo systemctl status nginx
```

**Configure Nginx as a Reverse Proxy**

Edit the Nginx configuration file (replace with your actual domain or IP):

```bash
sudo nano /etc/nginx/conf.d/theepicbooks.conf
```

Paste the following configuration (modify as needed):

```bash
server {
    listen 80;
    server_name your_domain_or_IP;

    location / {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

**Restart Nginx**

```bash
sudo nginx -t    # Check for syntax errors
sudo systemctl restart nginx
```

**Start the application by running the command;**

```bash
node server.js

# Enter the public ip and port in browser to launch the Epic Book website

http://<public-ip>:8080
```

![Epic-Book-Nginx](/img/complete-epicbook-nginx.PNG)



