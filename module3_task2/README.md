# Module 1: Introduction to DevOps: Automate Everything to Focus on What Really Matters

## Learning Objectives

* This project aims at showing use cases where a DevOps mindset is bringing
*to a software project by automating it,
* which decreases the amount of manual work and increases the development
*It focuses on why automation is useful and helps speeding a development lifecycle.

---
Read

Understand the value of automating tedious tasks
Define a development lifecycle
Automate shell-like tasks with Make, and/or shell script
Be aware of tools dependencies and the value of reproducing environment
Build static HTML website from Markdown code using Go-Hugo

## Prerequisites

* The following elements are required In addition to the previous module
* (“Module 0: Linux Fundamentals, Code management with Git,
* GitHub and the GitFlow pattern”) prerequisites.

## Concepts

### Shell terminal basics, using command lines

* Navigating in a Unix file-system
* Understanding how stdin/stdout redirection and piping
* Showing and searching the content of a text files
* Defining and using Environment Variables
* Adding command lines to your terminal using
* the apt-get package manager and/or with the PATH variable
* Writing and executing a shell script

### Git with the command line (and also a graphical interface)

* Retrieving or creating a repository
* Manipulating changes locally with Git’s 3 steps process (workspace, staging, history)
* Distributing changes history with remotes repositories

### Make/Makefile usage

* Executing tasks through make targets
* Default target and PHONY target
* Makefile’s variables and macro syntax

## Tooling

* A shell terminal with bash, zsh or ksh, including
* the standard Unix toolset (ls, cd, etc.) with:
* .GNU Make in version 3.81+
* .Git (command line) in version 2+
* .Go Hugo v0.80+
* The student needs to be able to spawn up a clean Ubuntu 18.04 system
* Therefore Docker is recommended with NO prior knowledge
* A text editor or IDE (Integrated Development Editor) of your convenience
* (Visual Code, Notepad++, Vim, Emacs, IntelliJ, etc.)

##  Development Lifecycle with Makefile

## following make file use `make` <command>

Files|Tasks
---|---
Build | Generate the website from the markdown and configuration files in the directory dist/.
Clean | Cleanup the content of the directory dist/
Post | Create a new blog post whose filename and title come from the environment variables POST_TITLE and POST_NAME.

### Write a Makefile to implement these steps for the actual Go-Hugo website’s source code.

## Workflow 

* Build Workflow 

## Target

* unit-tests
* package
* lint
* integration-tests
* clean
* build
* validate
* post
* help
* lint: ## to execute a static analysis to lint this code.
* lint	Lints the shell script setup.sh and on success runs
* make yamllint and lints markdown FILES
* markdownlint	lints the README.md and DEPLOY.md files

## Author

Karren - [Github https://github.com/klmana ]
