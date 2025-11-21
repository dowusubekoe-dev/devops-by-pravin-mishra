# Deploy Mini Finance Website on AWS Virtual Machine

## Assignment: Deploy Mini Finance Website on AWS Virtual Machine

**Duration:** 60 minutes to complete

In this assignment, your task is to deploy the Mini Finance static website on an AWS EC2 virtual machine (Linux). 
This will help you gain hands-on experience with launching EC2 instances, installing and configuring a web server (like Nginx or Apache), and serving static content.

## Create VPC using Terraform

1. Create a file, `main.tf` and enter the code for the provider. ![Terraform Provider](https://developer.hashicorp.com/terraform/language/block/provider)

    - Enter the terraform code.

        ```tf
        terraform {
            required_providers {
                aws = {
                    source  = "hashicorp/aws"
                    version = "~> 4.0"
                }
            }
        }

        provider "aws" {
            region = "us-east-1"
        }
        ```

2. Update `main.tf` with code for creating a VPC.

        ```tf
        resource "aws_vpc" "mini_finance_vpc" {
            cidr_block = "10.0.0.0/16"
                tags = {
                    Name = "mini-finance-vpc"
                }
        }
        ```

![Create-VPC](/img/create-tf-vpc-mini-finance.PNG)

3. Next to update `main.tf` to create a public subnet.

        ```tf
        resource "aws_subnet" "mini_finance_public_subnet" {
            vpc_id            = aws_vpc.mini_finance_vpc.id
            cidr_block        = "10.0.1.0/24"
            availability_zone = "us-east-1b"
            map_public_ip_on_launch = true # instances launched into that subnet automatically receive a public IP
            tags = {
                Name = "mini-finance-public-subnet"
            }
        }
        ```
![Create-Subnet](/img/create-tf-subnet-mini-finance.PNG)

4. Create the Internet gateway for the VPC.

        ```tf
        resource "aws_internet_gateway" "mini_finance_igw" {
            vpc_id = aws_vpc.mini_finance_vpc.id
            tags = {
                Name = "mini-finance-igw"
            }
        }
        ```
![Create-IGW](/img/create-tf-igw.PNG)

5. Create the route table for the VPC.

        ```tf
        resource "aws_route_table" "mini_finance_public_subnet_rt" {
            vpc_id = aws_vpc.mini_finance_vpc.id

            route = {
                cidr_block = "0.0.0.0/0"
                gateway_id = aws_internet_gateway.mini_finance_igw.id
            }
            tags = {
                Name = "mini-finance-route-table"
            }
        }
        ```
![Create-RT](/img/create-tf-route-table-mini-finance.PNG)

6. Associate route table with subnet.

        ```tf
        resource "aws_route_table_association" "mini_finance_public_subnet_association_rt" {
            subnet_id     = aws_subnet.mini_finance_public_subnet.id
            route_table_id = aws_route_table.mini_finance_public_subnet_rt.id
        }
        ```
![Create-RT-Assoc](/img/create-tf-rt-assoc-mini-finance.PNG)

7. Create security group for both **Inbound** and **Outbound** traffic. Allow HTTP (port 80) and SSH (port 22) in the security group.

        ```tf
        resource "aws_security_group" "mini_finance_security_group_web" {
            name = "mini_finance_security_group_web"
            description = "Allow HTTP and SSH inbound traffic"
            vpc_id = aws_vpc.mini_finance_vpc.id

        # Inbound rules
            ingress {
                from_port   = 80
                to_port     = 80
                protocol    = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
            }

            ingress {
                from_port   = 22
                to_port     = 22
                protocol    = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
            }

        # Outbound rules
            egress {
                from_port   = 0
                to_port     = 0
                protocol    = "-1" # all protocols
                cidr_blocks = ["0.0.0.0/0"] # allow all outbound traffic
            }

            tags = {
                Name = "mini-finance-security-group"
            }
        }
        ```
![Create-SG](/img/create-tf-sec-grp-mini-finance.PNG)

8. Launch an EC2 instance and install nginx (Amazon Linux 2 or Ubuntu) in a public subnet.

        ```tf
            resource "aws_instance" "mini_finance_web_server" {
                ami = "ami-0f00d706c4a80fd93" # Amazon Linux 2 AMI (us-east-1)
                instance_type = "t2.micro"
                subnet_id = aws_subnet.mini_finance_public_subnet.id
                vpc_security_group_ids = [aws_security_group.mini_finance_security_group_web.id]
                key_name = "aws-iac-keypair" # replace with your key pair name

                user_data = <<-EOF
                            #!/bin/bash
                            sudo yum update -y
                            sudo yum install -y nginx git
                            sudo systemctl start nginx
                            sudo systemctl enable nginx
                            sudo rm -rf /usr/share/nginx/html/*
                            sudo git clone https://github.com/pravinmishraaws/mini_finance.git /tmp/mini_finance
                            sudo cp -r /tmp/mini_finance/* /usr/share/nginx/html/
                            EOF

                tags = {
                    Name = "mini-finance-web-server"
                }
            }

                output "ec2_instance_public_ip" {
                    description = "Public IP of the EC2 instance"
                    value       = aws_instance.mini_finance_web_server.public_ip
            }
            ```
![Create-EC2-Instance](/img/create-tf-ec2-mini-finance-web.PNG)

7. Start the web server and ensure the website is accessible via the EC2 public IP.

Please provide the following to complete your assignment:

Public IP URL:
Paste the public IP address of your EC2 instance.
Example: http://3.85.215.151/

![Final-TF-Script](/img/create-tf-final-script.PNG)


Screenshot of the Hosted Website:

![Mini-Finance-Deployment](/img/mini-finance-tf-successful.PNG)
