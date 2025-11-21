# Configure the AWS Provider
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

# Create a VPC
resource "aws_vpc" "mini_finance_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "mini-finance-vpc"
    }
}

# Create Public Subnet
resource "aws_subnet" "mini_finance_public_subnet" {
    vpc_id            = aws_vpc.mini_finance_vpc.id
    cidr_block        = "10.0.5.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true # instances launched into that subnet automatically receive a public IP
    tags = {
        Name = "mini-finance-public-subnet"
    }
}

# Create Internet Gateway
resource "aws_internet_gateway" "mini_finance_igw" {
    vpc_id = aws_vpc.mini_finance_vpc.id
    tags = {
        Name = "mini-finance-igw"
    }
}

# Create Route Table
resource "aws_route_table" "mini_finance_public_subnet_rt" {
  vpc_id = aws_vpc.mini_finance_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mini_finance_igw.id
  }

  tags = {
    Name = "mini-finance-route-table"
  }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "mini_finance_public_subnet_association_rt" {
    subnet_id     = aws_subnet.mini_finance_public_subnet.id
    route_table_id = aws_route_table.mini_finance_public_subnet_rt.id
}

# Create Security Group
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

# Create EC2 Instance
resource "aws_instance" "mini_finance_web_server" {
    ami = "ami-0f00d706c4a80fd93" # Amazon Linux 2 AMI (us-east-1)
    instance_type = "t2.micro"
    subnet_id = aws_subnet.mini_finance_public_subnet.id
    vpc_security_group_ids = [aws_security_group.mini_finance_security_group_web.id]
    key_name = "aws-iac_keypair" # replace with your key pair name

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