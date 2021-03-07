---
title: "Java + Lombok"
description: "Lombok, Java: Find out what lombok is for, how to install and use it with the main java IDEs and also several practical examples of use"
date: 2019-05-05 12:00:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Java]
tags: [java, lombok]
image:
  src: /assets/img/posts/java-lombok/featured.png
  alt: Java logo with a plus sign followed by lombok project logo
---

## Intro
I always heard comments from other developers things like: “Java is a very verbose language”, or Hello World line count comparison between Java vs Other X Language. And I also think that this is true, when you develop pure Java (without extensions, libs and plugins) compared to other modern languages, the developer ends up writing more to reach the goal. However, since some time ago, we have a lib called [lombok](https://projectlombok.org/) that helps you simplify (a lot) the life of those who develop with java.

## Features
*Lombok* is a lib that provides a collection of annotations that eases some repetitive java tasks (such as, getters and setters creation). Besides of being dependency of your project, it connects in your IDE making it understand the annotations, so it requires a certain configuration. In this guide I’ll show how to configure it on [eclipse](https://www.eclipse.org/), [intellij idea](https://www.jetbrains.com/idea/) and also [vscode](https://code.visualstudio.com/). If you don’t know how to work with java with **vscode** take a look [at here](/posts/java-spring-boot-vscode).

The github repository with the sample classes can be found at: [https://github.com/danielpadua/lombok-examples](https://github.com/danielpadua/lombok-examples)

## Requirements
* Java JDK 8 or higher
* Eclipse or IntelliJ IDEA or vscode

## IDE configuration
Use the sections below according to the IDE you are using:

### Eclipse
Download latest *lombok.jar* at: [https://projectlombok.org/download](https://projectlombok.org/download), store this file in some directory of your choice (e.g.: your user’s home folder). From this moment on, there are two ways of configuring eclipse:

1. Run the *lombok.jar* jar. It will open a window that will search in all folders of your machine looking for IDEs and if it finds eclipse it will display a checkbox to enable. So, click install and it will be done, as the image below:

![Lombok’s eclipse installation via jar](/assets/img/posts/java-lombok/lombok_eclipse_installtion.png)*Lombok’s eclipse installation via jar*

2. If method 1 didn’t work or didn’t found any IDE, we will do the same work jar does under the hood but manually. Open the `eclipse.ini` file located under the configuration directory of the eclipse that you use, and edit it as below:

![Configuring lombok in eclipse manually](/assets/img/posts/java-lombok/configuring_lombok_eclipse_manually.png)*Configuring lombok in eclipse manually*
```
-javaagent:${full_path}/lombok.jar
```

We are just adding the full path of lombok’s jar as eclipse’s initialisation argument, and this will make it understands lombok. Lombok’s jar does exactly the same thing, but it copies the jar inside of eclipse installation folder and writes `eclipse.ini` automatically.

### IntelliJ IDEA
It’s really simple enable Lombok support in IntelliJ IDEA, to do so, open plugin installation section and install the highlighted plugin:

![Lombok Plugin for IntelliJ IDEA](/assets/img/posts/java-lombok/lombok_plugin_intellij.png)*Lombok Plugin for IntelliJ IDEA*

Restart IntelliJ IDEA and Lombok support will be enabled.

### vscode
Search for lombok at the extensions tab:

![Searching for lombok plugin in vscode](/assets/img/posts/java-lombok/lombok_plugin_vscode.png)*Searching for lombok plugin in vscode*

Install the Gabriel Basilio Brito’s extension, which is recommended by lombok: [https://projectlombok.org/setup/vscode](https://projectlombok.org/setup/vscode). Restart vscode:

![Lombok working in vscode](/assets/img/posts/java-lombok/lombok_working_vscode.png)*Lombok working in vscode*

## Project
First we need to create a java spring-boot project, so:

* To create a java spring-boot in eclipse follow this guide: [here](/posts/java-spring-boot-eclipse).

* To create a java spring-boot in intellij idea follow this guide: [here](/posts/java-spring-boot-intellij-idea).

* To create a java spring-boot in vscode follow this guide: [here](/posts/java-spring-boot-vscode).

After creating the project, use the sections below depending on the build-tool that you are using:

### Maven
Add lombok’s dependency in `pom.xml`:
```xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.6</version>
    <scope>provided</scope>
</dependency>
```

*You may need to force maven import update on your IDE*.

### Gradle
Add lombok’s depedency in `build.gradle` file:
```groovy
repositories {
  mavenCentral()
}

dependencies {
  compileOnly ‘org.projectlombok:lombok:1.18.6’
  annotationProcessor ‘org.projectlombok:lombok:1.18.6’
}
```

## Usage
Now let’s explore what *lombok* has to offer for us to reduce [boilerplate code](https://en.wikipedia.org/wiki/Boilerplate_code):

### Getters, Setters, Constructors, ToString, Equals e HashCode
To enable getter in all fields of your class, annotate above your class name: `@Getter`.

To enable setter in all fields of your class, annotate above your class name: `@Setter`.

To create a constructor with all fields as input parameter, annotate above your class name: `@AllArgsConstructor`, without parameters: `@NoArgsConstrutor`, with required fields (or non-null): `@RequiredArgsConstructor`

To implement default `toString()` use: `@ToString`,

To implement default `equals()` and `hashCode()` use: `@EqualsAndHashCode`

The `@Data` annotation above class is a shortcut to: `@ToString`, `@EqualsAndHashCode`, `@Getter`, `@Setter` and `@RequiredArgsConstructor` together.

Without lombok:

```java
package br.com.danielpadua.lombok_examples;

public class Dog {
	private Integer id;
	private String name;
	private String breed;

	public Dog(Integer id, String name, String breed) {
		this.id = id;
		this.name = name;
		this.breed = breed;
	}

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBreed() {
		return breed;
	}
	public void setBreed(String breed) {
		this.breed = breed;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((breed == null) ? 0 : breed.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Dog other = (Dog) obj;
		if (breed == null) {
			if (other.breed != null)
				return false;
		} else if (!breed.equals(other.breed))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Dog [id=" + id + ", name=" + name + ", breed=" + breed + "]";
	}
}
```

With lombok:

```java
package br.com.danielpadua.lombok_examples;

import lombok.Data;
import lombok.NonNull;

@Data
public class Dog {
	@NonNull
	private Integer id;
	@NonNull
	private String name;
	@NonNull
	private String breed;
}
```

### [Immutable classes](https://stackoverflow.com/questions/3162665/immutable-class)
Use the annotation: `@Value` above the class, to make it immutable

Without lombok:

```java
package br.com.danielpadua.lombok_examples;

public class DogCreateRequest {
	private final String name;
	private final String breed;

	public DogCreateRequest(final String name, final String breed) {
		this.name = name;
		this.breed = breed;
	}

	public String getName() {
		return name;
	}

	public String getBreed() {
		return breed;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((breed == null) ? 0 : breed.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DogCreateRequest other = (DogCreateRequest) obj;
		if (breed == null) {
			if (other.breed != null)
				return false;
		} else if (!breed.equals(other.breed))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "DogCreateRequest [name=" + name + ", breed=" + breed + "]";
	}
}
```

With lombok:

```java
package br.com.danielpadua.lombok_examples;

import lombok.Value;

@Value
public class DogCreateRequest {
	String name;
	String breed;
}
```

### [Builder pattern](https://en.wikipedia.org/wiki/Builder_pattern)
Use the annotation: `@Builder` above the class to create the builder pattern

Without lombok:

```java
package br.com.danielpadua.lombok_examples;

import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class Kennel {
	private Integer id;
	private String name;
	private Set<Dog> dogs;

	public Kennel(Integer id, String name, Set<Dog> dogs) {
		this.id = id;
		this.name = name;
		this.dogs = dogs;
	}

	public static KennelBuilder builder() {
		return new KennelBuilder();
	}

	public static class KennelBuilder {
		private Integer id;
		private String name;
		private HashSet<Dog> dogs;

		KennelBuilder() {
		}

		public KennelBuilder id(Integer id) {
			this.id = id;
			return this;
		}

		public KennelBuilder name(String name) {
			this.name = name;
			return this;
		}

		public KennelBuilder dog(Dog dog) {
			if (this.dogs == null) {
				this.dogs = new HashSet<Dog>();
			}
			this.dogs.add(dog);
			return this;
		}

		public KennelBuilder dogs(Collection<? extends Dog> dogs) {
			if (this.dogs == null) {
				this.dogs = new HashSet<Dog>();
			}
			this.dogs.addAll(dogs);
			return this;
		}

		public KennelBuilder clearDogs() {
			if (this.dogs != null) {
				this.dogs.clear();
			}
			return this;
		}

		public Kennel build() {
			Set<Dog> dogs = Collections.unmodifiableSet(this.dogs);
			return new Kennel(this.id, this.name, dogs);
		}

		@Override
		public String toString() {
			return "KennelBuilder [id=" + id + ", name=" + name + ", dogs=" + dogs + "]";
		}
	}
}
```

With lombok:

```java
package br.com.danielpadua.lombok_examples;

import java.util.Set;
import lombok.Builder;
import lombok.Singular;

@Builder
public class Kennel {
	private Integer id;
	private String name;
	@Singular
	private Set<Dog> dogs;
}
```

### Logging
Slf4j is one of the supported log interfaces, take a look at: [https://projectlombok.org/features/log](https://projectlombok.org/features/log) to see all the supported

Without lombok:

```java
package br.com.danielpadua.lombok_examples;

public class App
{
	private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(App.class);

    public static void main( String[] args )
    {
        log.info( "Hello World!" );
    }
}
```

With lombok:

```java
package br.com.danielpadua.lombok_examples;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class App {

	public static void main(String... args) {
		log.info("Hello world");
	}
}
```

## Conclusion
Despite the setup and configuration time spent, *lombok* was developed aimed to boost productivity of java developers. I’ve been using this lib for some time and I’m not thinking of stopping using it!

See you soon!
