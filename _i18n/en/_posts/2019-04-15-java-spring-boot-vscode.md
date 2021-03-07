---
title: "Java Spring Boot + Vscode"
description: "Visual Studio Code, Java, Spring Boot: See how to configure visual studio code for java development, creating a spring boot project as example"
date: 2019-04-15 12:00:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Java, Spring Boot]
tags: [java, spring boot, visual studio code]
image:
  src: /assets/img/posts/java-spring-boot-vscode/featured.png
  alt: Java and spring logo with a plus sign followed by visual studio code logo
---

To learn how to configure a development environment for .NET core with vscode see: [Vscode + ASP.NET Core: Setup development environment](/posts/vscode-aspnet-core-setup-development-environment).

## Intro

I've been work a lot with Java lately and as most of the developers of this language I was using [eclipse](https://www.eclipse.org/). Despite personally considering it a good [IDE](https://en.wikipedia.org/wiki/IDE), I've been attracted using vscode as my main development tool for its flexibility, lightweight and cool extensions that brings agility to development. So, I've decided to adventure myself trying to develop Java using vscode and ended up enjoying the experience, even though there's still some deficiencies so it might not fully replace a full fledged IDE like eclipse or even [IntelliJ IDEA](https://www.jetbrains.com/idea/).

The github repository of all code here is available at: [https://github.com/danielpadua/java-spring-vscode-example](https://github.com/danielpadua/java-spring-vscode-example)

## Requirements

To follow this guide, it's required to have installed in your machine:

* [Java JDK 8](https://www.oracle.com/technetwork/pt/java/javase/downloads/jdk8-downloads-2133151.html) or higher

* [Vscode](https://code.visualstudio.com/Download)

## Installing Java Support Extensions

To run correctly Java projects in vscode, it will be necessary to install some extensions. There are already some extensions packages that group the essentials, so, open your vscode and click in the extensions tab, search and install the followings items:

* [Java Extension Pack](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack)

![Java Extension Pack](/assets/img/posts/java-spring-boot-vscode/java_extension_pack.png)*Java Extension Pack*

This extensions package contains the essentials to go out there and start to develop Java in vscode. Functionalities like: Code navigation, auto-complete, refactor, main code snippets, debbuger and others.

* [Spring Boot Extension Pack](https://marketplace.visualstudio.com/items?itemName=Pivotal.vscode-boot-dev-pack)

![Spring Boot Extension Pack](/assets/img/posts/java-spring-boot-vscode/spring_boot_extension_pack.png)*Spring Boot Extension Pack*

This extensions package contains the essentials to help develop Spring Boot projects. Tools like: Spring Boot Initializr (eases spring-boot projects creation), Spring Boot Dashboard (vscode tab that provides a spring-boot projects explorer in your workspace) and others.

After installing these extensions, remember to open the command palette and run a *Reload Window* (`ctrl+shift+p` => windows/linux or `cmd+shift+p` => mac) and type "Reload Windows" and press Enter key.

## Create a project with Spring Initializr

After installing the required extensions we will create a sample Spring Boot project using [Spring Initializr](https://start.spring.io/) for vscode. Once again, open command palette and type: "spring" and select the option: "Spring Initializr: Generate a Maven Project"

![](/assets/img/posts/java-spring-boot-vscode/spring_boot_initializr_vscode.png)

* Select Java as Language

* Put in Group-Id something like: `br.com.danielpadua`

* In Artifact-Id put something like: `java-spring-vscode-example`

* Select the most recent and stable Spring-Boot version (At the time of writing of this guide it is: 2.1.4)

* Do not select any dependency, just hit Enter key

* Select a folder to nest the project, I suggest you to create a folder named "projects" in the home folder of your user

With the project created, go to vscode explorer and open the folder we just created. Vscode will try to initialise the extensions and update project's Maven dependencies, So you will have to wait until it finishes:

![This might take a while, be patient!](/assets/img/posts/java-spring-boot-vscode/maven_updating.png)*This might take a while, be patient!*

With this all set, your opened project must be something like this:

![Vscode + Java](/assets/img/posts/java-spring-boot-vscode/vscode_working_with_java.png)*Vscode + Java*

Just make a small fix in `pom.xml` file: in dependencies section, change the `artifactId` of `org.springframework.boot` from: **spring-boot-starter** to: **spring-boot-starter-web** and save the file. This will force maven to search for the artifact that knows how to work with REST APIs or MVC.

## Writing a Hello World

Now let's write a Controller that will simply return a HttpStatus 200 OK with the classic Hello-World message, take the opportunity to test: intellisense, code navigation and others that are commonly used.

* In your project explorer, right click over "javaspringvscodeexample" and add a new folder named "controllers" and inside of it, a file named: `ExampleController.java`. Type "class", and use the snippet:

![Class creation snippet for ExampleController.java](/assets/img/posts/java-spring-boot-vscode/vscode_java_class_snippet.png)*Class creation snippet for ExampleController.java*

Notice that the tab: "Java Dependencies" shows a package view very similar that Eclipse shows.

Create a Hello-World this way:
```java
package br.com.danielpadua.javaspringvscodeexample.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * ExampleController
 *
 * @author Daniel Padua
 */
@RestController
@RequestMapping("api/example")
public class ExampleController {

	@GetMapping("/hello-world")
	public ResponseEntity<String> get() {
		return ResponseEntity.ok("Hello World!");
	}
}
```

## Executing the project

Now execute the project using the tab "spring-boot-dashboard":

![Running App!](/assets/img/posts/java-spring-boot-vscode/vscode_running_spring_boot.png)*Running App!*

At this moment, your Spring Boot App is already up and running in port 8080 (default port). Open your browser and navigate to: [http://localhost:8080/api/example/hello-world](http://localhost:8080/api/example/hello-world), and you'll see this:

![Hello Java Spring Boot World!](/assets/img/posts/java-spring-boot-vscode/hello_world_java_vscode.png)*Hello Java Spring Boot World!*

To run in debug mode, you only have to navigate to debug panel and add a default configuration:

![](/assets/img/posts/java-spring-boot-vscode/debug_java_vscode.png)

The file below will be added in a hidden folder (.vscode) as it follows:

![](/assets/img/posts/java-spring-boot-vscode/launch_json_java_vscode.png)

From this moment on, you can click the Run green button for your app run in debug mode. Define your breakpoints and enjoy debug:

![Debugging Java with vscode](/assets/img/posts/java-spring-boot-vscode/debugging_on_java_vscode.png)*Debugging Java with vscode*

## Conclusion

It is possible to work with Java and Spring-Boot with vscode and still have some development agility close to famous IDEs like eclipse and IntelliJ IDEA. However, there is still a lot space to improve when it comes to java support and its extensions, in order to fully replace these IDEs.

See you soon!
