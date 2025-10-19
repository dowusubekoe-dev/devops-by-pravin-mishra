# Upload Static Website Content Using AWS CloudFormation/CLI

- Download all website files or copy files to destination for website.

- Unzip files

- Navigate to the website directory

- Run the command ```aws s3 ls``` to list all the buckets in your AWS account

- Copy the name of the bucket name you want to use

- Run the command ```aws s3 sync . s3://bucket-name``` to upload website content to S3 bucket

- Go into the bucket **Properties** tab, scroll down to **Static website hosting**.

- Click on **Edit** to and set **Static website hosting** to **Enable**

- Go down to **Index document** and the home or default page. E.g `index.html`. Save Changes.

- Next go to the **Permissions** tab and scroll down to **Block public access (bucket settings)**

- Edit and remove the checkbox for **Block all public access**. Type **confirm** in the popup box to save changes

- Still under **Permissions**, scroll down to **Bucket policy**, edit and type in the policy below. Make sure to replace **Resource** with the actual bucket name.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::your-bucket-name/*"
            ]
        }
    ]
}
```
- Save the changes and try accesss the **website endpoint** in the browser.