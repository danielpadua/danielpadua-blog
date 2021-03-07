---
title: "Entendendo Protocol Buffers — Protobuf"
description: "Protobuf, Protocol Buffers: Entenda de uma vez o que é e para que serve este protocolo, e aprenda como aplicar com um exemplo simples em Java e C#"
date: 2020-11-24 12:00:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Grpc]
tags: [protobuf, java, csharp, dotnet core]
image:
  src: /assets/img/posts/understanding-protocol-buffers-protobuf/featured.png
  alt: Uma imagem grande onde está escrito "protobuf - protocol buffers"
---

## Introdução
Protocol Buffers (protobuf) é um método de serializar dados estruturados que é principalmente útil para comunicação entre serviços ou até mesmo para guardar dados. Ele foi desenhado pelo Google no começo de 2001 (mas apenas publicamente liberado em 2008) para ser menor e mais rápido que o XML. As mensagens protobuf são serializadas em um formato [*binary wire*](https://developers.google.com/protocol-buffers/docs/encoding) que é muito compacto, aumentando a performance.

## Detalhes
Este protocolo envolve uma [linguagem de descrição de interface](https://pt.wikipedia.org/wiki/Linguagem_de_descri%C3%A7%C3%A3o_de_interface) específica para modelar a estrutura de dados definido em um arquivo *.proto*
Um programa de qualquer linguagem suportada consegue gerar através de um compilador código fonte nativo utilizando o contrato afim de criar ou interpretar *streams* de bytes que representam os dados estruturados.
Protocol buffers normalmente serve como base para *remote procedure call* (RPC) que é muito usada para comunicação de aplicações entre diferentes máquinas, o mais comumente utilizado é o [gRPC](https://grpc.io/). Protobuf é similar ao [Apache Thrift](https://thrift.apache.org/) usado pelo Facebook, [Ion](https://amzn.github.io/ion-docs/) criado pela Amazon ou o [Microsoft Bonds Protocol](https://microsoft.github.io/bond/manual/bond_cs.html).

## Exemplo
Neste exemplo nós iremos criar dois projetos:

* Uma aplicação console Java que irá utilizar uma especificação .proto de um cliente (*customer.proto*) para gerar um arquivo com um cliente *hard coded*

* Uma aplicação console C# que irá ler o arquivo do cliente *hard coded* gerado pela aplicação java e exibir os dados no console

### Resumo
Caso você apenas queira ler o código e ir descobrindo e aprendendo por conta própria, disponibilizei repositório com estas duas aplicações. Primeiramente siga as instruções do arquivo README_pt.md do projeto Java no repositório:

[**https://github.com/danielpadua/protobuf-example-java**](https://github.com/danielpadua/protobuf-example-java)

Após gerar o arquivo serializado com protobuf, siga as instruções do arquivo README_pt.md do projeto C# no repositório:

[**https://github.com/danielpadua/protobuf-example-csharp**](https://github.com/danielpadua/protobuf-example-csharp)

### Contrato Protobuf
Primeiro de tudo, vamos criar uma estrutura que irá representar um cliente. Os dados que precisamos representar são:

* Identificação única (ID)
* Foto
* Nome
* Data de nascimento
* Data/Hora de criação
* Data/Hora da última atualização

Portanto, será necessário criar um arquivo *.proto* como este:

```proto
syntax = "proto3";

package danielpadua.protobufexample.contracts;

option java_multiple_files = true;
option java_outer_classname = "CustomerProto";
option java_package = "dev.danielpadua.protobufexamplejava.contracts";
option csharp_namespace = "DanielPadua.ProtobufExampleDotnet.Contracts";

import "google/protobuf/timestamp.proto";
import "money.proto";
import "date.proto";

message Customer {
    int64 id = 1;
    bytes photo = 2;
    string name = 3;
    google.type.Date birthdate = 4;
    google.type.Money balance = 5;
    google.protobuf.Timestamp createdAt = 6;
    google.protobuf.Timestamp updatedAt = 7;
}
```

Alguns pontos sobre o código acima:

* O tipo *Timestamp* é um "[Well Known Type](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf)" que foi introduzido no proto3, você pode utilizar estes tipos apenas importando-os nas primeiras linhas do arquivo proto

* Os tipos *Date* e *Money* são "Google Common Type", diferentes do "Well Known Type" não é possível usá-los apenas realizando a importação. É necessário copiar o conteúdo destes arquivos do [repositório do google](https://github.com/googleapis/googleapis/tree/master/google/type) e colar no seu projeto, qualquer que seja a linguagem que está utilizando.

Existem outros tipos, você pode ler a documentação [aqui](https://developers.google.com/protocol-buffers/docs/proto3#scalar). Dos Well Known Types [aqui](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf) e do Google Common Types [aqui](https://github.com/googleapis/googleapis/tree/master/google/type).

Este arquivo *.proto* será um recurso em comum entre os projetos C# e Java, mas para simplificar o exemplo, irei recriá-lo nos repositórios de ambos projetos. O ideal para projetos grandes e complexos seria ter um repositório separado como um ponto único para os projetos que irão utilizá-lo.

### Aplicação Java Console
Com isto explicado, vamos começar a criar uma aplicação Java console. Para este exemplo irei utilizar a OpenJDK 15, IntelliJ IDEA CE e o Maven como *build tool*.

1. Abra o IntelliJ IDEA CE and escolha criar um novo projeto

![Criando um novo projeto](/assets/img/posts/understanding-protocol-buffers-protobuf/new_project_intellij.png)*Criando um novo projeto*

2. Escolha Maven no painel esquerdo, selecione sua Java JDK no canto superior direito. Como disse anteriormente, irei utilizar a OpenJDK 15 que havia instalado anteriormente

![Detalhes do novo projeto](/assets/img/posts/understanding-protocol-buffers-protobuf/new_project_details.png)*Detalhes do novo projeto*

3. Preencha os próximos campos como desejar, por exemplo:

![Configurações maven do projeto](/assets/img/posts/understanding-protocol-buffers-protobuf/new_project_maven_settings.png)*Configurações maven do projeto*

Projeto criado. Vamos começar adicionando o *encoding* do código fonte, informar ao compilador maven que estaremos utilizando a JDK 15 e adicionando a dependência [protobuf-java](https://mvnrepository.com/artifact/com.google.protobuf/protobuf-java) feita pelo Google. Adicione as linhas a seguir no arquivo `pom.xml` dentro da tag "projeto", logo após a tag "version":
```xml
<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>15</maven.compiler.source>
    <maven.compiler.target>15</maven.compiler.target>
</properties>

<dependencies>
    <dependency>
        <groupId>com.google.protobuf</groupId>
        <artifactId>protobuf-java</artifactId>
        <version>3.13.0</version>
    </dependency>
</dependencies>
```

Agora, vamos incluir os arquivos *.proto* definidos na seção acima. Mas antes crie um diretório "proto" dentro de *src/main*:

![Criando o diretório dos arquivos protobuf](/assets/img/posts/understanding-protocol-buffers-protobuf/create_protobuf_files_directory.png)*Criando o diretório dos arquivos protobuf*

Depois adicione um novo arquivo chamado: `customer.proto` e coloque o código mencionado na seção acima:

![Erro ao importar outros arquivos protobuf](/assets/img/posts/understanding-protocol-buffers-protobuf/error_importing_protobuf_files.png)*Erro ao importar outros arquivos protobuf*

Os imports do `money.proto` e `date.proto` irão mostrar erro porque ainda não os criamos. Você pode criá-los repetindo o procedimento acima adicionando o código do [money.proto](https://github.com/googleapis/googleapis/blob/master/google/type/money.proto) e [date.proto](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) diretamente do repositório do Google.

![customer.proto sem erros](/assets/img/posts/understanding-protocol-buffers-protobuf/errors_gone.png)*customer.proto sem erros*

Ok, contratos protobuf criados. Agora, para gerarmos o código fonte nativo (classes java) a partir do contrato, nós precisamos usar o executável *protoc* para compilar os arquivos *.proto* apontando a linguagem desejada de saída. Existem duas maneiras principais de fazer isto:

* Manualmente, baixando o *protoc* na sua máquina e executando-o. Caso você deseje ir por este caminho, leia o guia de instalação do protoc [aqui](https://grpc.io/docs/protoc-installation/)

* Automaticamente, adicionando geração de código via *protoc* no build do seu projeto maven. Existem alguns plugins maven para isto, mas irei utilizar o [*protoc-jar-maven-plugin*](https://github.com/os72/protoc-jar-maven-plugin), que envolve o executável do *protoc* como um *jar* assim ele pode ser executado em qualquer SO e então compilar seus arquivos *.proto*.

Você pode começar a utilizá-lo apenas adicionando as linhas abaixo no seu `pom.xml` abaixo da tag "project", logo após a tag "dependencies":
```xml
<build>
    <plugins>
        <plugin>
            <groupId>com.github.os72</groupId>
            <artifactId>protoc-jar-maven-plugin</artifactId>
            <version>3.11.4</version>
            <executions>
                <execution>
                    <id>protoc.main</id>
                    <phase>generate-sources</phase>
                    <goals>
                        <goal>run</goal>
                    </goals>
                    <configuration>
                        <protocVersion>3.13.0</protocVersion>
                        <addSources>main</addSources>
                        <includeMavenTypes>direct</includeMavenTypes>
                        <includeStdTypes>true</includeStdTypes>
                        <includeDirectories>
                            <include>src/main/proto</include>
                        </includeDirectories>
                        <inputDirectories>
                            <include>src/main/proto</include>
                        </inputDirectories>
                    </configuration>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```
> Sempre verifique se existem novas versões estáveis antes de adicionar dependências ou plugins em seu `pom.xml`.

Nós estamos adicionando a estrutura de diretório onde estamos armazenando os arquivo *.proto*, assim o plugin saberá onde eles estão para compilá-los.

Neste ponto é provável que você queira executar o compilador *protoc* para gerar as classes java que representam os contratos protobuf, então, clique na tab maven e depois no botão `run maven goal` e escreva: `mvn clean install`

![Executando maven clean install](/assets/img/posts/understanding-protocol-buffers-protobuf/run_maven_clean_install.png)*Executando maven clean install*

Caso a compilação tenha sucesso, a mensagem a seguir irá ser exibida:

![Um build de sucesso](/assets/img/posts/understanding-protocol-buffers-protobuf/build_success.png)*Um build de sucesso*

Próximo passo é criar um pacote `dev.danielpadua.protobufexamplejava` e dentro do mesmo uma classe principal para nossa aplicação console:

![Nosso método main](/assets/img/posts/understanding-protocol-buffers-protobuf/main_method.png)*Nosso método main*

Caso você digite “Customer”, o autocomplete do IntelliJ irá aparecer e te sugerir importar a classe gerada pelo *protoc* via plugin:

![Sucesso ao auto-completar classes geradas](/assets/img/posts/understanding-protocol-buffers-protobuf/autocomplete_working_with_generated_classes.png)*Sucesso ao auto-completar classes geradas*

Então, deu tudo certo. Agora nós podemos escrever o código para gerar o cliente *hard coded* e gravá-lo no diretório que você desejar (dentro do método main):
```java
Date birthdate = Utils.toGoogleDate(LocalDate.of(1990, 4, 30));
Money balance = Utils.toGoogleMoney(BigDecimal.valueOf(9000.53));
Timestamp createdUpdateAt = Utils.toGoogleTimestampUTC(LocalDateTime.now());
String fullPath = "/Users/danielpadua/protobuf/protobuf-customer";

try (FileOutputStream fos = new FileOutputStream(fullPath)) {
    Customer daniel = Customer.newBuilder()
            .setId(1)
            .setPhoto(ByteString.EMPTY)
            .setName("Daniel")
            .setBirthdate(birthdate)
            .setBalance(balance)
            .setCreatedAt(createdUpdateAt)
            .setUpdatedAt(createdUpdateAt)
            .build();

    daniel.writeTo(fos);
    System.out.println("protobuf-customer created successfully");
} catch (FileNotFoundException e) {
    System.out.println(format("could not find file {0}", fullPath));
} catch (IOException e) {
    System.out.println(format("error while reading file {0}. exception: {1}", fullPath, e.getMessage()));
}
```

Note que o código acima faz uso de uma classe Utils para converter os tipos: Java LocalDate para Google Date, Java BigDecimal para Google Money e Java LocalDateTime para Google Timestamp. Você pode incluir minha classe Utils no seu projeto copiando o código a seguir:

```java
package dev.danielpadua.protobufexamplejava;

import com.google.protobuf.Timestamp;
import com.google.type.Date;
import com.google.type.Money;

import java.math.BigDecimal;
import java.math.MathContext;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneOffset;

public class Utils {
    protected static Timestamp toGoogleTimestampUTC(final LocalDateTime localDateTime) {
        return Timestamp.newBuilder()
                .setSeconds(localDateTime.toEpochSecond(ZoneOffset.UTC))
                .setNanos(localDateTime.getNano())
                .build();
    }

    protected static LocalDateTime fromGoogleTimestampUTC(final Timestamp googleTimestamp) {
        return Instant.ofEpochSecond(googleTimestamp.getSeconds(), googleTimestamp.getNanos())
                .atOffset(ZoneOffset.UTC)
                .toLocalDateTime();
    }

    protected static Date toGoogleDate(final LocalDate localDate) {
        return Date.newBuilder()
                .setYear(localDate.getYear())
                .setMonth(localDate.getMonth().getValue())
                .setDay(localDate.getDayOfMonth())
                .build();
    }

    protected static LocalDate fromGoogleDate(final Date googleDate) {
        return LocalDate.of(googleDate.getYear(), googleDate.getMonth(), googleDate.getDay());
    }

    protected static Money toGoogleMoney(final BigDecimal decimal) {
        return Money.newBuilder()
                .setCurrencyCode("USD")
                .setUnits(decimal.longValue())
                .setNanos(decimal.remainder(BigDecimal.ONE).movePointRight(decimal.scale()).intValue())
                .build();
    }

    protected static BigDecimal fromGoogleMoney(final Money googleMoney) {
        return new BigDecimal(googleMoney.getUnits())
                .add(new BigDecimal(googleMoney.getNanos(), new MathContext(9)));
    }
}
```

Caso você tenha o problema a seguir no IntelliJ, você pode simplesmente utilizar a sugestão sugerida: “Set language level to 8 — Lambdas, type annotations etc”:

![Language level no IntelliJ IDEA](/assets/img/posts/understanding-protocol-buffers-protobuf/language_level_intellij.png)*Language level no IntelliJ IDEA*

Agora podemos executar a aplicação. Clique no botão “Add Configuration” localizado no canto superior direito, ao lado do botão de build. Clique no botão com o sinal de soma e selecione “Application”:

![Criando uma run configuration](/assets/img/posts/understanding-protocol-buffers-protobuf/create_run_configuration.png)*Criando uma run configuration*

Então preencha o nome da configuração e selecione a classe principal a ser executada:

![Últimos campos para preencher antes de executar](/assets/img/posts/understanding-protocol-buffers-protobuf/last_fields_to_fill.png)*Últimos campos para preencher antes de executar*

Depois, clique no botão executar ou debugar caso você queira:

![Vamos rodar!](/assets/img/posts/understanding-protocol-buffers-protobuf/lets_run.png)*Vamos rodar!*

Um resultado de sucesso deve exibir a mensagem a seguir:

![Arquivo protobuf criado com sucesso](/assets/img/posts/understanding-protocol-buffers-protobuf/successfully_created_protobuf_files.png)*Arquivo protobuf criado com sucesso*

Agora verifique o diretório que você definiu como saída para o arquivo:

![Sucesso!](/assets/img/posts/understanding-protocol-buffers-protobuf/success.png)*Sucesso!*

Nós implementamos com sucesso uma simples aplicação console Java que cria uma mensagem protobuf utilizando uma estrutura definida em um arquivo *.proto*, através de um processo de compilação automatizado e integrado ao build maven. Agora para provar que é útil para comunicação entre projetos de diferentes linguagens, iremos criar uma aplicação console C# para ler este arquivo e mostrar os dados no console.

### Aplicação Console C#
Para o examplo do C# irei utilizar: .NET 5, Visual Studio Code e o pacote [Grpc.AspNetCore](https://www.nuget.org/packages/Grpc.AspNetCore) que contém um compilador de protobuf é embutido ao dotnet build.

Abra o Visual Studio Code, abra o terminal integrado, navegue até o diretório onde você deseja guardar o projeto e execute os comandos a seguir, linha a linha:
```shell
# Cria um diretório para a solução
mkdir protobuf-example-csharp
# Navega até a solução
cd protobuf-example-csharp
# Cria o projeto principal
dotnet new console -o src/DanielPadua.ProtobufExampleCsharp
# Cria o projeto de testes
dotnet new xunit -o tests/DanielPadua.ProtobufExampleCsharp.Tests
# Cria a solution na raíz
dotnet new sln -n DanielPadua.ProtobufExampleCsharp
# Adiciona os projetos na solution
dotnet sln add src/DanielPadua.ProtobufExampleCsharp/DanielPadua.ProtobufExampleCsharp.csproj
dotnet sln add tests/DanielPadua.ProtobufExampleCsharp.Tests/DanielPadua.ProtobufExampleCsharp.Tests.csproj
```

Feito, projeto criado, agora vamos abri-lo no Visual Studio Code:

![Selecione a pasta raíz (a mesma que você está no terminal)](/assets/img/posts/understanding-protocol-buffers-protobuf/open_project_vscode.png)*Selecione a pasta raíz (a mesma que você está no terminal)*

A estrutura do projeto deve ser como esta:

![Adicione os assets para fazer build e debug](/assets/img/posts/understanding-protocol-buffers-protobuf/add_missing_assets_build_debug.png)*Adicione os assets para fazer build e debug*

Clique no “Yes” na mensagem no canto inferior direito, para que o *Omnisharp* crie a pasta *.vscode* com os assets para executar/debugar o projeto. Selecione “DanielPadua.ProtobufExampleCsharp”:

![Escolha o projeto para gerar os assets](/assets/img/posts/understanding-protocol-buffers-protobuf/choose_project_to_generate_assets.png)*Escolha o projeto para gerar os assets*

Abra o terminal novamente no nível *src/DanielPadua.ProtobufExampleCsharp* e execute:
```shell
dotnet add package Grpc.AspNetCore
```

Agora vamos incluir os contratos *.proto*. Crie um diretório abaixo da raíz do projeto principal e nomeie-o como: “Protos” e crie os arquivos *.proto* listados na seção acima:

![Arquivos protobuf criados](/assets/img/posts/understanding-protocol-buffers-protobuf/protobuf_files_created.png)*Arquivos protobuf criados*

Adicione os arquivos *.proto* no *.csproj* para que o *protoc* compile quando o dotnet build rodar:

![Adicionando o caminho dos arquivos protobuf para o plugin compilar](/assets/img/posts/understanding-protocol-buffers-protobuf/reference_protobuf_files_csproj.png)*Adicionando o caminho dos arquivos protobuf para o plugin compilar*

Agora vamos compilar o projeto para gerar as classes C# a partir dos contratos *.proto*. No terminal, execute:
```shell
dotnet build
```

A mensagem de um build de sucesso deve ser algo como isto:

![Dotnet build ok](/assets/img/posts/understanding-protocol-buffers-protobuf/dotnet_build_ok.png)*Dotnet build ok*

Próximo passo é substituir o “Hello World” no método Main pelas linhas a seguir:
```c#
    var fullpath = @"/Users/danielpadua/protobuf/protobuf-customer";
    using var inputStream = File.OpenRead(fullpath);
    Customer c = Customer.Parser.ParseFrom(inputStream);
    Console.WriteLine("Customer from protobuf-example-java:");
    Console.WriteLine(c.ToString());
```

Agora você deve tentar importar o namespace "Contracts", pressione ctrl+. (windows, linux) or cmd+. (macOs) para abrir o autocomplete, e então a opção de importar irá aparecer:

![Intellisense e a geração de código protobuf funcionando](/assets/img/posts/understanding-protocol-buffers-protobuf/intellisense_protobuf_code_generation_working.png)*Intellisense e a geração de código protobuf funcionando*

Caso a opção de importar não aparece, tente reiniciar o Omnisharp usando: ctrl+shift+p (windows, linux) or cmd+shift+p (macOs), digite: restart omnisharpe aperte o enter:

![Espere por um momento antes de tentar importar novamente](/assets/img/posts/understanding-protocol-buffers-protobuf/restart_omnisharp.png)*Espere por um momento antes de tentar importar novamente*

Infelizmente a integração do Omnisharp com o compilador de protobuf não é perfeita, mas funciona.

Garanta que você está lendo o mesmo diretório e arquivo que o projeto Java gerou, e então rode sua aplicação console C# apertando o botão de executar do Visual Studio Code (caso você tenha configurado os assets de execução/debug corretamente) ou simplesmente rodando a linha de comando: dotnet run estando no diretório raíz do projeto principal:

![Executando do terminal](/assets/img/posts/understanding-protocol-buffers-protobuf/running_from_terminal.png)*Executando do terminal*

![Executando do Visual Studio Code](/assets/img/posts/understanding-protocol-buffers-protobuf/running_from_vscode.png)*Executando do Visual Studio Code*

E, nós conseguimos. Recebemos e interpretamos uma mensagem serializada em protobuf gerada por uma aplicação Java, dentro de uma aplicação C#.

## Conclusão
Protobuf foi feito para ser mais rápido, mais leve e consequentemente mais performático do que outros protocolos. Então, te convido a fazer uma breve pesquisa como: "protobuf vs json performance" ou alguma outra, para ver benchmarks e outros cases de sucesso mundo afora.

Neste artigo espero ter dado um bom mergulho para aqueles que, como eu há um tempo atrás, não haviam nem ouvido falar sobre protobuf e sempre utilizaram JSON ou XML para serialização.

Até a próxima!

## Referencias
- [**https://en.wikipedia.org/wiki/Protocol_Buffers**](https://en.wikipedia.org/wiki/Protocol_Buffers)
- [**https://developers.google.com/protocol-buffers**](https://developers.google.com/protocol-buffers)
