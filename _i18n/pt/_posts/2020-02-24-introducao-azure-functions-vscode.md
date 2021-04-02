---
title: "Introdução Azure Functions + Vscode"
description: "Azure Functions, Serverless: Uma introdução ao mundo serverless na plataforma Microsoft Azure, aprendendo como construir e entregar uma API feita com javascript e nodejs"
date: 2020-02-24 12:00:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Serverless, Azure]
tags: [serverless, azure functions, visual studio code, javascript]
image:
  src: /assets/img/posts/introduction-to-azure-functions-vscode/featured.png
  alt: Logotipo do azure functions com um sinal de soma, seguido pelo logotipo do visual studio code
---

## Introdução
Como desenvolvedor fui capaz de presenciar algumas transformações significativas no mercado ao longo do tempo, como por exemplo:

* Um grande movimento de migração do paradigma de programação estruturada para o orientado a objetos.
* Maior foco em desenvolvimento web ao invés de desktop.
* Criação e aumento vertiginoso de desenvolvimento de apps para mobile.
* Troca da escalabilidade vertical para escalabilidade horizontal com surgimento de cloud computing.
* Adoção de micro-serviços ao invés de monólitos.

E, recentemente, na verdade já há algum tempo, venho notando que há um grande movimento de adoção de [*serverless*](https://en.wikipedia.org/wiki/Serverless_computing) para aplicações novas e modernas, substituindo em muitos casos até mesmo os micro-serviços.

A arquitetura serverless é capaz de prover muita facilidade, flexibilidade, escalabilidade automática e outros benefícios, até mesmo parecido com os de micro-serviços, no entanto, as maiores diferenças entre eles na minha opinião é a facilidade e a redução de custos.

Com serverless você não precisa se preocupar em alocar um servidor para seu app, muito menos, preocupar-se em como escalá-lo. Você precisa se importar, apenas, com a resolução de seu problema de negócio por meio de código, o que dá uma grande velocidade para lançamento de novas features ou produtos. E, na maioria dos provedores cloud, você paga apenas o que usa, trazendo redução de custos significativos se comparado a uma instância que está sempre executando, mesmo que esteja sem carga.

Neste artigo introdutório, abordarei como iniciar o desenvolvimento serverless na plataforma Microsoft Azure, utilizando o vscode como editor de código para o desenvolvimento e deploy de uma função que retornará um "Hello World" após uma chamada GET ou POST de HTTP.

## Pré-requisitos
* [Visual Studio Code](https://code.visualstudio.com/download)
* [Conta Azure](https://azure.microsoft.com/pt-br/free)

## Instalação e configuração do ambiente de desenvolvimento
Para que possamos trabalhar com functions de uma maneira eficiente é necessário, minimamente, montar um ambiente de desenvolvimento local no qual possamos escrever código, rodar e debugar. Utilize as seções abaixo de acordo com seu sistema operacional.

### Windows

#### Instalar o NodeJs

Neste guia, trabalharemos com Azure Functions versão 3.x, portanto **devemos instalar as versões 10.x.x ou 12.x.x do NodeJs**. Se por alguma razão você queira utilizar a versão 2.x utilize o NodeJs 8.x.x.
> Existe uma incompatibilidade no Windows com versões de NodeJs ≥ 13.x.x e Core Tools 3.x, portanto, por ora, utilize as versões explicitadas acima: ([https://github.com/Azure/azure-functions-core-tools/issues/1804](https://github.com/Azure/azure-functions-core-tools/issues/1804))

Há diferentes formas de se fazer isso:

* **Instalar diretamente por [download do site do NodeJs](https://nodejs.org/dist/)**

  Escolha na lista uma das versões especificadas acima e procure o instalador com sufixo "**win-x64**", se a esta altura de 2020 a arquitetura da máquina em que você está não for 64 bits, procure pelo sufixo "**win-x86**" para arquiteturas 32 bits.

* **Instalar via gerenciador de pacotes com NVM**

  O [NVM](https://github.com/nvm-sh/nvm) é um programa de linha de comando que possui a função de gerenciar mais facilmente múltiplas instalações de versões do NodeJs. Utilizando por exemplo: [Chocolatey para Windows](https://medium.com/danielpadua/utilizando-chocolatey-para-windows-2b51c0ba9b31) podemos instalar o nvm através da linha: `choco install nvm`, e depois instale uma das versões acima com: `nvm install $versao` e depois vincule-a em uso com: `nvm use $versao`.

#### Instalar Azure Core Tools
É este cara que permite a criação de um ambiente de execução local de suas funções e as rode via linha de comando, podendo até se comunicar com recursos da Azure, o que não é recomendável, pois o mais correto seria apartar os ambientes completamente, mas funciona.

A instalação dele no Windows é feita via NodeJs, através da linha de comando no PowerShell ou cmd:
```powershell
npm install -g azure-functions-core-tools@3
```

Caso queira instalar a versão 2.x seria:
```powershell
npm install -g azure-functions-core-tools
```

Após instalação, teste a instalação mandando apenas um:
```powershell
func --version
```

Caso você veja um erro parecido com este:

![Erro de permissão de execução de scripts NodeJs](/assets/img/posts/introduction-to-azure-functions-vscode/nodejs_scripts_permission_error.png)*Erro de permissão de execução de scripts NodeJs*

Rode o comando a seguir no PowerShell como administrador para dar permissão para que os scripts instalados pelo NodeJs sejam executados:
```powershell
Set-ExecutionPolicy RemoteSigned
```

Caso haja algum erro envolvendo "**Unhandled ‘error’ event**", é bem provável que seja incompatibilidade entre as versões do Core Tools com o NodeJs, refaça o passo acima.

### MacOs

#### Instalar o NodeJs
Neste guia, iremos trabalhar com Azure Functions versão 3.x, portanto **devemos instalar versões ≥ 10.x.x do NodeJs**. Se por alguma razão você queira utilizar a versão 2.x utilize o NodeJs 8.x.x.

Há diferentes formas de se fazer isto:

* **Instalar diretamente por [download do site do NodeJs](https://nodejs.org/dist/)**

  Escolha uma das versões especificadas acima, procure o instalador com extensão "**.pkg**" e faça o instalação **NNF** (next, next, finish).

* **Instalar via gerenciador de pacotes com NVM**

  O [NVM](https://github.com/nvm-sh/nvm) é um programa de linha de comando que possui a função de gerenciar mais facilmente múltiplas instalações de versões do NodeJs. Utilizando por exemplo: [Homebrew para MacOs](/pt/posts/utilizando-o-homebrew-no-macos) para instalar o nvm através da linha: `brew install nvm` e depois instale uma das versões acima com: `nvm install ${versao}` e depois vincule-a em uso com: `nvm use ${versao}`.

#### Instalar Azure Core Tools
É este cara que permite a criação de um ambiente de execução local de suas funções e as execute via linha de comando, podendo até se comunicar com recursos da Azure, o que não é recomendável, pois o mais correto seria apartar os ambientes completamente, mas funciona.

Instale a versão 3.x utilizando o Homebrew, com as linhas:
```shell
brew tap azure/functions
brew install azure-functions-core-tools@3
# executar linha abaixo caso você esteja fazendo upgrade da versão 2.x para a 3.x na sua máquina
brew link --overwrite azure-functions-core-tools@3
```

Para instalar a versão 2.x utilize as linhas:
```shell
brew tap azure/functions
brew install azure-functions-core-tools
```

Por fim, teste o funcionamento com a linha:
```shell
func --version
```

### Linux

#### Instalar o NodeJs
Neste guia, trabalharemos com Azure Functions versão 3.x, portanto **devemos instalar versões ≥ 10.x.x do NodeJs**. Se por alguma razão você queira utilizar a versão 2.x utilize o NodeJs 8.x.x.

Há diferentes formas de se fazer isso:

* **Instalar diretamente por [download do site do NodeJs](https://nodejs.org/dist/)**

  Escolha uma das versões especificadas acima e procure o instalador com o sufixo “**.linux-x64.tar.gz**”, baixe, extrai-o, coloque-o em um diretório de fácil acesso e crie um link simbólico para o arquivo: "**/bin/node**".

* **Instalar via gerenciador de pacotes com NVM**

  O [NVM](https://github.com/nvm-sh/nvm) é um programa de linha de comando que possui a função de gerenciar mais facilmente múltiplas instalações de versões do NodeJs. Utilizando o gerenciador de pacotes de distribuição linux que você faz uso, instale o NVM, e depois instale uma das versões acima com: `nvm install ${versao}`, posteriormente, vincule-a em uso com: `nvm use ${versao}`.

#### Instalar Azure Core Tools
É este cara que permite que você crie um ambiente de execução local de suas funções e as execute via linha de comando. Podendo até se comunicar com recursos da Azure, o que não é recomendável, pois o mais correto seria apartar os ambientes completamente, mas funciona.

Caso sua distribuição for baseada em Debian, você pode utilizar este [guia da Microsoft](https://docs.microsoft.com/pt-br/azure/azure-functions/functions-run-local?tabs=linux#v2) para instalar o Core Tools. Caso seja outra distribuição, verifique o [README do Core Tools](https://github.com/Azure/azure-functions-core-tools/blob/master/README.md#linux).

Teste o funcionamento do Core Tools com a linha:
```shell
func --version
```

### Instalar o plugin Azure Functions no vscode
Abra **Extensões** e procure por: **Azure Functions** ou [use este link](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions).

![Instalação do plugin Azure Functions no vscode](/assets/img/posts/introduction-to-azure-functions-vscode/installing_functions_plugin_vscode.png)*Instalação do plugin Azure Functions no vscode*

Depois de instalado, reinicie o vscode e confirme que juntamente ao plugin Azure Functions foi instalado o Azure Account. Faça login conforme a imagem abaixo:

![Realizando login na sua conta Azure](/assets/img/posts/introduction-to-azure-functions-vscode/signin_azure_account.png)*Realizando login na sua conta Azure*

Você deve ser redirecionado a realizar login Microsoft no seu browser padrão, após isso, retorne ao vscode e seus recursos Azure serão exibidos.

## Criando e debugando uma function localmente
Agora, com o ambiente de desenvolvimento pronto, vamos criar uma function simples de Hello World. Para isso, na tela inicial do vscode, utilize a combinação de teclas: Ctrl+Shift+P (Windows ou Linux) ou Cmd+Shift+P (MacOs). A paleta de comandos deve abrir e comece a digitar: **functions create new project**:

![Criar projeto de functions](/assets/img/posts/introduction-to-azure-functions-vscode/create_function_project.png)*Criar projeto de functions*

Um projeto de functions é capaz de armazenar N funções de diferentes tipos, acionadas por Http, por tempo, estimulo de fila e etc.

Caso você não esteja com algum diretório aberto no vscode, ele pedirá para abrir um. Crie um diretório onde guardaremos os fontes do nosso projeto e selecione-o. Após esta etapa, você será questionado em qual linguagem deseja desenvolver, para este exemplo, usaremos **Javascript**:

![Escolha sua linguagem para desenvolvimento de functions](/assets/img/posts/introduction-to-azure-functions-vscode/choose_language.png)*Escolha sua linguagem para desenvolvimento de functions*

Seu próximo questionamento é: desejo utilizar algum template de function pré-pronto de acordo com o tipo de trigger que irei dispará-la? Novamente, para nosso exemplo, iremos selecionar uma trigger http:

![Template de function Http Trigger](/assets/img/posts/introduction-to-azure-functions-vscode/http_trigger_template.png)*Template de function Http Trigger*

O passo seguinte consiste apenas em dar um nome para a function, eu costumo utilizar a nomenclatura: **nome_TipoTrigger**, para quando bater o olho no diretório da function, já saber o que a dispara, no entanto, você pode usar a nomenclatura que preferir.

Agora, selecione qual o nível de autorização da function. Existem 3 tipos de autorização padrão de functions:

* **Function**: há uma chave de acesso no nível da função que é criada no portal do Azure, a ser utilizada para autenticar chamadas em seus endpoints, passando na request via Query String ou parâmetro no Header da solicitação Http. Caso este parâmetro não seja preenchido ou esteja incorreto, a função devolverá o status Http 401 — Não autorizado.

* **Anonymous**: como o próprio nome já diz, sem autorização, seus endpoints podem ser atingidos por todos sem qualquer tipo de autorização.

* **Admin**: assim como existe uma chave de acesso no nível da função, existe uma chave de admin chamada **host key**, também criada no Azure, que somente ela liberará acesso na function, caso esta autorização seja selecionada. Caso não informado ou estiver incorreto, a função devolverá o status Http 401 — Não autorizado.

Por último, selecione para abrir o projeto na mesma janela, caso você já não tivesse com uma pasta aberta.

Seu projeto criado deverá estar como na imagem abaixo:

![Estrutura de diretórios de projeto function javascript](/assets/img/posts/introduction-to-azure-functions-vscode/javascript_function_structure.png)*Estrutura de diretórios de projeto function javascript*

Para javascript as functions são separadas em pastas sempre contendo 3 arquivos:

* **function.json**

![function.json](/assets/img/posts/introduction-to-azure-functions-vscode/function_json.png)*function.json*

É responsável por dizer ao Azure quais bindings vamos utilizar. Bindings é uma maneira de conectar um recurso Azure como uma fila, tópico, banco de dados, ação http e etc. com a function, podendo ele ter uma direção (input ou output).

Por exemplo, o primeiro objeto consiste em uma configuração específica de função acionada por trigger Http onde a direção é **in**, ou seja, chegando para sua função pelos verbos: **get** e **post** através do parâmetro de nome **req**. E o segundo objeto é a saída "**out**" do tipo http podendo ser acessado através do parâmetro **res**.

* **index.js**

![index.js](/assets/img/posts/introduction-to-azure-functions-vscode/index_js.png)*index.js*

Este é o arquivo onde ficará a lógica de sua função, onde você poderá programar livremente. Conforme configurado no **function.json**, os parâmetros de binding de nome: **req** e **res,** estão definidos no template padrão. Repare como eles são utilizados para pegar parâmetros enviados (**req**) para o endpoint e para enviar a resposta ao chamador (**res)**.

* **sample.dat**

![sample.dat](/assets/img/posts/introduction-to-azure-functions-vscode/sample_dat.png)*sample.dat*

Esse arquivo serve apenas para popular uma chamada teste para API quando utilizada a interface de testes da própria da Azure:

![Onde o sample.dat é utilizado](/assets/img/posts/introduction-to-azure-functions-vscode/sample_dat_in_azure_portal.png)*Onde o sample.dat é utilizado*

Por fim, e não menos importante, o arquivo **local.settings.json** é onde podemos configurar "variáveis de ambiente" locais. As chaves neste arquivo são, geralmente, utilizadas para guardar configurações não sensíveis, portanto, **não é uma boa ideia guardar senha de usuário de bancos de dados aqui**. Uma ideia bem melhor seria [apontar uma referência para extrair o valor do **Azure Key Vault**, por exemplo](https://medium.com/statuscode/getting-key-vault-secrets-in-azure-functions-37620fd20a0b).

Finalmente, coloque um breakpoint na linha 4 (no primeiro if) e executemos o projeto:

![Iniciando nossa saga serverless](/assets/img/posts/introduction-to-azure-functions-vscode/run_debug_function.png)*Iniciando nossa saga serverless*

Aguarde um tempo até que as mensagens a seguir apareçam em seu terminal integrado:

![Subiu e está ‘debugável’](/assets/img/posts/introduction-to-azure-functions-vscode/function_running.png)*Subiu e está ‘debugável’*
> Caso tenha ocorrido algum problema, novamente, reveja os passos acima. A probabilidade de que tenha ocorrido algum problema de incompatibilidade de versões entre o NodeJs e o Core Tools é grande!

A função sobe um pouco antes do debugger conseguir se vincular ao processo, então, caso você chame o endpoint mais rápido que o vínculo, o breakpoint não será acionado.

Experimente chamar no seu browser o endpoint indicado na imagem acima. Primeiramente, seu breakpoint será acionado, mudando o foco para o vscode:

![Debugando uma Azure Function localmente](https://cdn-images-1.medium.com/max/4484/1*tKDqQYG2EHL3cGLUIn2gOA.png)*Debugando uma Azure Function localmente*

Selecione o botão de "resume" para soltar o debugger, volte ao browser e o resultado deverá ser este:

![Hello exigindo um parâmetro](/assets/img/posts/introduction-to-azure-functions-vscode/debugging_function.png)*Hello exigindo um parâmetro*

O template de function de Hello World espera que seja passado um parâmetro de nome: "**name**" via query string ou no request body, com o seu nome para que ele possa te dar o Hello. Aproveite um pouco do tempo para entender no código como funciona a dinâmica de passagem de parâmetros através do objeto **req**. Depois, faça uma chamada usando query string, como na imagem seguinte:

![Hello World funcional!](/assets/img/posts/introduction-to-azure-functions-vscode/functional_hello_world.png)*Hello World funcional!*

Os testes que fizemos até agora foram apenas via verbo: **get**. Vamos fazer agora um pelo verbo: **post**. Para isso, você pode usar qualquer ferramenta de sua preferência, desde [curl](https://curl.haxx.se/) até o [Postman](https://www.postman.com/). Para este exemplo, vamos de Postman:

![Exemplo de chamada POST com parâmetro JSON](/assets/img/posts/introduction-to-azure-functions-vscode/call_function_from_postman.png)*Exemplo de chamada POST com parâmetro JSON*

## Realizando deploy para sua conta Azure
Agora que montamos todo o ambiente de desenvolvimento, criamos a function e a testamos localmente, vamos subi-la para Azure para chamá-la através da Internet. Existem muitas maneiras de se fazer este processo, a saber: criar uma function via Portal e fazer upload manualmente, criar uma esteira de entregas contínuas (altamente recomendável) ou realizar deploy via vscode (na realidade ele utiliza a Azure CLI por trás dos panos), que é o que irei abordar neste guia por conta da simplicidade.

Pare seu debug da function, caso não o tenha feito ainda, e suba a paleta de comandos (Ctrl+Shift+P no Windows/Linux ou Cmd+Shift+P no MacOs), comece a digitar: **azure functions deploy** e selecione "Azure Functions: Deploy to Function App…":

![Iniciando o deploy](/assets/img/posts/introduction-to-azure-functions-vscode/start_deploy.png)*Iniciando o deploy*

Selecione sua subscription ativa e na sequência aparecerá alguma function, caso você já a tenha criado. Selecione "Create new Function App in Azure… Advanced":

![Criar uma função na Azure](/assets/img/posts/introduction-to-azure-functions-vscode/create_function_in_azure.png)*Criar uma função na Azure*

Escolha um nome para a função. Este nome deve ser globalmente único, portanto, ninguém no Azure pode ter functions com nomes iguais. Após isso, selecione o sistema operacional para realizar deploy, eu irei utilizar neste exemplo, o **Linux**.

Você será questionado também sobre o "hosting plan", que será a forma de pagamento deste recurso (function). Existem três planos:

![Planos de pagamento](/assets/img/posts/introduction-to-azure-functions-vscode/hosting_plans.png)*Planos de pagamento*

* **Consumption**

  Neste plano, as instâncias de sua function são dinamicamente alocadas e desalocadas de acordo com a carga dos eventos de trigger, garantindo escalabilidade sem preocupação com a implementação da mesma e você também só é cobrado durante a execução da função, ou seja, caso não haja execuções, não existe cobrança.

  Atualmente, existe uma concessão de 1 milhão de chamadas gratuitas, o que torna o serverless muito atrativo financeiramente. [Maiores informações de cobrança aqui](https://azure.microsoft.com/pt-br/pricing/details/functions/).

  Porém o custo dessa escalabilidade é um problema chamado: [cold start](https://azure.microsoft.com/pt-br/blog/understanding-serverless-cold-start/) ou partida a frio. Caso sua função fique sem ser chamada por um período de tempo, a Azure a coloca em um modo frio no qual a chamada seguinte terá uma demora maior até a Azure levantar e a deixar quente. As chamadas subsequentes são mais rápidas.

  Também existe um limitador de tempo de duração da função (configurável até um certo limite) que retorna timeout ao chamador caso o ultrapasse.

* **Premium**

  Basicamente, igual ao Consumption, no entanto, possui algumas vantagens como: não existe cold start, as instâncias de funções são sempre quentes, conectividade com VNet, tempo de duração ilimitado, entre outros. A forma de cobrança é diferente, podendo, provavelmente, o pagamento ser maior do que o Consumption, devido aos benefícios extras.

* **App Service Plan**

  Neste plano, suas funções podem rodar nas mesmas VMs que as tradicionais da App Services. Este cenário pode fazer sentido para você caso possua uma instância sub-utilizada, por exemplo, otimizando o uso x cobrança. Como a instância está sempre ligada, a function estará sempre quente também. Você continuará sendo cobrado pelo método do seu App Service.

  Iremos de Consumption no exemplo a seguir: selecione-o e, na sequência, vamos escolher a runtime da function: **Node.js 12.x** (Caso Core Tools v3):

![Escolha da runtime](/assets/img/posts/introduction-to-azure-functions-vscode/runtime_choices.png)*Escolha da runtime*

Selecione ou crie um grupo de recursos para aninhar sua função e depois uma Storage Account. Este último é necessário para armazenar o bundle de código da sua function e também para a parametrizações de versão da runtime da Azure Functions em si.

No passo 9/10 você poderá selecionar um Application Insight. Este é um recurso interessantíssimo da Azure que é utilizado para extrair de logs informações importantes de saúde ou funcionamento da sua function. Como estamos apenas num Hello World, podemos seguir sem ele selecionando a opção: "Skip for now".

Por último selecione em qual região suportada pela Azure você deseja que a function esteja, selecione sua preferida, assim sua function será criada e o código do Hello World local será entregue. Depois de concluído, clique na aba "Output" e, ao final, você poderá pegar o link para sua função que já está rodando na infraestrutura da Azure, conforme abaixo:

![Função entregue com sucesso!](/assets/img/posts/introduction-to-azure-functions-vscode/function_deployed.png)*Função entregue com sucesso!*

Com um teste rápido no seu browser você verá o mesmo dos testes locais:

![Rodando em "produção"](/assets/img/posts/introduction-to-azure-functions-vscode/production_running_function.png)*Rodando em "produção"*

## Conclusão
Eu acredito que o serverless veio pra ficar e será cada vez mais adotado com o passar do tempo, principalmente pelas vantagens de velocidade de desenvolvimento e redução de custos. No entanto, quebrar nosso código talvez num nível mais "micro" do que micro-serviços pode tornar a tarefa de um teste integrado automatizado um tanto quanto difícil quando existem tantas peças e comunicações tão variadas entre elas.

Espero ter ajudado a dar uma clareada em serverless e Azure Functions. Até a próxima!

## Referências
- [**https://docs.microsoft.com/pt-br/azure/azure-functions/functions-develop-vs-code?tabs=csharp**](https://docs.microsoft.com/pt-br/azure/azure-functions/functions-develop-vs-code?tabs=csharp)
