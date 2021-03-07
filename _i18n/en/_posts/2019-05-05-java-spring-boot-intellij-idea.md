---
title: "Java Spring Boot + IntelliJ IDEA"
description: "IntelliJ IDEA, Java, Spring Boot: Learn how to create a java spring boot project from scratch using intellij idea as IDE"
date: 2019-05-05 12:20:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Java, Spring Boot]
tags: [java, spring boot, intellij idea]
image:
  src: /assets/img/posts/java-spring-boot-intellij-idea/featured.png
  alt: Java and spring boot logo with a plus sign followed by intellij idea logo
---

## Intro
To those who develop in java nowadays, it’s almost impossible to miss [Spring](https://spring.io/) framework and more specifically [Spring Boot](https://spring.io/projects/spring-boot). Using this [development stack](https://en.wikipedia.org/wiki/Solution_stack), we gain more productivity and agility from small to large sized java projects. In this guide I’ll demonstrate how to install, configure IntelliJ IDEA and create a simple Hello-World using java, IntelliJ IDEA and spring boot.

The github repository of the example project of this post, can be found at: [https://github.com/danielpadua/java-spring-idea-example](https://github.com/danielpadua/java-spring-idea-example)

## Requirements
* Java JDK 8 or higher

## Installing IntelliJ IDEA
Use the following sections based in which operational system you’ll be using:

### Windows
In Windows we have 2 options:

* Direct download

  Go to [jetbrains download page](https://www.jetbrains.com/idea/download/#section=windows), select the latest version (on the writing date of this guide is the **2019.1.1**) and install it using NNF (next, next and finish).

* Using a [package manager](https://en.wikipedia.org/wiki/Package_manager) ([Chocolatey](https://chocolatey.org/))

  If you don’t know *Chocolatey*, take a look [at this post](/posts/using-chocolatey-for-windows).

Open *powershell* and install IntelliJ IDEA using the following command line:
```powershell
choco install intellijidea-community
```

### Linux
In Linux we also have 2 options:

* Direct download

  Go to [jetbrains download page](https://www.jetbrains.com/idea/download/#section=linux), select the latest version (on the writing date of this guide is the **2019.1.1**), extract the `.tar.gz` file and execute the `/bin/idea.sh` file.

* Using a [package manager](https://en.wikipedia.org/wiki/Package_manager)

  Depending in which Linux distro you are using, you’ll use a different package manager. For instance, [debian based distros](https://en.wikipedia.org/wiki/Category:Debian-based_distributions), like the popular [ubuntu](https://www.ubuntu.com/), use [apt-get](https://www.debian.org/doc/manuals/apt-howto/ch-apt-get.pt-br.html). For [Red Hat (or RHEL) based distros](https://en.wikipedia.org/wiki/Red_Hat_Enterprise_Linux_derivatives) use [yum](https://pt.wikipedia.org/wiki/Yellowdog_Updater,_Modified) or [dnf](https://en.wikipedia.org/wiki/DNF_(software)). Search the best way to install IntelliJ IDEA using your package manager.

### macOS
In macOS we have 2 options again:

* Direct download

  Go to [jetbrains download page](https://www.jetbrains.com/idea/download/#section=mac), select the latest version (on the writing date of this guide is the **2019.1.1**) and install it as usual, dragging the app from the *.dmg* file to the apps folder of your mac.

* Using a [package manager](https://en.wikipedia.org/wiki/Package_manager) ([Homebrew](https://brew.sh/))

  If you don’t know *Homebrew*, take a look [at this post](/posts/using-homebrew-for-macos)

Open your favorite terminal and install IntelliJ IDEA using the following command line:
```shell
brew cask install intellij-idea-ce
```

## Configuring IntelliJ IDEA
With IntelliJ IDEA installed, the configuration is pretty simple. When you execute IDEA you will be questioned about some configurations like: theme color, shortcut key mapping and plugins. Let’s leave default config and begin.

## Creating the project
As soon as it starts, you’ll see the following screen:

![IntelliJ IDEA initial screen](/assets/img/posts/java-spring-boot-intellij-idea/intellij_initial_screen.png)*IntelliJ IDEA initial screen*

For this example, we’ll be using [Maven](https://maven.apache.org) as [build-tool](https://en.wikipedia.org/wiki/Build_automation).

Unfortunately using IntelliJ IDEA Community, [according to the documentation](https://www.jetbrains.com/help/idea/spring-boot.html), there’s no support to create Spring Boot projects using Spring Initializr through the IDE in Community version, only in the Ultimate Edition. So, we have two choices that we can explore:

### Use Spring Initializr Web
Access: [https://start.spring.io](https://start.spring.io/), and fill the fields like below:

![Configuring project creation in Spring Initializr](/assets/img/posts/java-spring-boot-intellij-idea/spring_initializr.png)*Configuring project creation in Spring Initializr*

Don’t forget to select *Web* as dependency. Click *Generate Project* to download the project *zip* file. Extract it to a directory of your choice, go back to IntelliJ IDEA and select *Import Project*. Navigate to project’s directory and select the `pom.xml` file. You’ll see a window that is responsible for importing the Maven project, leave the defaults configs:

![Import Spring Initializr project](/assets/img/posts/java-spring-boot-intellij-idea/importing_spring_initializr_project.png)*Import Spring Initializr project*

Select the project to import and click *next*:

![Select the project](/assets/img/posts/java-spring-boot-intellij-idea/select_project.png)*Select the project*

In the next screen, set the JDK version that you installed:

![Select the JDK version for the project](/assets/img/posts/java-spring-boot-intellij-idea/select_jdk.png)*Select the JDK version for the project*

In the next screen confirm the project name and click *finish*.

### Creating a Maven project and add Spring manually
In IntelliJ IDEA’s initial screen, select *Create New Project*, located on the left side tab and select *Maven*, on the right side, select the JDK version and click *next*:

![Creating a Maven project](/assets/img/posts/java-spring-boot-intellij-idea/creating_maven_project.png)*Creating a Maven project*

When selecting the archetype, IntelliJ IDEA will assume that you will use Quickstart archetype, which is ok for our goal.

In the next screen specify the GroupId, ArtifactId and the Version and click *next*:

![Maven configuration](/assets/img/posts/java-spring-boot-intellij-idea/maven_config.png)*Maven configuration*

After you just have to name your project and click *finish*:

![Naming the project](/assets/img/posts/java-spring-boot-intellij-idea/naming_project.png)*Naming the project*

With the project created, configure `pom.xml` according to the following snippet:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>2.1.4.RELEASE</version>
		<relativePath/> <!-- lookup parent from repository -->
	</parent>
	<groupId>br.com.danielpadua</groupId>
	<artifactId>java-spring-idea-example</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<name>java-spring-idea-example</name>
	<description>Demo project for Spring Boot</description>

	<properties>
		<java.version>1.8</java.version>
	</properties>

	<dependencies>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>

		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>
	</dependencies>

	<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>
		</plugins>
	</build>

</project>
```

After updating `pom.xml` a notification will pop-up at the bottom right corner of the screen:

![Import pom.xml changes](/assets/img/posts/java-spring-boot-intellij-idea/maven_import.png)*Import pom.xml changes*

Click *Import Changes* for *Maven* refresh all project dependencies.

Now we’ll create a class that will contain the main function of the project. Remember that creating a class in default package is not a good java practice, so, click in source folder main/java and create a package:

![Creating a package](/assets/img/posts/java-spring-boot-intellij-idea/creating_package.png)*Creating a package*

Write the name of the package, in my example was: `br.com.danielpadua.java_spring_idea_example`, and create a class inside this package named `ExampleApplication.java`, and write the following code:

```java
package br.com.danielpadua.java_spring_idea_example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ExampleApplication {
    public static void main(String[] args) {
        SpringApplication.run(ExampleApplication.class, args);
    }
}
```

Don’t forget the unit tests main class too, repeat package creation step and create a class named: `ExampleApplicationTests.java` and write the code:

```java
package br.com.danielpadua.java_spring_idea_example;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class ExampleApplicationTests {
    @Test
    public void contextLoads() {
    }
}
```

At this moment we’ll have basically the same project structure that is generated by *Spring Initializr* at the section above.

## Completing the project
With the basic project skeleton created, we just have to create a package to nest the controller that will contain Hello World endpoint. Right click the root package:

![Creating a package for the controllers](/assets/img/posts/java-spring-boot-intellij-idea/creating_package_controllers.png)*Creating a package for the controllers*

Write: *controllers* and confirm. Inside the generated package, create a class named: `ExampleController.java` and write the code:

```java
package br.com.danielpadua.java_spring_idea_example.controllers;

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

Run the project by right clicking over the main class `Application.java` and select the option `Run ‘Application.main()’`:

![Running the app](/assets/img/posts/java-spring-boot-intellij-idea/running_app.png)*Running the app*

After clicking run, you should see the output in the *Run* tab located at screen’s bottom:

![Spring initialization log](/assets/img/posts/java-spring-boot-intellij-idea/spring_initialization_log.png)*Spring initialization log*

To test the app, you only have to open your favorite browser and access: [http://localhost:8080/api/example/hello-world](http://localhost:8080/api/example/hello-world), and you should see the *Hello World* message:

![Voilá](/assets/img/posts/java-spring-boot-intellij-idea/voila.png)*Voilá*

## Conclusion
IntelliJ IDEA is the most used IDE for java nowadays and it’s probably the most complete in the opinion of many developers. Community version is a great alternative to traditional eclipse.

See you soon!
