
# Assignment Objective:

You’ve already deployed a static HTML site on Amazon Linux. Now, it’s time to deploy:

- This real React app using Ubuntu
- And serve it with Nginx from your VM's public IP.


What You'll Need:
A running Ubuntu VM (cloud or local)

Basic knowledge of Linux commands

Internet access from the VM


Install Software & Application Modification:
Install Node.js & npm

sudo apt update  
sudo apt install -y nodejs npm  
node -v && npm -v
Install and Start Nginx

sudo apt install -y nginx  
sudo systemctl start nginx  
sudo systemctl enable nginx  
Clone the React App Repo

git clone https://github.com/pravinmishraaws/my-react-app.git  
cd my-react-app  


Open the App.js file

Navigate to your React app’s source folder:

cd my-react-app/src
Open the App.js file in a text editor:

nano App.js
(or use vi/vim if you prefer)

Modify the content

                      <h2>Deployed by: <strong>Your Full Name</strong></h2>

                      <p>Date: <strong>DD/MM/YYYY</strong></p>


                     Update your details like: Your Full Name & Date



Build Application for Production:
Install Dependencies & Build App

npm install  
npm run build  
Serve React App via Nginx

sudo rm -rf /var/www/html/*  
sudo cp -r build/* /var/www/html/  
sudo chown -R www-data:www-data /var/www/html  
sudo chmod -R 755 /var/www/html  
Configure Nginx
Replace the default config:

echo 'server {
  listen 80;
  server_name _;
  root /var/www/html;
  index index.html;
 
  location / {
    try_files $uri /index.html;
  }
 
  error_page 404 /index.html;
}' | sudo tee /etc/nginx/sites-available/default > /dev/null
 
sudo systemctl restart nginx
Test the App
Get your public IP:

curl ifconfig.me
Access it in your browser:
http://<your-public-ip>


How to Submit Your Assignment?
Live Cohort Students:
If you are part of the live cohort, please follow the assignment submission guidelines as explained here.



Self-Paced on Udemy:

If you are taking the course self-paced on Udemy, submit the assignment by clicking “Next” and answering the provided questions.


Questions for this assignment
- Execute the deployment task correctly.

- Capture and include accurate screenshots for each key step.

- Post about your application URL on LinkedIn with short explanation, what you achieved.


General Rules:

- Create a single Google Doc for your assignments.

- Add the assignment solutions exactly as requested.


Get the View Link to the document:

- Click Share (top-right corner).

- Under General access, change from “Restricted” to Anyone with the link.

- Set access to Viewer.

- Click Copy Link and paste it in the Google form/udemy.