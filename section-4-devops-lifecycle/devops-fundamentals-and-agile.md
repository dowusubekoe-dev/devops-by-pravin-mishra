# DevOps Lifecycle

A set of practices and principles that helps software developers and IT operations team work together more effectively. The goal of DevOps is to make the process of developing and delivering software faster, more efficient and more reliable.

## SDLC (Softwre Development Life Cycle)

The Software Development Life Cycle (SDLC) is a structured approach to software development that outlines the various stages involved in creating and maintaining software applications. The main phases of SDLC include:

1. **Brainstorming & Setting Goals**

    - Problem visualization
    - The need to solve or provide a solution

2. **Requirements Analysis & Plan (3 Months)**

    - Functional Requirements - Login page, Dashboard,Sign Up, Forget Password
    - Non-functional Requirements - HA, FT, SLA
    - SRS is also created (Software Requirement Specification)
    - Project Duration
    - Business/Stakeholder approval

3. **Design & Architecture (4 Months)**

    - Design system architecture (Monolithic/Microservices)
    - System Integration
    - UI/UX Design/Wireframing
    - Database architect (Design database schema)
    - Technical document creation to be used by the developer

4. **Coding & Implementation (6 Months)**

    - Backend logic development
    - Unit Test
    - Code review and refactoring

5. **Testing & QA (2 Months)**

    - Develop test cases
    - Integration testing
    - System testing
    - Report back to developer if bug is detected

6. **Deployment (2 Months)**

    - System Administrators
    - Setup environments
    - Smoke test for software validation

7. **Maintenace & Feedback**

    - Provide feeback
    - Plan maintenance procedure

## Key poinnts in Waterfall Model

1. Linear and sequential approach
2. Ease of management
3. Limited Flexibility

## Challenges in Waterfall Model

1. Inflexibility to changes
2. Delayed Feedback
3. Long Delivery Cycles
4. Difficult in Managing Uncertainty
5. Limited Collboration

## Agile Methodoloy

Agile focuses on creating software in small, repeated steps, getting quick feedback, and collaborating with different people involved in the process.

    - An Outcome-Driven Approach
    - Agile is a way of working
    - Agile is a Set of Values and Principles
    - A Cultural Shift in an organization
    - Agile is a Mindset

### Goal of Agile

    - Deliver working software frequently
    - Speed matters
    - Quality is key

## Lean Methodology

Lean is an approach that aims to deliver value to customers while reducing the waste and maximizing efficiency. It emphasizes finding ways to eliminate unecessary steps, streamline the process, and work collaboratively.

## Continuous Delivery (CD)

Continuous Delivery is a software development practice where code changes are automatically built, tested, and prepared for release to production. It allows teams to deliver updates to users quickly and reliably.

## Continuous Integration (CI)

Continuous Integration is a software development practice where developers frequently merge their code changes into a shared repository. Each integration is automatically tested to detect errors early, ensuring that the codebase remains stable and functional.

## DevOps

DevOps is a set of practices that combines software development (Dev) and IT operations (Ops). It aims to shorten the development lifecycle and provide continuous delivery with high software quality. DevOps emphasizes collaboration, automation, and monitoring throughout the entire software development process.

### Automation Monitoring at SDLC

1. Automation is a repetitive task
2. Collaboration improves communication and leading to faster feedback and resolve issues
3. Continuous Integration ensure changes works togehter. Continuous Delivery/Deploy is the process of automatically packaging and deploying these changes to Prodution to make them available for users
4. Infrastructure as Code is an approach where infrastructure resources like servers, networks, databases are managed.
5. Monitoring & Feedback is the continuously observing the performance of software applications in real time.

### Roles of DevOps Engineers

1. Collaboration and Communication
2. Automation and Scripting

Task                    AWS Service         Non-AWS Tool
Source Code Tool        AWS CodeCommit      Git, GitHub, GitLab
Build & Test            AWS CodeBuild       Jenkins
Deploy                  AWS CodeDeploy      Jenkins, Ansible, Kubernetes, Chef, Puppet, Docker
Monitor & Feedback      Amazon CloudWatch   Nagios, Splunk, ELK Stack
Automate Pipeline       AWS CodePipeline    Jenkins, Travis CI, GitLab

## Introduction to Jira

Jira is a popular tool used for project management and issue tracking, especially in software development. It helps teams plan, track, and manage their work effectively.

### Key Features of Jira

1. **Issue Tracking:** Create and manage tasks, bugs, and user stories.

2. **Project Management:** Organize work into projects, sprints, and backlogs.

3. **Custom Workflows:** Define and customize workflows to match your team's processes.

4. **Collaboration:** Comment on issues, share files, and mention team members.

5. **Reporting:** Generate reports and dashboards to track progress and performance.

6. **Integration:** Connect with other tools like Confluence, Bitbucket, and Slack.

### Scrum Elements

1. Product Backlog: A prioritized list of features, enhancements, and bug fixes that need to be addressed in the project.

2. Sprint Backlog: A subset of items from the product backlog that the team commits to completing during a specific sprint (usually 2-4 weeks).

3. Sprint Planning: A meeting where the team selects items from the product backlog to include in the sprint backlog and plans how to accomplish them.

4. Daily Stand-up: A short daily meeting where team members share updates on their progress, discuss any obstacles, and plan their work for the day.

5. Sprint Review: A meeting at the end of the sprint where the team demonstrates the completed work to stakeholders and gathers feedback.

6. Sprint Retrospective: A meeting where the team reflects on the sprint, discusses what went well, what could be improved, and plans for future improvements.

Product Owner
The Product Owner is responsible for defining the features and requirements of the product, prioritizing the product backlog, and ensuring that the team delivers value to stakeholders.

Scrum Master
The Scrum Master facilitates the Scrum process, helps the team adhere to Scrum practices, removes obstacles,
and ensures effective communication and collaboration within the team.

Development Team
The Development Team is a cross-functional group of professionals who are responsible for delivering the product increment during the sprint. They work collaboratively to design, develop, test, and deliver the product.

### What is Scrum?

- **Scrum** is a lightweight framework that helpd people, teams and organizations generate value through adaptive solutions for complex problems.

### Agile in real-world project with Scrum

Who is responsible for what? => **Scrum Roles**
How do we organize our work? => **Scrum Artifacts**
How do we track progress? => **Scrum Events**
How do we ensure we deliver value continuously? => **Sprints & Feedback Loops**
