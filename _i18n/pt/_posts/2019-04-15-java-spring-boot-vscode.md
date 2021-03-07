---
title: "Java Spring Boot + Vscode"
description: "Visual Studio Code, Java, Spring Boot: Veja como configurar o visual studio code para trabalhar com java, criando um projeto spring boot como exemplo"
date: 2019-04-15 12:00:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Java, Spring Boot]
tags: [java, spring boot, visual studio code]
image:
  src: /assets/img/posts/java-spring-boot-vscode/featured.png
  alt: Logotipos do java e do spring com um sinal de soma, seguido pelo logotipo do visual studio code
---

Para ver como configurar um ambiente de desenvolvimento .NET Core com o vscode veja: [Vscode + ASP.NET Core: Preparar ambiente de desenvolvimento](https://medium.com/@danielpadua/vscode-asp-net-core-preparar-ambiente-de-desenvolvimento-adf30cefea07)

## Introdução

Tenho trabalhado com Java bastante ultimamente e como a maioria dos desenvolvedores desta linguagem, estava utilizando o [eclipse](https://www.eclipse.org/). Apesar de pessoalmente considerá-lo uma boa [IDE](https://pt.wikipedia.org/wiki/IDE), tenho me inclinado a usar o [vscode](https://code.visualstudio.com/) como minha ferramenta de desenvolvimento principal por sua leveza, flexibilidade e extensões que trazem bastante agilidade no desenvolvimento. Portanto, resolvi me aventurar a desenvolver Java usando o vscode e acabei gostando bastante da experiência, muito embora ainda existam algumas deficiências que não substituem completamente IDEs como o eclipse ou até mesmo o [IntelliJ IDEA](https://www.jetbrains.com/idea/).

O repositório deste guia está disponível no link a seguir: [https://github.com/danielpadua/java-spring-vscode-example](https://github.com/danielpadua/java-spring-vscode-example)

## Pré-requisitos
Para seguir este guia, é necessário ter instalado em sua máquina:

* [Java JDK 8](https://www.oracle.com/technetwork/pt/java/javase/downloads/jdk8-downloads-2133151.html) ou superior

* [Vscode](https://code.visualstudio.com/Download)

## Instalar extensões de suporte ao Java
Para rodar corretamente projetos Java no vscode, será necessário instalar algumas extensões. Já existem alguns pacotes de extensões que agrupam os essenciais, portanto, abra seu vscode e na guia de extensões procure e instale os itens abaixo:

* [Java Extension Pack](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack)

![Java Extension Pack](/assets/img/posts/java-spring-boot-vscode/java_extension_pack.png)*Java Extension Pack*

Este pacote de extensões contém o essencial para sair desenvolvendo Java no vscode, tais como: Navegação de código, auto-complete, refactor, snippets de códigos principais, debbuger, entre outros.

* [Spring Boot Extension Pack](https://marketplace.visualstudio.com/items?itemName=Pivotal.vscode-boot-dev-pack)

![Spring Boot Extension Pack](/assets/img/posts/java-spring-boot-vscode/spring_boot_extension_pack.png)*Spring Boot Extension Pack*

Este pacote de extensões contém o essencial para ajudar no desenvolvimento de projetos Spring Boot, tais como: Spring Boot Initializr (criação de projetos spring-boot), Spring Boot Dashboard (Aba do vscode que provê um explorador de projetos spring-boot no seu workspace), entre outros.

Após a instalação destes plugins, lembre-se de abrir a paleta de comandos e mandar um *Reload Window* (`ctrl+shift+p` => windows/linux ou `cmd+shift+p` => mac) e escreva Reload Window + Enter.

## Criar o projeto com Spring Initializr
Após a instalação das extensões vamos criar um projeto de exemplo Spring Boot usando o [Spring Initializr](https://start.spring.io/) para o vscode. Mais uma vez abra a paleta de comandos e digite: "spring" e selecione a opção: "Spring Initializr: Generate a Maven Project"

![](/assets/img/posts/java-spring-boot-vscode/spring_boot_initializr_vscode.png)

* Selecione a linguagem Java

* Coloque no Group Id algo como: `br.com.danielpadua`

* Artifact Id algo como: `java-spring-vscode-example`

* Selecione a versão do Spring-Boot mais atual e estável (No momento da escrita deste guia é a: 2.1.4)

* Não selecione nenhuma dependência, apenas aperte o Enter

* Selecione uma pasta para abrigar o projeto, sugiro que possua uma pasta chamada "projetos" na raiz do diretório do usuário

Com o projeto criado, vá no Explorer e abra a pasta que acabamos de criar. O vscode irá tentar inicializar as extensões, e atualizar as dependências Maven suportar o projeto, então, aguarde até que o processo termine antes de continuar:

![Pode demorar um pouco, paciência!](/assets/img/posts/java-spring-boot-vscode/maven_updating.png)*Pode demorar um pouco, paciência!*

O ambiente montado com o projeto aberto deve ser algo assim:

![Vscode + Java](/assets/img/posts/java-spring-boot-vscode/vscode_working_with_java.png)*Vscode + Java*

Faça apenas uma pequena alteração no arquivo `pom.xml`, na seção de dependências, mude o `artifactId` do `org.springframework.boot` de: **spring-boot-starter** para: **spring-boot-starter-web**. Isso fará com que o maven busque o artefato que possui o necessário para trabalhar com REST APIs ou MVC.

## Escrevendo um Hello-World

Vamos escrever um Controller que irá simplesmente retornar o HttpStatus 200 OK com a mensagem clássica de Hello-World, aproveite para testar o intellisense, navegação de código e outros que são comumente utilizados.

* No Explorer na guia do seu projeto, clique com o botão direito do mouse sobre "javaspringvscodeexample" e adicione uma nova pasta chamada "controllers" e dentro dela um arquivo chamado: `ExampleController.java`. Digite "class", e use o snippet:

![Snippet para criação da classe ExampleController.java](/assets/img/posts/java-spring-boot-vscode/vscode_java_class_snippet.png)*Snippet para criação da classe ExampleController.java*

Repare que a guia: "Java Dependencies" mostra uma visão de pacotes muito similar a que o Eclipse mostra.

Crie o Hello-World da seguinte forma:

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

## Executando o projeto

Agora execute o projeto utilizando a guia "spring-boot-dashboard":

![Aplicação executando!](/assets/img/posts/java-spring-boot-vscode/vscode_running_spring_boot.png)*Aplicação executando!*

Neste momento sua aplicação Spring Boot já está em pé na porta 8080 (porta padrão). Abra seu navegador e vá até: [http://localhost:8080/api/example/hello-world](http://localhost:8080/api/example/hello-world), e verá o seguinte:

![Hello Java Spring Boot World!](https://cdn-images-1.medium.com/max/5424/1*NJHT72AwbbvbSkR8XiFBbQ.png)*Hello Java Spring Boot World!*

Para executar em modo de debug, basta ir no painel de debug, adicionar uma configuração padrão:

![](/assets/img/posts/java-spring-boot-vscode/debug_java_vscode.png)

O arquivo abaixo será adicionado num diretório oculto (.vscode) conforme abaixo:

![](/assets/img/posts/java-spring-boot-vscode/launch_json_java_vscode.png)

A partir deste momento basta clicar no botão verde de Run para sua aplicação rodar em modo de Debug. Faça o attach de seus breakpoints e aproveite o debug:

![Debug de Java no vscode](/assets/img/posts/java-spring-boot-vscode/debugging_on_java_vscode.png)*Debug de Java no vscode*

## Conclusão

É possível sim trabalhar com Java e Spring-Boot no Vscode e ainda ter uma agilidade de desenvolvimento aproximada das IDEs: Eclipse e IntelliJ IDEA. Mas as extensões ainda tem bastante espaço para melhorarem a ponto de substituir completamente estas IDEs.

Até a próxima!
