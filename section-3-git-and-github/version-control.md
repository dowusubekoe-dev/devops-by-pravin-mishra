# Introduction to Version Control

## 1. What is Version Control?

* **Version Control** is a system that manages different versions of files (e.g., code, documents).
* It keeps track of **changes over time**, allowing you to:

  * Collaborate with others.
  * View the history of changes.
  * Restore older versions if needed.

---

## 2. Understanding "Versions"

* A **version** is simply a new state of something after changes.
* **Examples:**

  * **Books**: A 2nd edition of a book with extra chapters is a new version.
  * **Apps**: Frequent WhatsApp updates (v2.21, v2.22, etc.) are versions with fixes/features.

---

## 3. Why Version Control?

* Helps **multiple developers work together** on the same project without overwriting each other’s work.
* Provides a **history of changes** (who made changes, what changed, when).
* Makes it possible to **revert to previous versions** if mistakes occur.
* Ensures the **safety of original code** by maintaining structured versions.

---

## 4. What is Git?

* **Git** = A **Version Control System (VCS)**.
* Also called a **Source Code Management System (SCM)**.
* With Git, developers can:

  * Track changes in code.
  * Create and manage multiple versions.
  * Work collaboratively without disturbing others’ code.

## 1. Git Provides Version Control

* **Version Control** = ability to track and manage changes in your code.
* Example:

  * When editing a document, you can **undo** changes to go back to an earlier version.
  * Git does the same for your code: it saves versions so you can **revert anytime**.
* 🔑 Benefit: If you make a mistake, you don’t have to start over—you can restore a previous version.

---

## 2. Git Supports Branching

* **Branching** = creating a **separate copy of code** to work independently from the main code.
* Each branch is isolated, meaning you can **experiment without risk**.
* Example:

  * You want to add a new feature to your website.
  * Instead of changing the main code directly, you create a **branch**, add and test your feature there.
  * Once ready, you merge it back into the main code.
* 🔑 Benefit: Safe experimentation and development of new features without breaking the original project.

---

## 3. Git Allows Merging

* **Merging** = combining changes from two branches into one unified version.
* Example:

  * You finish coding a feature in your branch.
  * Using **merge**, your changes are added to the **main branch**.
* 🔑 Benefit: Enables developers to work on different features simultaneously and later combine their work without losing changes.

---

## 4. Git Enables Collaboration

* **Collaboration** = multiple developers, stakeholders, and team members working on the same project.
* With Git:

  * Each team member can work on different parts of the code **at the same time**.
  * Git ensures changes don’t overwrite each other.
  * Team members can see updates, give feedback, and build together.
* 🔑 Benefit: Makes teamwork efficient, reduces conflicts, and keeps everyone aligned.

---

## 5. Basic Git Commands

* **Adding Files in Git Repository**

`Step 1: Open Git Bash (or Terminal)`
Make sure you are inside your Git repository. If not, navigate to it using:

```bash
cd path/to/your/repo
```

`Step 2: Create a New File`
To create a new file, we use the touch command followed by the file name.
Let's create an index.html file:

```bash
touch index.html
```

`Writing Code Inside the File`
You can open the file in any text editor (like VS Code, Notepad, etc.) and add some HTML code. For example:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mini Finance</title>
</head>
<body>
    <h1>Welcome to Mini Finance</h1>
    <p>This is a basic HTML file created inside a Git repository.</p>
</body>
</html>
```

* **Understanding Git Status**

`Step 1: Open Git Bash and Navigate to Your Repository`
First, make sure you're inside your Git repository. If not, navigate to it using:

```bash
cd path/of/repo
```

`Step 2: Run git status`
To check the current state of our repository, type:

```bash
git status
```

* **Using Git Add Staging**

To tell Git that we want to start tracking index.html, we add it to the staging area using:

```bash
git add index.html
```

Instead of adding files one by one, we can add all modified files at once using:

```bash
git add .
```

* **Using Git Commit**

The git commit command permanently records changes from the staging area into the repository.

* It saves your work in Git’s version history.
* It assigns a unique identifier (commit hash) to each change.
* It allows you to roll back changes if needed.
* It helps collaborators understand what changes were made.

When committing changes, we use the -m flag to provide a short description of the commit:

```bash
git commit -m "Add index.html with basic structure"
```

`Good commit message examples:`

```bash
git commit -m "Fixed navigation bar responsiveness"
git commit -m "Updated README with project setup instructions"
git commit -m "Refactored API response handling"
```

* **Viewing Git Log History**

`Step 1: Viewing Commit History`
To see a list of all commits in your repository, use:

```bash
git log
```

* **Git Branch**

A branch is a separate version of your project where you can make changes independently without affecting the main project.

By default, when we create a Git repository, Git automatically creates a default branch called master (or main in newer versions).

Think of it like this:

* The master branch is your main project—the stable, working version of your code.
* When you create a new branch, you get an exact copy of the master branch.
* You can now work on new features in this branch without touching the master code.

`Creating a Branch in Git`
To create a new branch, we use the git branch command:

```bash
git branch feature-xyz
```

This command creates a new branch named `**feature-xyz**` but does NOT switch to it yet.

`Checking the Created Branch`
To check if the branch was created, list all branches using:

```bash
git branch
```

Expected Output:

```bash
  feature-xyz
* master
```

The asterisk (*) indicates the current branch you are on.

`Access the Created Branch`

To navigate into the new created branch;

```bash
git checkout feature-xyz
```

The purpose of Git Branching are as follows;

* **Isolation**: Work on new features or bug fixes without affecting the main code.
* **Collaboration**
* **Track Changes**

* **Git Merge**

Merging is the process of combining changes from one branch into another.

The git merge command allows you to:
✔️ Combine changes from different branches into one.
✔️ Keep a clean and structured workflow when working in teams.
✔️ Integrate new features or bug fixes without disrupting the main code.

Think of git merge like merging two documents:

You have a main document (master branch).
A colleague works on a copy (feature branch) and makes improvements.
You merge the improved copy back into the main document.

`Step 1: Ensure Your Repository is Up-to-Date`
Before merging, always make sure you are on the main branch. Run:

```bash
git checkout main
```

✅ Expected Output:

```bash
Switched to branch 'main'
```

`Step 2: Merge a Branch into Main`
To merge another branch (e.g., develop) into master, use:

```bash
git merge develop
```

```bash
✅ Expected Output:

Updating 3f5b2d6..7c9a5f2
Fast-forward
 style.css | 10 +++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
 ```

`Step 3: Verify the Merge`
Check if the changes are now in main:

```bash
cat style.css
```

* **Handling Merge Conflicts**

1️⃣ Run `git merge <branch-name>` → Git will detect conflicts and stop merging.

2️⃣ Open the conflicting file in an editor (e.g., style.css). You’ll see something like this:

background-color: blue;
3️⃣ Manually edit the file and decide which version to keep. For example:

background-color: blue;
4️⃣ Stage and commit the resolved file:

```bash
git add style.css
git commit -m "Resolved merge conflict in style.css"
```

Now the merge is complete!

`Inspect history (nice graph)`
To visualize the commit history with branches and merges, use:

```bash
git log --oneline --graph --decorate --all
```

`(Optional cleanup)`
To delete a branch that has been merged, use:

```bash
git branch -d feature/contact-page
```

---

## 6. GitHub

* **GitHub** = A web-based platform that hosts Git repositories and allow software developers to manage andcollaborate on a project.

`**Git**` = Local Version Control (managing code on your computer).
`**GitHub**` = Remote Collaboration (hosting and sharing code online).

* **Key Features of GitHub:**

  * **Remote Repositories**: Store your code online, accessible from anywhere.
  * **Collaboration**: Work with others through pull requests, code reviews, and issue tracking.
  * **Version Control**: Integrates with Git to provide version control features.
  * **Project Management**: Tools for tracking tasks, bugs, and project progress.

* **Git Pull**
Is a command used to fetch and integrate changes from a remote repository into your local repository.
It combines two actions: fetching changes from the remote repository and merging them into your current branch.
To pull changes from a remote repository, use:

```bash
git pull origin main
```
