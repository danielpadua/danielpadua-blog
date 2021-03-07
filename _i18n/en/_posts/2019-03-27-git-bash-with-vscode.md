---
title: "Git-bash with vscode"
description: "Git Bash, Visual Studio Code: See how to configure git bash as default terminal in visual studio code"
date: 2019-03-27 12:00:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Tips]
tags: [visual studio code, git, git bash, windows, microsoft]
image:
  src: /assets/img/posts/git-bash-with-vscode/featured.png
  alt: Visual Studio Code logo with a plus sign followed by git logo
---


## Intro

Git-bash is a Windows application that emulates a Linux shell experience, and comes obviously with git program. In this guide I’ll demonstrate how to modify vscode’s integrated terminal to set **git-bash**. However, this guide can also be used to set **powershell** as vscode’s integrated terminal, once vscode comes with **cmd.exe** by default on Windows.

## Guide

1. [Install Git/Git Bash in your Windows](https://git-scm.com/downloads);

2. Open vscode and click: `File > Preferences > Settings`;

3. In `User Settings` tab, select: `Features` and then `Terminal`;

4. Search for the section named: `Integrated > Shell: Windows` and put the full path to git-bash executable, as it follows:

![Setting git-bash executable path in vscode integrated terminal](/assets/img/posts/git-bash-with-vscode/vscode_config.png)*Setting git-bash executable path in vscode integrated terminal*

Explaining what vscode does under the hood, if you open `settings.json` and manually edit it, you’ll see something like the following:

![Integrated terminal configuration](/assets/img/posts/git-bash-with-vscode/settings_json.png)*Integrated terminal configuration*

By setting this property, next time you open vscode’s integrated terminal, it will run **git-bash** instead of Windows’s cmd.

To set Powershell as integrated terminal, you just have to set Powershell full path in the same variable.

Hope it helps, see you soon!
