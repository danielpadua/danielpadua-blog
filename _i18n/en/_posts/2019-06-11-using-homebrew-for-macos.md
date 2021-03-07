---
title: "Using Homebrew for macOS"
description: "Homebrew, macOS: Learn what is it for, how to install and the usage of the package manager homebrew for macOS"
date: 2019-05-05 12:40:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Tips]
tags: [homebrew, macos, apple]
image:
  src: /assets/img/posts/using-homebrew-for-macos/featured.png
  alt: MacOS logo with a plus sign followed by homebrew logo
---

## Intro

[MacOS](https://pt.wikipedia.org/wiki/MacOS) is an operational system based on Unix kernel, and despite Apple provides an AppStore like some sort of [package manager](https://en.wikipedia.org/wiki/Package_manager), it lacks a lot of important stuff, specially if you are an advanced user or a developer. With this in mind, community created the [Homebrew or just brew project](https://brew.sh/), which is a command line package manager that owns a organised and very extensive repository of packages and apps (casks), and is widely used by Mac users.

In this guide I'll show how to install Homebrew and also some basic commands to install, remove and update packages and apps.

## Requirements

* Intel 64 bits processor

* macOS 10.12 or higher

* Command Line Tools (CLT) for Xcode (install it via AppStore or [https://developer.apple.com/downloads](https://developer.apple.com/downloads))

* A shell installation: default terminal (bash), [ksh](https://en.wikipedia.org/wiki/KornShell) or [zsh](https://en.wikipedia.org/wiki/Z_shell)

## Installing

With all requirements installed, brew installation is really easy. Brew is a [ruby](https://www.ruby-lang.org/pt) based project, so, just open your favorite terminal and execute the following command:
```shell
/usr/bin/ruby -e “$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
```

## Usage
With Homebrew installed in your machine, open the terminal and start using brew. Use the quick reference below to manipulate packages:

### Search for packages and casks
```shell
brew search ${package_or_cask_approximate_name}
```
### List installed packages
```shell
brew list
```

### Install package
```shell
brew install ${package_name}
```

### Remove package
```shell
brew remove ${package_name}
```

### Update package
```shell
brew upgrade ${package_name}
```

or to update all your packages (including homebrew itself)
```shell
brew upgrade
```

### Obtaining installed package information
```shell
brew info ${package_name}
```

Homebrew also has an extension named **cask**. Its goal is to provide the same experience of brew core, but for the installation of Mac desktop apps. The usage is quite similar to the previous commands:

### Install cask
```shell
brew install ${cask_name} --cask
```
### List all installed casks
```shell
brew list --cask
```

### Remove cask
```shell
brew remove ${cask_name} --cask
```

### Update cask
```shell
brew upgrade ${cask_name} --cask
```

or to update all your casks
```shell
brew upgrade --cask
```

### Obtaining installed cask information
```shell
brew info ${cask_name} --cask
```

Other thing that is worth a lot mentioning is the ability to manage daemons directly from brew, without using the native [launchctl](https://en.wikipedia.org/wiki/Launchd#launchctl).

### List executing services
```shell
brew services list
```

### Execute service
```shell
brew services run ${service_name}
```

### Stop service
```shell
brew services stop ${service_name}
```

### Restart service
```shell
brew services restart ${service_name}
```

## Conclusion
Homebrew eases the life of macOS users and specially those who are developers. As brew is a very mature and extensive software there may be other abilities not mentioned here in case you want to go deeper. Use the [documentation](https://docs.brew.sh/) for more information.

See you soon!
