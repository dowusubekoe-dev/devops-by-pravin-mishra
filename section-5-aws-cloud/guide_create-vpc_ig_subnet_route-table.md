# Create a VPC in AWS Account

- Click on **Create VPC**.

- Provide the name for the VPC

- For the IPv4 CIDR block, choose **IPv4 CIDR manual input**.

- Type in the customized **IPv4 CIDR**. E.g. **10.0.0.0/16**.

- For the IPv6 CIDR Block, choose **No IPv6 CIDR block** if no IPv6 is needed.

- For the **Tenancy** section, choose **Default** if resources run on hardware that will be shared with other AWS customers and **Dedicated** option if resources run on hardware dedicated solely to your AWS account.

- Create VPC

## Create Internet Gateway

- Navigate to **Internet Gateway**
- Provide a name for the internet gateway.
- Attached internet gateway to **VPC** and select the customized created VPC.

## Create Subnet

- Click on Create Subnet
- Choose the customized VPC created earlier
- 