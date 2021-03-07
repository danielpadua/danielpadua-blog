---
title: "Java Spring Boot + IntelliJ IDEA"
description: "IntelliJ IDEA, Java, Spring Boot: Aprenda a criar do zero um projeto java com spring boot utilizando o intellij idea como IDE"
date: 2019-05-05 12:20:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Java, Spring Boot]
tags: [java, spring boot, intellij idea]
image:
  src: /assets/img/posts/java-spring-boot-intellij-idea/featured.png
  alt: Logotipo do java e do spring boot com um sinal de soma, seguidos pelo logotipo do intellij idea
---

## Introdução
Para quem desenvolve java atualmente é praticamente impossível passar despercebido o framework [Spring](https://spring.io/) e especificamente o [Spring Boot](https://spring.io/projects/spring-boot). Utilizando esta [stack de desenvolvimento](https://en.wikipedia.org/wiki/Solution_stack), ganhamos muita facilidade e agilidade de desenvolvimento em projetos java de pequeno a grande porte. Neste guia irei demonstrar como instalar, configurar o IntelliJ IDEA e criar um simples Hello-World.

O repositório do projeto exemplo deste artigo encontram-se em: [https://github.com/danielpadua/java-spring-idea-example](https://github.com/danielpadua/java-spring-idea-example)

## Pré-Requisitos
* Java JDK 8 ou superior

## Instalando o IntelliJ IDEA
Utilize as seções abaixo de acordo com o sistema operacional que estiver utilizando:

### Windows
Para Windows temos 2 opções:

* Download direto

  Vá para [a seção de downloads do site da jetbrains](https://www.jetbrains.com/idea/download/#section=windows), selecione a última versão (na data de escrita deste guia é a **2019.1.1**) e instale utilizando NNF (next, next, finish).

* Utilizando um [gerenciador de pacotes](https://pt.wikipedia.org/wiki/Sistema_gestor_de_pacotes) ([Chocolatey](https://chocolatey.org/))

  Caso não conheça o *Chocolatey*, veja [este artigo](/pt/posts/utilizando-chocolatey-para-windows).

Abra o *powershell* e instale o IntelliJ IDEA utilizando a linha de comando abaixo:
```powershell
choco install intellijidea-community
```

### Linux
Para Linux temos 2 opções:

* Download direto

  Vá para [a seção de downloads do site da jetbrains](https://www.jetbrains.com/idea/download/#section=linux), selecione a última versão (na data de escrita deste guia é a **2019.1.1**) e extraia o arquivo `.tar.gz` e execute o arquivo: `/bin/idea.sh`.

* Utilizando um [gerenciador de pacotes](https://pt.wikipedia.org/wiki/Sistema_gestor_de_pacotes)

  Dependendo da [distribuição de Linux](https://pt.wikipedia.org/wiki/Distribui%C3%A7%C3%A3o_Linux) que você possui, você utilizará um gerenciador de pacotes diferente. Por exemplo, para [distros baseadas em debian](https://en.wikipedia.org/wiki/Category:Debian-based_distributions), como o popular [ubuntu](https://www.ubuntu.com/), use o [apt-get](https://www.debian.org/doc/manuals/apt-howto/ch-apt-get.pt-br.html). Para [distros baseadas em Red Hat (ou RHEL)](https://en.wikipedia.org/wiki/Red_Hat_Enterprise_Linux_derivatives) use o [yum](https://pt.wikipedia.org/wiki/Yellowdog_Updater,_Modified) ou [dnf](https://en.wikipedia.org/wiki/DNF_(software)). Pesquise a maneira correta de instalar o IntelliJ IDEA utilizando seu gerenciador de pacotes.

### macOS
Para o macOS temos 2 opções:

* Download direto

  Vá para [a seção de downloads do site da jetbrains](https://www.jetbrains.com/idea/download/#section=mac), selecione a última versão (na data de escrita deste guia é a **2019.1.1**) e instale normalmente, arrastando o aplicativo do *.dmg* para os aplicativos de sua máquina.

* Utilizando um [gerenciador de pacotes](https://pt.wikipedia.org/wiki/Sistema_gestor_de_pacotes) ([Homebrew](https://brew.sh/index_pt-br))

  Caso não conheça o *Homebrew*, veja [este artigo](/pt/posts/utilizando-o-homebrew-no-macos).

Abra o terminal e instale o IntelliJ IDEA utilizando a linha de comando abaixo:
```shell
brew cask install intellij-idea-ce
```

## Configurando o IntelliJ IDEA
Com o IntelliJ IDEA instalado, a configuração é realmente bem simples. Ao executá-lo somos questionados de algumas configurações como: cor de tema, mapeamento de teclas de atalho e plugins. Vamos deixar tudo na configuração padrão e iniciar.

## Criando o projeto
Assim que iniciar, a tela a seguir aparecerá:

![Tela inicial do IntelliJ IDEA](/assets/img/posts/java-spring-boot-intellij-idea/intellij_initial_screen.png)*Tela inicial do IntelliJ IDEA*

Para este exemplo, irei utilizar como [build-tool](https://en.wikipedia.org/wiki/Build_automation) o [Maven](https://maven.apache.org).

Infelizmente no IntelliJ IDEA Community, [de acordo com a documentação](https://www.jetbrains.com/help/idea/spring-boot.html), não há suporte para criação de projetos Spring Boot usando o Spring Initializr pela própria IDE na versão Community, somente disponível na versão Ultimate. Então temos duas opções que podemos explorar:

### Utilizar o Spring Initilizr Web
Acesse: [https://start.spring.io/](https://start.spring.io/), e preencha conforme abaixo:

![Configuração do projeto no Spring Initializr](/assets/img/posts/java-spring-boot-intellij-idea/spring_initializr.png)*Configuração do projeto no Spring Initializr*

Lembre-se de selecionar *Web* como dependência. Clique em *Generate Project* para baixar o *zip* projeto. Extraia-o para um diretório de sua preferência, volte no IntelliJ IDEA e selecione *Import Project*. Vá no diretório do projeto e selecione o arquivo `pom.xml`. A seguir uma janela de importação de projeto Maven irá aparecer, deixe-a com as configurações padrão:

![Importar projeto do Spring Initializr](/assets/img/posts/java-spring-boot-intellij-idea/importing_spring_initializr_project.png)*Importar projeto do Spring Initializr*

Selecione o projeto para importar e clique em *next*:

![Selecionar o projeto](/assets/img/posts/java-spring-boot-intellij-idea/select_project.png)*Selecionar o projeto*

Na tela a seguir, apontar a versão da JDK que você possui instalado:

![Selecionar versão da JDK para o projeto](/assets/img/posts/java-spring-boot-intellij-idea/select_jdk.png)*Selecionar versão da JDK para o projeto*

Na próxima tela confirme o nome do projeto e clique em *finish*.

### Criar um projeto Maven e adicionar o Spring manualmente
Na tela inicial do IntelliJ IDEA, selecione *Create New Project*, na guia do lado esquerdo selecione *Maven*, do lado direito selecione a versão da JDK e clique em *next*:

![Criando projeto Maven](/assets/img/posts/java-spring-boot-intellij-idea/creating_maven_project.png)*Criando projeto Maven*

Ao não selecionar o arquétipo, o IntelliJ IDEA entenderá que você usará o arquétipo Quickstart, que está ok para nosso objetivo.

Na próxima tela especifique o GroupId, ArtifactId e a Version e clique em *next*.

![Configuração do Maven](/assets/img/posts/java-spring-boot-intellij-idea/maven_config.png)*Configuração do Maven*

E depois apenas nomeie o projeto e clique em *finish*:

![Nomeando projeto no IDEA](/assets/img/posts/java-spring-boot-intellij-idea/naming_project.png)*Nomeando projeto no IDEA*

Com o projeto criado, configure o `pom.xml` de acordo com o trecho a seguir:

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

Ao alterar o `pom.xml` irá aparecer a notificação no canto inferior direito da tela:

![Importar mudanças no pom.xml](/assets/img/posts/java-spring-boot-intellij-idea/maven_import.png)*Importar mudanças no pom.xml*

Clique em *Import Changes* para que o *Maven* atualize as novas dependências.

Agora vamos criar a classe que conterá o main do projeto. Lembrando que uma das boas práticas de java é não criar nenhum código no pacote default, portanto, clique na source folder main/java e crie um pacote:

![Criar pacote](/assets/img/posts/java-spring-boot-intellij-idea/creating_package.png)*Criar pacote*

Escreva o nome do pacote, no meu caso foi: `br.com.danielpadua.java_spring_idea_example`, e crie uma classe dentro deste pacote chamado `ExampleApplication.java` e escreva o código:

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

Para os testes, repita a criação do pacote e crie uma classe chamada: `ExampleApplicationTests.java` e escreva o código:

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

Neste ponto temos essencialmente o mesmo projeto que é gerado pelo *Spring Initilizr* na seção acima.

## Completando o projeto
Com o esqueleto básico do projeto montado, basta criarmos um pacote para abrigado o nosso endpoint de Hello World. Clique com o botão direito sobre o pacote raíz:

![Criando pacote para os controllers](/assets/img/posts/java-spring-boot-intellij-idea/creating_package_controllers.png)*Criando pacote para os controllers*

Escreva: *controllers* e confirme. Dentro do pacote criado, crie uma classe chamada: `ExampleController.java` e escreva o código:

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

Execute o projeto clicando com o botão direito sobre a classe principal *Application.java* e selecionando a opção `Run 'Application.main()'`:

![Executando a aplicação](/assets/img/posts/java-spring-boot-intellij-idea/running_app.png)*Executando a aplicação*

Após executar você deverá ver na aba *Run* localizada na parte inferior da tela a saída:

![Log de inicialização do Spring](/assets/img/posts/java-spring-boot-intellij-idea/spring_initialization_log.png)*Log de inicialização do Spring*

Para testar o funcionamento basta abrir seu browser favorito e acessar: [http://localhost:8080/api/example/hello-world](http://localhost:8080/api/example/hello-world) e você deverá ver a mensagem de *Hello World*:

![Voilá](/assets/img/posts/java-spring-boot-intellij-idea/voila.png)*Voilá*

## Conclusão
O IntelliJ IDEA é a IDE para java mais utilizada atualmente e muito provavelmente é a melhor e mais completa na opinião de muitos desenvolvedores. E a versão Community é uma ótima alternativa ao tradicional eclipse.

Até a próxima!
