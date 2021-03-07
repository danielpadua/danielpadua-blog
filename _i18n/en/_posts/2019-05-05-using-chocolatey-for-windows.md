---
title: "Using Chocolatey for Windows"
description: "Chocolatey, Windows: Learn what is it for, how to install and the usage of the package manager chocolatey for windows"
date: 2019-05-05 12:30:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Tips]
tags: [chocolatey, windows, microsoft]
image:
  src: /assets/img/posts/using-chocolatey-for-windows/featured.png
  alt: Windows logo with a plus sign followed by chocolatey logo
---

## Intro

Well, let's begin with the basic question: "What would Chocolatey be?". Just as simple as the question, is the answer: "It is a package manager developed for Windows".

Yes, we have now (not exactly now, because this project has been rolling approximately since 2014) a package manager for Windows like [apt-get](https://en.wikipedia.org/wiki/APT_(Package_Manager)) or [yum](https://en.wikipedia.org/wiki/Yum_(software)) for Linux, or [Homebrew](https://en.wikipedia.org/wiki/Homebrew_(package_management_software)) for Mac. And just as the mentioned, we can use it in [infrastructure automation tools (or IaC — Infrastructure as code)](https://en.wikipedia.org/wiki/Infrastructure_as_code) like [Puppet](https://puppet.com/), [Chef](https://www.chef.io/) or [Ansible](https://www.ansible.com/).

## Requirements
* Windows 7 or higher / Windows Server 2003 or higher

* Powershell v2 or higher

* .NET Framework 4 or higher (the Chocolatey installation will try to install this dependency in case you don't have it)

## Installing
First thing to do is run as administrator [Powershell](https://en.wikipedia.org/wiki/PowerShell) or [Cmd](https://en.wikipedia.org/wiki/Cmd.exe), to do so, search for *Powershell* or *Cmd* in Start Menu, right button click and select "Run as Administrator".

For Powershell use the following command line:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```
For Cmd use this command line:
```shell
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

## Usage
And… done, the installation was just that. Now let's have a look at the basic commands to manage packages:

### Search packages
```powershell
choco search $package_approximate_name
```
or visit [https://chocolatey.org](https://chocolatey.org/) and search

### List installed packages
```powershell
choco list --local-only
```

### Installing packages
```powershell
choco install $package_name
```
*note.: Use -y if you wish to ignore the confirmation messages*

### Removing packages
```powershell
choco uninstall $package_name
```
*note.: Use -y if you wish to ignore the confirmation messages*

### Updating packages
```powershell
choco upgrade $package_name
```

to update all your packages use:
```powershell
choco upgrade all
```
*note.: Use -y if you wish to ignore the confirmation messages*

## Conclusion

Chocolatey came to ease our life as Windows users and specially Windows administrators. Also made Windows environments more viable when using [devops](https://en.wikipedia.org/wiki/DevOps) CI/CD tools.

See you soon!
