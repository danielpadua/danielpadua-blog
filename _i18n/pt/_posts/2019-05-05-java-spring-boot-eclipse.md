---
title: "Java Spring Boot + Eclipse"
description: "Eclipse, Java, Spring Boot: Aprenda a criar do zero um projeto java com spring boot utilizando o eclipse como IDE"
date: 2019-05-05 12:10:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Java, Spring Boot]
tags: [java, spring boot, eclipse]
image:
  src: /assets/img/posts/java-spring-boot-eclipse/featured.png
  alt: Logotipos do java e do spring boot com um sinal de soma, seguidos pelo logotipo do eclipse
---

## Introdução
Para quem desenvolve java atualmente é praticamente impossível passar despercebido o framework [Spring](https://spring.io/) e especificamente o [Spring Boot](https://spring.io/projects/spring-boot). Utilizando esta [stack de desenvolvimento](https://en.wikipedia.org/wiki/Solution_stack), ganhamos muita facilidade e agilidade de desenvolvimento em projetos java de pequeno a grande porte. Neste guia irei demonstrar como instalar, configurar o eclipse e criar um simples Hello-World.

O repositório do projeto exemplo deste artigo encontram-se em: [https://github.com/danielpadua/java-spring-eclipse-example](https://github.com/danielpadua/java-spring-eclipse-example)

## Pré-Requisitos
* Java JDK 8 ou superior

## Instalando o Eclipse
> Vale lembrar que também é altamente válido instalar o [Spring Tool Suite (STS)](https://spring.io/tools) ao invés do eclipse puro. O STS é basicamente o eclipse configurado com o plugin [spring tools](https://marketplace.eclipse.org/content/spring-tools-4-spring-boot-aka-spring-tool-suite-4), otimizado para desenvolvimento com o spring framework

Utilize as seções abaixo de acordo com o sistema operacional que estiver utilizando:

### Windows
Para Windows temos 2 opções:

* Download direto

  Vá para [a seção de downloads do site do eclipse](https://www.eclipse.org/downloads/packages), selecione a última versão (na data de escrita deste guia é a [4.10](https://www.eclipse.org/downloads/packages/release/2019-03/r/eclipse-ide-enterprise-java-developers)) e instale utilizando NNF (next, next, finish).

* Utilizando um [gerenciador de pacotes](https://pt.wikipedia.org/wiki/Sistema_gestor_de_pacotes) ([Chocolatey](https://chocolatey.org/))

  Caso não conheça o *Chocolatey*, veja [este artigo](/pt/posts/utilizando-chocolatey-para-windows).

  Abra o *powershell* e instale o eclipse utilizando a linha de comando abaixo:
  ```powershell
  choco install eclipse
  ```

### Linux
Para Linux temos 2 opções:

* Download direto

  Vá para [a seção de downloads do site do eclipse](https://www.eclipse.org/downloads/packages), selecione a última versão (na data de escrita deste guia é a [4.10](https://www.eclipse.org/downloads/packages/release/2019-03/r/eclipse-ide-enterprise-java-developers)) e extraia o arquivo *.tar.gz* e execute o arquivo *eclipse*.

* Utilizando um [gerenciador de pacotes](https://pt.wikipedia.org/wiki/Sistema_gestor_de_pacotes)

  Dependendo da [distribuição de Linux](https://pt.wikipedia.org/wiki/Distribui%C3%A7%C3%A3o_Linux) que você possui, você utilizará um gerenciador de pacotes diferente. Por exemplo, para [distros baseadas em debian](https://en.wikipedia.org/wiki/Category:Debian-based_distributions), como o popular [ubuntu](https://www.ubuntu.com/), use o [apt-get](https://www.debian.org/doc/manuals/apt-howto/ch-apt-get.pt-br.html). Para [distros baseadas em Red Hat (ou RHEL)](https://en.wikipedia.org/wiki/Red_Hat_Enterprise_Linux_derivatives) use o [yum](https://pt.wikipedia.org/wiki/Yellowdog_Updater,_Modified) ou [dnf](https://en.wikipedia.org/wiki/DNF_(software)). Pesquise a maneira correta de instalar o eclipse utilizando seu gerenciador de pacotes.

### macOS

Para o macOS temos 2 opções:

  * Download direto
  Vá para [a seção de downloads do site do eclipse](https://www.eclipse.org/downloads/packages), selecione a última versão (na data de escrita deste guia é a [4.10](https://www.eclipse.org/downloads/packages/release/2019-03/r/eclipse-ide-enterprise-java-developers)) e instale normalmente, arrastando o aplicativo do *.dmg* para os aplicativos de sua máquina.

* Utilizando um [gerenciador de pacotes](https://pt.wikipedia.org/wiki/Sistema_gestor_de_pacotes) ([Homebrew](https://brew.sh/index_pt-br))

  Caso não conheça o *Homebrew*, veja [este artigo](/pt/posts/utilizando-o-homebrew-no-macos).

  Abra o terminal e instale o eclipse utilizando a linha de comando abaixo:
  ```shell
  brew cask install eclipse-ide
  ```

## Configurando o eclipse
Com o eclipse instalado, recomendo que abra-o comece a familiarizar-se com a [GUI](https://pt.wikipedia.org/wiki/Interface_gr%C3%A1fica_do_utilizador) e também [teclas de atalho](https://www.vogella.com/tutorials/EclipseShortcuts/article.html).
> Caso tenha instalado o Spring Tool Suite, não é necessário seguir o passo de instalação do plugin Spring Tools abaixo

### Spring Tools
Para ter uma melhor experiência com desenvolvimento Spring, recomendo instalar o `Spring Tools`. Vá no menu `Help > Eclipse Marketplace…` e procure por spring:

![Instalando Spring Tools](/assets/img/posts/java-spring-boot-eclipse/installing_spring_tools_eclipse.png)*Instalando Spring Tools*

Instale a versão mais atual do *Spring Tools* (na data de escrita deste guia é a 4.2.1) e reinicie o eclipse.

## Criando o projeto
Com tudo configurado corretamente, hora de criarmos o projeto. Vá no menu: `File > New > Project…` e selecione a opção `Spring Starter Project` que está localizada abaixo do menu `Spring Boot`, conforme imagem abaixo:

![Iniciando o projeto](/assets/img/posts/java-spring-boot-eclipse/starting_project.png)*Iniciando o projeto*

Para este exemplo, irei utilizar como [*build-tool*](https://en.wikipedia.org/wiki/Build_automation) o [Maven](https://maven.apache.org).

Preencha os campos com o nome de seu artefato e o groupId, e selecione o campo *Type* como *Maven*

![Inicialização do projeto utilizando o Maven](/assets/img/posts/java-spring-boot-eclipse/start_project_maven.png)*Inicialização do projeto utilizando o Maven*

Clicando no next, temos que especificar qual versão do *Spring* utilizar. É recomendável utilizar a última versão estável (na data de escrita deste guia é 2.1.4). Como dependência, selecione apenas a *Web* e clique em *Finish*.

![Escolha da versão do Spring e dependências](/assets/img/posts/java-spring-boot-eclipse/spring_version_dependencies.png)*Escolha da versão do Spring e dependências*

Projeto criado, agora é hora de criar um *Controller* com um endpoint que irá retornar uma String fixa com o conteúdo: "Hello-World". Clique com o botão direito sobre o pacote principal e selecione `New > Class`

![Criando uma classe](/assets/img/posts/java-spring-boot-eclipse/creating_class.png)*Criando uma classe*

E crie uma classe com o nome "ExampleController" e preencha o sufixo do pacote com ".controllers" assim irá ser criado um pacote *controllers* onde você poderá agrupar os controllers de seu projeto:

![Criando o ExampleController](/assets/img/posts/java-spring-boot-eclipse/creating_examplecontroller.png)*Criando o ExampleController*

Utilize o código abaixo para criar o endpoint que irá retornar "Hello World!":

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

Execute o projeto, primeiramente clicando no botão **Boot Dashboard** e depois na guia **Boot Dashboard** na parte inferior da tela, selecione o nome do seu projeto e clique no botão de executar ao lado:

![Executando o projeto](/assets/img/posts/java-spring-boot-eclipse/running_project.png)*Executando o projeto*

Após clicar no botão de executar, você deverá ver a saída do log de inicialização do spring na aba console:

![Log de inicialização do Spring](/assets/img/posts/java-spring-boot-eclipse/spring_initialization_log.png)*Log de inicialização do Spring*

Para testar o funcionamento basta abrir seu browser favorito e acessar: [http://localhost:8080/api/example/hello-world](http://localhost:8080/api/example/hello-world) e você deverá ver a mensagem de *Hello World*:

![Voilá](/assets/img/posts/java-spring-boot-eclipse/voila.png)*Voilá*

## Conclusão
O Eclipse e também o Spring Tool Suite são IDEs ótimas para desenvolvimentos de aplicações robustas baseadas em java e spring, e devido a maturidade da ferramenta, acaba sendo super fácil o start de um projeto simples.

Até a próxima!
