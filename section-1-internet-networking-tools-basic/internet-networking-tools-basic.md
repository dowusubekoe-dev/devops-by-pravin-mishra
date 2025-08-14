# Essential: Internet, Networking & Tools Basics

## Origins and History

- `**1960s**` by the United States Department of Defense.
- `**Communication**` system durind a nuclear attack.
- New version, emails, videos, online transactions, and more.
- `**Data transfer**` between `**two devices**`.

## Wnat is Network?

- To allow the communicatio between two devices, we need `**Internet**` connection.
- A device need to be connected to `**WiFi**` --> `**Router**` --> `**ISP**` (Connection of devices)
- `**Network**` is a **collection of device** that can talk to each other
- Communication is possible between two devices at different locations with the help of fibre-optics cables connected around the world.
- `**Internet**` is a **network** of **networks**
- Before data is transferred from one device to another, the `**Data**` is `**split into small packets**`.
- `**Routes**` then directs the `**packets**` to different path to reach the other device.
- Finally, at the `**destination**` the data is `**reassembled**`
- The whole process involving `**data spliting**`, `**routing of packets**` and `**reassembling of data at destination**`is termed as `**Packet Switching**`
  
### Rules that govern data transfer

- `**IP Address**` is a unique identifier for each device on the network.
- `**Protocols**` are a set of rules that govern how data is transmitted over a network.
- `**Internet Protocol (IP)**` handles addressing and routing.
- `**Transmission Control Protocol (TCP)**` ensures data is `**delivered correctly**` and in `**order**`.
- `**UDP**` is a connectionless protocol that allows data to be sent without establishing a connection first.
- `**HTTP**` is the foundation of data communication on the web.
- `**HTTPS (Hypertext Transfer Protocol Secure)**` is a secure version of HTTP, the protocol used for communication between a web browser and a website.

## Application Architecture & Stack

- `**Client-Server Architecture**` is a model where a client requests services from a server.

- `**Two-Tier Architecture**` consists of a `**client/frontend**` and a `**server/database**`.

![Two-Tier-App-Stack](/img/two-tier-application.PNG)

- `**Three-Tier Architecture**` adds a `**backend layer**` between the `**client/frontend**` and `**server/database**`.

![Three-Tier-App-Stack](/img/three-tier-application.PNG)

- `**Microservices Architecture**` breaks down an application into smaller, independent services that can be developed, deployed, and scaled independently.

![Microservices-App-Stack](/img/microservices-application.PNG)

### Technology Stack

`**Frontend**`

- Next.js (React framework for server-side rendering and routing)
- Tailwind CSS (For styling)
- Axios (for making API requests)
- React Context API (for global state management)

`**Backend**`

- Node.js & Express.js (For API development)
- MySQL & Sequelize (For database management)
- JWT (JSON Web Token) (For authentication)
- bcrypt.js (For password hashing)
- CORS (for cross-origin request handling)

`**Database**`

- MySQL (Relational database management system)

### Application Port

- Entry points of an application.

For example:

- Port 80: Web traffic (HTTP)
- Port 443: Secure web traffic (HTTPS)
- Port 22: Remote access through SSH

## Domain Name and DNS

### Domain Name

- A **domain name** is the `**human-readable address**` of a website.
- Helps with Branding, Professionalism and Trust.
- `**Domain Registrar: GoDaddy, Bluehost, AWS ROute 53 (for advanced users)

### Domain Name System

- The `**Domain Name System (DNS)**` translates domain names into IP addresses. The `**phonebook**` of the `**internet**`
- `**DNS Resolution Process**` is the process of converting a domain name into an IP address.

`**User --> Cache --> Resolver --> Root --> TLD --> Server --> IP**`

    - User enters website address
    - Check cache
    - Ask DNS Resolver (ISP)
    - Go to Root Server if DNS Resolver cannot find the ip address
    - Go to TLD (Top Level Domain Name Server) if Root Server is not able to find the ip address. A `**.com**` is the TLD.
    - Get IP address from an `**alternative server**` if the ip address can not be found in TLD.
    - Connects to the websites

### DNS Record Types

- `**A Record**`: Maps a domain name to an IPv4 address.
- `**AAAA Record**`: Maps a domain name to an IPv6 address.
- `**CNAME Record**`: Maps a domain name to another domain name.
- `**MX Record**`: Specifies the mail servers for a domain.
- `**TXT Record**`: Used to store text information for a domain.

## How to Use ChatGPT

- `**ChatGPT**` is a powerful AI tool that can help you with various tasks.
- `**Use Cases**`:
  - Code generation and debugging
  - Writing documentation
  - Answering technical questions
  - Learning new concepts

Example Question

`
I am currently learning DevOps and have enrolled in a course on Udemy that I plan to follow.
To he honest, I don't know much about DevOps yet, so I'll need your help from time to time while going through the course
When I ask questions please try to explain things in very simple language, preferably with some examples.
Now help me to understand what is the Difference between Two-Tier and Three-Tier Application Architecture.
`

Alright — let’s make this stick with a simple everyday analogy.

---

## Two-Tier Architecture → You talking directly to the chef

Imagine you walk into a small diner:

- You go straight into the **kitchen** (database) and tell the **chef** exactly what you want.
- The chef cooks it and hands it to you.

✅ **Pros:** Quick and direct.
❌ **Cons:** The kitchen gets crowded, and if customers mess up orders, it can cause chaos or accidents.

---

## Three-Tier Architecture → You talking to a waiter

Imagine a proper restaurant:

- **You** (client) tell the **waiter** (application server) what you want.
- The waiter understands your request, maybe asks clarifying questions, and passes it to the **chef** (database).
- The chef prepares the food and gives it to the **waiter**, who then serves it to you.

✅ **Pros:** Organized, scalable, and the kitchen is safe from customers.
❌ **Cons:** A bit more time and effort than going straight to the chef.

📌 **Memory tip:**

- **Two-Tier** = You’re in the kitchen yourself.
- **Three-Tier** = You place an order through a middleman.

- `**Tips for Effective Use**`:
  - Be specific in your questions
  - Provide context when necessary
  - Ask follow-up questions for clarification
  
## Troubleshoot Like a Pro with AI Tools

Question 1

`Hey I have a Lambda function that is triggered by IoT Core to process IoT data.
I can see that data is being received on teh MQTT topic, but for some reason, it's not triggering the Lambda function.

Below is the last AWS CLI command, I have used to create resource permission on Lambda

aws lambda add-permission \
    --function-name "anomaly_detector" \
    --region "eu-north-1" \
    --principal iot.amazonaws.com \
    --source-arn arn:aws:iot:en-north-1:533267262133:rule/anomaly_detection_lambda \
    --source-account "533267262133" \
    --statement-id "AllowIoTInvoke" \
    --action "lambda:InvokeFunction"

What could be the potential issues?

Solution is the arn information. Change en to eu

`

Question 2

`Hey I have another problem. I have a Lambda function that gets executed from IoT Core.  
This Lambda function processes IoT data. After that, it is supposed to fetch the Printer Profile from a DynamoDB table that contains the Printer profile.  
Then, based on certain metrics, it will update some fields in the Printer profile.

I am encountering the following error while the Lambda function is being invoked:

- Paste the error

- Paste code snippet

I would really appreciate any suggestions or thoughts.
`
