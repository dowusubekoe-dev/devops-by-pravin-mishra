# Assignment 1

## Task 1: Using ChatGPT as Your Learning Assistant

**_ChatGPT Prompt_**

"I am a beginner taking a DevOps course on Udemy, and I'm finding some networking concepts difficult.
Could you please explain what a protocol is in networking in very simple terms?
A real-life analogy would be really helpful for me to understand.

Finally, could you briefly explain why this concept is important for a DevOps role?"

![What-is-a-protocol-in-networking](/img/screenshot-1-chatgpt-prompt-on-protocol.PNG)

## Task 2: Internet and Networking

When someone in the USA visits **EpicReads** (hosted in Finland), their computer sends a request across the internet using **packet switching**—the data is broken into small packets, each finding the fastest route to Finland. Every server on the internet has an **IP address**, like a phone number, so the request knows precisely where to go. The communication follows the **TCP/IP** protocol: TCP ensures all packets arrive correctly and in order, while IP decides the best path to send them. Once the Finnish server receives the request, it responds using **HTTP** or **HTTPS** (the secure, encrypted version) to deliver the website content back to the USA. This whole process happens in milliseconds, making it feel instant to the user.

![User-accessing-website-from-USA](/img/access-website-in-finland-from-usa.png)

## Task 3: Application Architecture and Stack

### 1. EpicReads Bookstore: Two-Tier Architecture

In a two-tier architecture, the application is divided into two main logical layers: the client (frontend) and the server (database). The frontend communicates directly with the database to retrieve and manipulate data. This model is simpler but often less scalable and secure than a three-tier model, as the business logic is mixed between the frontend and the database.

#### Diagram: Two-Tier Architecture

![Two-Tier-Architecture](/img/two-tier-architecture.PNG)

#### Technologies & Tools for Two-Tier Architecture

- **Frontend (Client-side):** This is what the user sees and interacts with. In a two-tier model, it also contains the business logic for the application.
  - **React:** A popular JavaScript library for building user interfaces.
  - **Angular:** A comprehensive framework for building single-page applications.

- **Database (Server-side):** This is where the data is stored and managed.
  - **PostgreSQL:** A powerful, open-source object-relational database system.
  - **MongoDB:** A popular NoSQL database that stores data in flexible, JSON-like documents.

### 2. EpicReads Bookstore: Three-Tier Architecture

The three-tier architecture is a more common and robust model for web applications. It separates the application into three distinct logical and physical tiers: the frontend (presentation layer), the backend (application or logic layer), and the database (data layer). This separation makes the application more scalable, secure, and easier to maintain.

#### Diagram: Three-Tier Architecture

![Three-Tier-Architecture](/img/three-tier-architecture.PNG)

#### **Technologies & Tools for Three-Tier Architecture**

- **Frontend (Presentation Tier):** This layer focuses solely on the user interface and user experience.
  - **React:** A JavaScript library for building user interfaces.
  - **Angular:** A platform for building mobile and desktop web applications.

- **Backend (Application/Logic Tier):** This layer contains the core business logic of the application. It processes user requests, interacts with the database, and sends data back to the frontend.
  - **Node.js (with Express.js):** A JavaScript runtime environment that allows you to build server-side applications.
  - **Python (with Django or Flask):** Python is a versatile language, and frameworks like Django and Flask are popular for building web backends.

- **Database (Data Tier):** This tier is responsible for storing and managing the application's data.
  - **MySQL:** A reliable and popular open-source relational database.
  - **MongoDB:** A leading NoSQL database.

## Task 4: Domain Name and DNS (Basic Concepts)

DNS (Domain Name System) works like the internet’s phonebook—it translates easy-to-remember domain names (like `**epicreads.com**`) into machine-friendly IP addresses (like `**52.172.142.222**`) so users don’t have to memorize numbers.
A DNS record type called an `**A record**` in DNS plays a significant role here. The `**A record**` maps a domain name directly to an IPv4 address, ensuring that when someone types epicreads.com, their browser connects to the correct server at `**52.172.142.222**` on port 3000.

## Task 5: Visual Studio Code Setup (Hands-on)

![Visual-Studio-Code](/img/visual-studio-screenshot.PNG)

P.S. This post is part of the FREE DevOps for Beginners Cohort run by [Pravin Mishra](https://www.linkedin.com/in/pravin-mishra-aws-trainer/). You can start your DevOps journey for free from his [YouTube Playlist](https://www.youtube.com/playlist?list=PLVOdqXbCs7bX88JeUZmK4fKTq2hJ5VS89).
