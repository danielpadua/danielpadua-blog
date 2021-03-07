---
title: "Java Spring Boot + Eclipse"
description: "Eclipse, Java, Spring Boot: Learn how to create a java spring boot project from scratch using eclipse as IDE"
date: 2019-05-05 12:10:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Java, Spring Boot]
tags: [java, spring boot, eclipse]
image:
  src: /assets/img/posts/java-spring-boot-eclipse/featured.png
  alt: Java and spring boot logo with a plus sign followed by eclipse logo
---

## Intro

To those who develop in java nowadays, it’s almost impossible to miss [Spring](https://spring.io/) framework and more specifically [Spring Boot](https://spring.io/projects/spring-boot). Using this [development stack](https://en.wikipedia.org/wiki/Solution_stack), we gain more productivity and agility from small to large sized java projects. In this guide I’ll demonstrate how to install, configure eclipse and create a simple Hello-World using java, eclipse and spring boot.

The github repository of the example project of this post, can be found at: [https://github.com/danielpadua/java-spring-eclipse-example](https://github.com/danielpadua/java-spring-eclipse-example)

## Requirements

* Java JDK 8 or higher

## Installing Eclipse

> It’s also worth to mention that installing [Spring Tool Suite (STS)](https://spring.io/tools) instead of pure eclipse, is highly valid. STS is basically eclipse configured with [spring tools](https://marketplace.eclipse.org/content/spring-tools-4-spring-boot-aka-spring-tool-suite-4) plugin, optimized for spring framework development

Use the following sections based in which operational system you’ll be using:

### Windows

In Windows we have 2 options:

* Direct download

  Go to [eclipse download page,](https://www.eclipse.org/downloads/packages) select the latest version (on the writing date of this guide is the [**4.10**](https://www.eclipse.org/downloads/packages/release/2019-03/r/eclipse-ide-enterprise-java-developers) and install it using NNF (next, next and finish).

* Using a [package manager](https://en.wikipedia.org/wiki/Package_manager) (Chocolatey)

  If you don’t know *Chocolatey*, take a look [at this post](/posts/using-chocolatey-for-windows).

  Open *powershell* and install eclipse using the following command line:
  ```powershell
    choco install eclipse
  ```

### Linux
In Linux we also have 2 options:

* Direct download

  Go to [eclipse download page](https://www.eclipse.org/downloads/packages), select the latest version (on the writing date of this guide is the [**4.10**](https://www.eclipse.org/downloads/packages/release/2019-03/r/eclipse-ide-enterprise-java-developers), extract the *.tar.gz* file and execute the *eclipse* file.

* Using a [package manager](https://en.wikipedia.org/wiki/Package_manager)

  Depending in which Linux distro you are using, you’ll use a different package manager. For instance, [debian based distros](https://en.wikipedia.org/wiki/Category:Debian-based_distributions), like the popular [ubuntu](https://www.ubuntu.com/), use [apt-get](https://www.debian.org/doc/manuals/apt-howto/ch-apt-get.pt-br.html). For [Red Hat (or RHEL) based distros](https://en.wikipedia.org/wiki/Red_Hat_Enterprise_Linux_derivatives) use [yum](https://pt.wikipedia.org/wiki/Yellowdog_Updater,_Modified) or [dnf](https://en.wikipedia.org/wiki/DNF_(software)). Search the best way to install eclipse using your package manager.

### macOS
In macOS we have 2 options again:

* Direct download

  Go to [eclipse download page](https://www.eclipse.org/downloads/packages), select the latest version (on the writing date of this guide is the [**4.10**](https://www.eclipse.org/downloads/packages/release/2019-03/r/eclipse-ide-enterprise-java-developers) and install it as usual, dragging the app from the *.dmg* file to the apps folder of your mac.

* Using a [package manager](https://en.wikipedia.org/wiki/Package_manager) ([Homebrew](https://brew.sh/))

  If you don’t know *Homebrew*, take a look [at this post](/posts/using-homebrew-for-macos)

  Open your favorite terminal and install eclipse using the following command line:
  ```shell
  brew cask install eclipse-ide
  ```

### Configuring eclipse
With eclipse installed, I suggest you to open it and start getting used with the [GUI](https://en.wikipedia.org/wiki/Graphical_user_interface) and also the [shortcut keys](https://www.vogella.com/tutorials/EclipseShortcuts/article.html).
> *If you installed Spring Tool Suite, it’s not necessary to follow the installation of Spring Tools below*

### Spring Tools
In order to have a better development experience with Spring, I recommend you to install the eclipse plugin: `Spring Tools`. Go to menu `Help > Eclipse Marketplace…` and search for spring:

![Installing Spring Tools](/assets/img/posts/java-spring-boot-eclipse/installing_spring_tools_eclipse.png)*Installing Spring Tools*

Install the latest version of *Spring Tools* (on the writing date of this guide it is the 4.2.1) and restart eclipse.

## Creating the project
With everything correctly configured, it’s time to create our project. Go to menu: `File > New > Project…` and select the option `Spring starter Project` which is located below `Spring Boot` menu, as the following image:

![Starting the project](/assets/img/posts/java-spring-boot-eclipse/starting_project.png)*Starting the project*

For this example, I’ll be using [Maven](https://maven.apache.org) as [*build-tool*](https://en.wikipedia.org/wiki/Build_automation).

Fill the fields with the name of your artifact and groupId, and select the *Type* field as *Maven*:

![Starting the project using Maven](/assets/img/posts/java-spring-boot-eclipse/start_project_maven.png)*Starting the project using Maven*

After clicking next, we’ll have to especify which version of *Spring* we will be using. Select the latest stable version (on the writing date of this guide it’s the 2.1.4). As dependency, only select the *Web* and click *Finish*.

![Select Spring version and dependencies](/assets/img/posts/java-spring-boot-eclipse/spring_version_dependencies.png)*Select Spring version and dependencies*

Project created, now it’s time to create a *Controller* with a endpoint that will return a fixed String with the value: “Hello-World”. Right click the main package and select `New > Class`:

![Creating a class](/assets/img/posts/java-spring-boot-eclipse/creating_class.png)*Creating a class*

And create a class named “ExampleController” and fill the suffix of the package with “.controllers”, so a package named *controllers* will be created and nest your class, and it will group other controllers:

![Creating ExampleController](/assets/img/posts/java-spring-boot-eclipse/creating_examplecontroller.png)*Creating ExampleController*

Use the code below to create the endpoint that will return “Hello-World!”:

```java
package br.com.danielpadua.java_spring_eclipse_example.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * ExampleController
 *
 * @author danielpadua
 *
 */
@RestController
@RequestMapping("/api/example")
public class ExampleController {

	@GetMapping("/hello-world")
	public ResponseEntity<String> get() {
		return ResponseEntity.ok("Hello World!");
	}
}
```

Run the project by clicking the button **Boot Dashboard** and then the tab **Boot Dashboard** at the bottom of the screen. Select the name of your project and click the run button:

![Running the project](/assets/img/posts/java-spring-boot-eclipse/running_project.png)*Running the project*

After clicking run button, you will see the output log of spring initialisation in console tab:

![Spring initialisation log](/assets/img/posts/java-spring-boot-eclipse/spring_initialization_log.png)*Spring initialization log*

To test the project, you only have to open your favorite browser and access: [http://localhost:8080/api/example/hello-world](http://localhost:8080/api/example/hello-world) and you should be seeing the *Hello World* message:

![Voilà](/assets/img/posts/java-spring-boot-eclipse/voila.png)*Voilà*

## Conclusion
Eclipse and Spring Tool Suite (STS) are greate IDEs for developing robust java and spring based applications, and due to the stability of the tool, it ends up being super easy the ‘start’ of a simple project.

See you soon!
