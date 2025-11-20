# Guide - SSH Connection to EC2 & Install HTTPD

1. Navigate to AWS Console --> Dashboard
2. Go to EC2 instances (Make sure it is running with 2/2 check passed)
3. Check the box for the name of the instance and copy the **public ip address** under **Details** tab
4. Open an SSH client: **PUTTY** or **Git Bash**
5. Locate your private key file. E.g demo-packtup_keypair.pem
6. Run this command, if necessary, to ensure your key is not publicly viewable.
    `chmod 400 "demo-packtup_keypair.pem"`
7. Connect to your instance using its Public IP: E.g 123.223.42.148
    - `ssh -i "demo-packtup_keypair.pem" ec2-user@123.223.42.148`
8. Run the command `sudo yum update` to load new updates
9. Install `httpd` by typinng the command `sudo yum install httpd -y`
10. To start the httpd server, run `sudo systemctl start httpd`
11. Check the status of httpd `sudo systemctl status httpd`
12. Try and access the httpd server `http://public-ip-address-of-ec2-instance`
