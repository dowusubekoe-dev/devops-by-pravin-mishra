
# Guidelines: Create a VPC in AWS Account

1. Click on **Create VPC**.  
2. Provide a name for the VPC.  
3. For the **IPv4 CIDR block**, choose **IPv4 CIDR manual input**.  
4. Type in the customized **IPv4 CIDR**, e.g., `10.0.0.0/16`.  
5. For the **IPv6 CIDR Block**, choose **No IPv6 CIDR block** if no IPv6 is needed.  
6. For the **Tenancy** section:  
   - Choose **Default** if resources run on shared hardware.  
   - Choose **Dedicated** if resources run on hardware dedicated to your AWS account.  
7. Click **Create VPC**.  

---

## Guidelines: Create Internet Gateway

1. Navigate to **Internet Gateway**.  
2. Provide a name for the Internet Gateway.  
3. Attach the Internet Gateway to your **VPC** and select the custom-created VPC.  

---

## Guidelines: Create Subnet

1. Go to **VPC Dashboard**.  
   In the AWS Console, search for **VPC** and open the **VPC Dashboard**.  

2. Select **Subnets**.  
   In the left panel, click **Subnets → Create subnet**.  

3. Choose **VPC**.  
   From the dropdown, select the VPC you want to create the subnet in.  

4. Set **Subnet Details**:  
   - **Name tag:** `public-subnet-1`  
   - **Availability Zone:** Choose one (e.g., `us-east-1a`).  
   - **IPv4 CIDR block:** Enter a range within your VPC range, e.g., `10.0.1.0/24`.  

5. Click **Create subnet**.  
6. Choose the **custom VPC** created earlier.  

---

## Guidelines: Internet Gateway

1. Go to **VPC Dashboard**.  
   - Open the AWS Console → Search for **VPC** → Open **VPC Dashboard**.  

2. Select **Internet Gateways**.  
   - In the left panel, click **Internet Gateways → Create internet gateway**.  

3. Create IGW:  
   - **Name tag:** `my-igw`  
   - Click **Create internet gateway**.  

4. Attach to Your VPC:  
   - Select the IGW you created.  
   - Click **Actions → Attach to VPC**.  
   - Choose your VPC from the list → **Attach internet gateway**.  

---

## Guidelines: Create Route Table

1. Select **Route Tables**.  
   - In the left panel, click **Route Tables → Create route table**.  

2. Set **Route Table Details**:  
   - **Name tag:** `public-route-table`  
   - **VPC:** Choose the custom VPC created earlier.  

3. Click **Create route table**.  

---

## Guidelines: Create Route in Route Table

1. **Add Route to Internet Gateway**:  
   - Select the created route table → **Routes tab → Edit routes → Add route**.  
   - **Destination:**  
     - For IPv4: `0.0.0.0/0`  
   - **Target:** Select your **Internet Gateway (IGW)**.  

2. Save changes.
