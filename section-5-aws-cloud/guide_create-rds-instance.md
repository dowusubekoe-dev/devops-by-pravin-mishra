# Guide - Create RDS Instance

## Create Subnet Group

1. Go to the AWS console --> **Aurora and RDS**
2. Click on **Create DB Subnet group** and assign a name to the subnet group. E.g. pospacktup-db
3. Add a meaningful description. E.g. Subnet group for MySQL
4. Select a previous created VPC. E.g. vpc-0afg73...
5. Next, select all the **Availability Zones** where the database needs to be deployed. E.g. **us-east-1a**, **us-east-1b**
6. Select subnets for the database, usually the **private** subnets must be selected.

![Create-DB-Subnet](/img/create-db-subnets.PNG)

7. Click on **Create** to create the DB subnet.

---

## Create RDS Database - MySQL

1. Click on **Databases** from the AWS console
2. There are two options to create a database;
    - Create database (creates a new database)
    - Restore from S3 (restores from a backup file)

![Create-DB-MySQL](/img/create-rds-database-msql.PNG)

3. Select the option: **Create database** and the pick **Full configuration**.
4. Select the database engine option: **MySQL** or any engine of your choice.
5. Pick the **Edition** and **Engine version** of the selected database Engine.
6. For **Templates**, choose based on the environment. For this project, select the **Free tier**.

![Create-Template-Availability](/img/create-template-availability.PNG)

7. Update the following fields under **Settings**
    - DB instance identifier: cloud-pod-mysql-db
    - Master username: rdsmaster
    - Credential management: Managed in AWS Secret Manager, Self managed

![Settings](/img/create-db-settings.PNG)

8. For this demo, I will go with **Master password** with the **Self managed** option.
9. Select a **DB Instace class** based on the project requirements.

![](/img/create-db-instance-class.PNG)

10. For the **Storage**, pick the **General Purpose SSD**

![](/img/create-db-storage.PNG)

11. Expand the **Additional storage configuration**
    - [x] Enable storage autoscaling
    - Maximum storage threshold = 1000
12. Update the **Connectivity**
    - [x] Do not connect to EC2 instance
    - [x] IPv4
    - Selected the created VPC for the project
    - Public Access Yes [] or No [x]
    - VPC Security Group: **Create new**
    - Database Authentication: **Password authentication**
13. Additional Database configuration
    - Database options
        - Initial database name: users
        - DB parameter group: default:mysql8.0
        - Option group: default:mysql-8-0
14. Additional monitoring settings.
    - [] Enhanced Monitoring (depends on the use case)
    - Leave the rest as default
15. Click on **Create**
        

