# Deploy React Application On Virtual Machine

In this project, I will be deploying a React application on an EC2 instance from a GitHub repository which will be accessed by users on a web browser.

## Create the EC2 Instance

1. Create an EC2 instance from the EC2 dashboard, name it `nginx-react-app`.

![Name-EC2](/img/name-instance.PNG)

2. For AMI (Amazon Machine Image), select a free-tier `Ubuntu Server 24.04 LTS`.

![Select-AMI](/img/select-ami-type.PNG)

3. Select key pair or create a new one.

![Keypair-Login](/img/select-keypair.PNG)

4. Configure network, subnet and security group for the nginx ec2 instance.
    - Port 22: Allow SSH connection from outside to the EC2 instance
        - For production purpose, restrict the **Source** to allow access from known IP addresses only.
    - Port 80: Allow users to access the React app from the browser.

![Network-Settings](/img/network-settings-nginx.PNG)

## SSH connection to the EC2 Instance

1. From the SSH client, navigate to the location of the private keypair file.

2. Run this command, if necessary, to ensure your key is not publicly viewable. `chmod 400 "aws-iac_keypair.pem"`

3. Run the SSH command, `ssh -i "aws-iac_keypair.pem" ubuntu@18.207.152.66`

![SSH-Connection-NGINX](/img/ssh-connection-nginx.PNG)

Connect to your instance using its Public IP: `http://18.207.152.66`

![Approve-SSH-Connection](/img/approved-ssh-connection.PNG)

## Automate the deployment of React App

1. Create a directory called **scripts** on the EC2 instance, `mkdir scripts`
2. Create a bash script to automate the deployment steps, `deploy-react.sh`
3. Make the script file executable, `chmod +x deploy-react.sh`
4. Load the `deploy-react.sh` file to the EC2 instance using `**scp**` command.
    - Navigate to the location of the keypair file
    - Run the command `scp -i aws-iac_keypair.pem /path/to/deploy-react.sh ec2-user@52.91.12.166:~/scripts` in your local terminal to copy file to the EC2 instance.

![SCP-Copy](/img/scp-copy-script.PNG)

5. Run the file, `./deploy-react.sh`

![Create-Deploy-Script](/img/create-deploy-script.PNG)

6. Deployment completed successfully

![Deployment-Successfully](/img/successful-deployment-info.PNG)

7. React App accessible via browser.

![React-App-Browser](/img/react-app-browser.PNG)
