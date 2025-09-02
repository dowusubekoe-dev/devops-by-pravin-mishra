# Questions & Answers

`**Q1: Why do developers use Git? Can you explain with an example?” Expected: Mentions version history, collaboration, branching, reverting mistakes.**`

Developers use Git because it keeps track of every change in a project and makes teamwork much easier.
For example, imagine a team building a web app: one developer creates a new feature branch to add a login page, while another works on fixing a bug in the main branch. Git records their changes in the version history, so nothing is lost. If the login feature breaks the app, Git allows the team to revert back to a stable version. Once the feature is ready, the developer can merge the branch into the main project without disturbing others’ work.

This way, Git helps with collaboration, safe experimentation, and recovering from mistakes.

`**Q2: What’s the difference between a local repo and a remote repo? How do you create a new branch and switch to it? Expected: Explains local vs GitHub; shows git checkout -b feature-xyz.**`

A local repo is the copy of your project that lives on your computer, while a remote repo (like GitHub, GitLab, or Bitbucket) is the shared version stored online so your team can collaborate.

```bash
git checkout -b feature-readme-update
```

`**Q3: What does the staging area do in Git? Can you give me the sequence of commands to add and commit a file? Expected: git status, git add, git commit -m "message".**`

The staging area in Git is like a buffer where you prepare changes before committing them. It lets you review and control exactly what will be saved in the next commit.

```bash
git status
git add filename.txt
git commit -m "Added new feature or fixed a bug"
```

`**Q4: Suppose you cloned Mini-Finance, made a change, and now want to share it with the team. What steps would you take? Expected: Mentions git push, creating a Pull Request, why PRs are important for review.**`

If I cloned Mini-Finance, made a change, and wanted to share it with the team, I’d do this:
Commit the change locally;

```bash
git add . git commit -m "Fixed bug in transaction summary"
```

Push the change to my branch on the remote repository git push origin my-feature-branch
Open a Pull Request (PR) on GitHub
Creating a Pull Request is important because it lets teammates review the code, suggest improvements, and catch potential issues before merging into the main branch. It ensures quality and keeps the project’s history clean.

`**Q5: If your teammate pushed changes to GitHub before you, how do you bring those changes into your local repo? Expected: Mentions git pull origin main or git fetch + git merge.**`

If my teammate pushed changes to GitHub before me, I’d bring them into my local repo like this:

1; The quick way:

```bash
git pull origin main
```

2; The safer way:

```bash
git fetch origin
git merge origin/main
```

This keeps my local repo in sync with the team’s changes before I continue working or pushing my own code.

`**Q6: What does the command,`**git init**`do?**`

Git init initializes a local Git repository in your current project directory by creating a hidden .git folder.
**`**
`**Q6: What does a pull request (PR) in GitHub represent?**`

A Pull Request (PR) in GitHub is a way to propose changes to a codebase. It allows developers to notify team members about changes they want to merge into the main project. PRs facilitate code review, discussion, and collaboration before the changes are integrated.
