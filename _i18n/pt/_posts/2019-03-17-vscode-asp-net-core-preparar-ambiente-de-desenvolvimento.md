---
title: "Vscode + ASP.NET Core: Preparar ambiente de desenvolvimento"
description: "Visual Studio Code, Dotnet Core: Aprenda a montar um ambiente de desenvolvimento completo para .net core utilizando o visual studio code para edição, debug e execução dos projetos"
date: 2019-03-17 12:00:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Dotnet, Dotnet Core]
tags: [visual studio code, dotnet core, csharp, microsoft]
image:
  src: /assets/img/posts/vscode-aspnet-core-setup-development-environment/featured.png
  alt: Logotipo do visual studio code com um sinal de soma, seguido do logo do .net core
---

## Introdução

Há muito tempo o Visual Studio é a principal ferramenta para desenvolvimento voltado a plataforma .NET e recentemente também para .NET Core. Conforme evolução natural da IDE, foram adicionadas muitas funcionalidades, tornando-o cada vez mais pesado. Venho sentindo que perco agilidade por acabar ter que conviver com funcionalidades que não costumo usar, e também me sinto em uma espécie de "zona de conforto" utilizando o Visual Studio, pois ele acaba fazendo muita coisa "por baixo dos panos" que na hora o desenvolvedor acaba perdendo um ponto importante no entendimento.

Aproveitando a ascensão do Visual Studio Code e também da cultura open-source que está cada vez mais fazendo parte da veia .NET, resolvi criar este guia para começar rapidamente um ambiente para desenvolvimento utilizando o vscode para .NET Core, bem como extensões para ter uma agilidade de desenvolvimento tão boa quanto a que o Visual Studio proporciona, porém muito mais leve e sem tantas fazer coisas "automagicamente".

## Instalar o .NET Core SDK

Independente do sistema operacional que está usando, há uma versão do .NET Core SDK para você. Há algumas possibilidades de como instalar, por exemplo:

1. Baixar e instalar diretamente da Microsoft: [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download) selecionando seu sistema operacional;

2. (Recomendado) Utilizando um gerenciador de pacotes, segue algumas opções:
   * Windows
    Sim, *existe* gerenciador de pacotes para Windows, e ele se chama: **Chocolatey**. Siga o tutorial de instalação em: [https://chocolatey.org/install](https://chocolatey.org/install) e depois é só mandar no **Powershell**:
    ```shell
    choco install dotnetcore-sdk
    ```

   * Linux (Fedora)
    Para quem é amante do Pinguin, deve conhecer N distros e N gerenciadores de pacotes, basta pesquisar por *dotnet core sdk*. No caso do Fedora, utilize [este guia para configurar o repositório](https://dotnet.microsoft.com/download/linux-package-manager/fedora28/sdk-2.1.301) e instalar utilizando um:
    ```shell
    sudo dnf install dotnet-sdk-2.1
    ```

   * MacOS
    Para a maçã é recomendável utilizar o [Homebrew](https://brew.sh/index_pt-br) e instalar via cask com a linha de comando:
    ```shell
    brew install dotnet-sdk --cask
    ```

## Instalar o Visual Studio Code

As instruções acima também são válidas na hora de instalar o vscode, pode ser instalado tanto via gerenciador de pacotes quanto diretamente pelo download do site: [https://code.visualstudio.com/download](https://code.visualstudio.com/download)

## Configurar Extensões do Visual Studio Code

Para conseguirmos termos algumas funcionalidades básicas que tínhamos no Visual Studio dentro do vscode, como por exemplo: debugar, auto complete, compilador ativo e etc, será necessário instalar algumas extensões:

### Essencial

* C# (OmniSharp)

![Omnisharp image](/assets/img/posts/vscode-aspnet-core-setup-development-environment/omnisharp.png)

Esta é a extensão oficial do C# da Microsoft. Com esta extensão você já é capaz de debugar, auto completar e utilizar o compilador ativo indicando problemas.

### (Opcionais) As que eu estou utilizando/testando no momento

* C# XML Documentation Comments

![C# XML Documentation Comments image](/assets/img/posts/vscode-aspnet-core-setup-development-environment/csharp_xml_documentation_comments.png)

Basicamente serve apenas para quando você digitar "///" auto completar gerando a documentação XML do escopo, conforme o Visual Studio faz.

* ASP.NET Core Snippets

![ASP.NET Core Snippets image](/assets/img/posts/vscode-aspnet-core-setup-development-environment/aspnet_core_snippets.png)

Contém alguns snippets para auto completar e gerar métodos, propriedades e etc, mais rapidamente.

* C# Extensions

![C# Extensions image](/assets/img/posts/vscode-aspnet-core-setup-development-environment/csharp_extensions.png)

Esta extensão te traz algumas ações específicas para .NET Core dentro do vscode, como por exemplo: clicar com o botão direito sobre uma pasta e selecionar uma opção de criar uma Classe C#, ao invés de ter que criar um arquivo .cs completamente vazio, como o vscode sem extensão faz.

* Bracket Pair Colorizer

![Bracket Pair Colorizer image](/assets/img/posts/vscode-aspnet-core-setup-development-environment/bracket_pair_colorizer.png)

Atribui cores para facilitar a visualização de abertura/fechamento de chaves

* Path Intelisense

![Path Intellisense image](/assets/img/posts/vscode-aspnet-core-setup-development-environment/path_intellisense.png)

Esta extensão é muito boa. Através dela ao digitar numa string, por exemplo: "../" ele traz a listagens de arquivos baseado na estrutura do seu projeto

* Prettier

![Prettier image](/assets/img/posts/vscode-aspnet-core-setup-development-environment/prettier.png)

Extensão para formatação e indentação de código, serve para diversas linguagens.

### Bonus: Tema
* Dracula Official

![Dracula image](/assets/img/posts/vscode-aspnet-core-setup-development-environment/dracula.png)

O tema que eu fiquei melhor adaptado para programar.

## Criando um projeto teste

Chegou a hora de criar um projeto e verificar se todo o setup funcionou. Abra o terminal integrado do vscode (`ctrl+'`) e siga as instruções abaixo:

1. Crie um diretório para seu projeto com a linha de comando a seguir:
```shell
mkdir ~/projeto-teste
```

2. Navegue até este diretório, caso você ainda não esteja nele:
```shell
cd ~/projeto-teste
```

3. Crie um projeto utilizando a CLI do .NET Core (mais informações da CLI: [https://docs.microsoft.com/pt-br/dotnet/core/tools/?tabs=netcore2x](https://docs.microsoft.com/pt-br/dotnet/core/tools/?tabs=netcore2x))
```shell
dotnet new webapi
```

Neste momento foi criado no diretório `~/projeto-teste` (o ~ significa que é o diretório raíz do seu usuário ativo), a estrutura de um projeto webapi, basta associar com a estrutura de pastas do vscode conforme a seguir:

Clique no botão "Open Folder"

![Open Folder Vscode image](/assets/img/posts/vscode-aspnet-core-setup-development-environment/open_folder_vscode.png)

Navegue e abra: `~/projeto-teste`

![Test Project Structure image](/assets/img/posts/vscode-aspnet-core-setup-development-environment/project_test_structure.png)

Coloque um breakpoint qualquer na classe `Startup.cs` e em seguida iremos criar um perfil de debug.

Clique no ícone de debug na barra lateral esquerda e em seguida em "No Configurations" e selecione "Add Configuration…"

![Add Run Debug Configuration Vscode image](/assets/img/posts/vscode-aspnet-core-setup-development-environment/add_run_debug_configuration_vscode.png)

O vscode irá carregar a extensão, então pode demorar alguns poucos segundos, selecione ".NET Core" na barra principal.

Neste momento você perceberá que o vscode criou uma pasta oculta dentro de seu projeto chamada .vscode e dentro, 2 arquivos: launch.json e tasks.json:

![Launch Json image](/assets/img/posts/vscode-aspnet-core-setup-development-environment/launch_json.png)

Estes arquivos dizem a extensão as tarefas que tem que ser feitas para compilar seu projeto e o debugger conseguir se vincular corretamente no processo da sua aplicação.

A configuração atual serve para este projeto teste, então basicamente é necessário apertar o botão de run!

![Run Project image](/assets/img/posts/vscode-aspnet-core-setup-development-environment/run_project.png)

E voilá, debugger funcional:

![Vscode Debbuger image](/assets/img/posts/vscode-aspnet-core-setup-development-environment/vscode_debbuger.png)

Com isso concluímos o setup com sucesso do Visual Studio Code para o .NET Core. Lembrando que o vscode pode ser usado para basicamente qualquer linguagem… Então, apesar de leve, ele é extremamente poderoso e versátil.

Recomendo a utilização do vscode no dia a dia por experiência própria. Sinto que consegui absorver mais conhecimento sobre o funcionamento interno do .NET Core depois que migrei do Visual Studio.

Espero que seja útil para vocês também, abraços e até a próxima!
