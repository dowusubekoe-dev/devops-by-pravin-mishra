# Guide - Create Security Group & NACL

## Guidelines: Create Security Group
1. Go to **VPC Dashboard**.  
   In the AWS Console, search for **VPC** and open the **VPC Dashboard**.
2. Select **Security Groups**.
    In the left panel, click **Security Groups → Create security group**.
3. Set **Security Group Details**:
    - **Security group name:** `my-security-group`  
    - **Description:** `Security group for my VPC`  
    - **VPC:** Choose the custom VPC created earlier.
4. Click **Create security group**.
5. Configure Inbound Rules:
    - Select the security group you created.
    - Go to the **Inbound rules** tab → **Edit inbound rules**.
    - Add rules as needed (e.g., allow SSH [Port 22], HTTP [Port 80], HTTPS [Port 443]).
6. Save rules.
---

## Guidelines: Create Network ACL (NACL)
1. Go to **VPC Dashboard**.
    In the AWS Console, search for **VPC** and open the **VPC Dashboard**.
2. Select **Network ACLs**.
    In the left panel, click **Network ACLs → Create network ACL**.
3. Set **Network ACL Details**:
    - **Name tag:** `my-nacl`
    - **VPC:** Choose the custom VPC created earlier.
4. Click **Create network ACL**.
5. Configure Inbound and Outbound Rules:
    - Select the NACL you created.
    - Go to the **Inbound rules** tab → **Edit inbound rules**.
    - Add rules as needed (e.g., allow traffic on specific ports).
    - Similarly, go to the **Outbound rules** tab → **Edit outbound rules** and add necessary rules.
6. Save rules.
7. Associate NACL with Subnet:
    - Go to the **Subnet associations** tab → **Edit subnet associations**.
    - Select the subnet created earlier (e.g., `public-subnet-1`).
    - Click **Save associations**.

---