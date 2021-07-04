---
title: "Hospedando site estático no Azure via portal"
description: "Aprenda a criar a infraestrutura necessária para hospedar um site estático no Azure, utilizando o Azure Storage via portal e faça a entrega do fonte com o Visual Studio Code"
date: 2021-07-03 17:00:00 -0300
last_modified_at: 2021-07-03 17:00:00 -0300
categories: [Azure]
tags: [azure storage, visual studio code]
image:
  src: /assets/img/posts/deploying-static-website-azure-storage-portal/featured.webp
  alt: Logotipos de html5, css3 e javascript seguidos de uma seta horizontal apontando para o logotipo do visual studio code e outra seta horizontal apontando para o logotipo do azure storage
---

> Neste artigo irei demonstrar o quão fácil é realizar o deploy de uma aplicação web estática (que não faz uso de processamento do lado do servidor) na infraestrutura do Azure utilizando o Azure Storage e fazendo a entrega usando o Visual Studio Code.

## Introdução

Muitas vezes quando temos requisitos onde não é necessário haver algum tipo de processamento do front-end do lado do servidor, podemos fazer uso de aplicações web estáticas ([SPA, MPA](https://imasters.com.br/front-end/por-que-utilizamos-single-page-applications-spa)). Com o advento dos frameworks javascript ([react](https://pt-br.reactjs.org/), [angular](https://angular.io/), [vue](https://vuejs.org/), etc...) e os geradores de site estáticos ([gatsbyjs](https://www.gatsbyjs.com/), [jekyll](https://jekyllrb.com/), [hugo](https://gohugo.io/) e etc...) os sites estáticos passaram a ficar cada vez melhores, além de performarem muito bem (desde que otimizados) e até muitas vezes atender a maioria dos requisitos de qualquer projeto.

Neste artigo introdutório, irei mostrar como realizar o deploy na infraestrutura do Azure, usando o Azure Storage utilizando o fonte de um website que oferece um jogo da velha.

## Requisitos
* [Visual Studio Code](https://code.visualstudio.com/download)
* [Conta Azure](https://azure.microsoft.com/pt-br/free)

## Criando o Azure Storage
O Azure Storage é a solução de armazenamento de objetos (estruturados e não-estruturados) da Microsoft para cloud. Ele engloba vários serviços, para diferentes fins:
- [Azure Blobs](https://docs.microsoft.com/pt-br/azure/storage/blobs/storage-blobs-introduction): Uma object store massiva para guardar dados do tipo texto ou binário, suporta também analytics big data através do Data Lake Storage Gen2
- [Azure Files](https://docs.microsoft.com/pt-br/azure/storage/files/storage-files-introduction): Um compartilhamento de arquivos (file share) completamente gerenciado para uso cloud ou on-premises
- [Azure Queues](https://docs.microsoft.com/pt-br/azure/storage/queues/storage-queues-introduction): Uma área confiável para guardar dados de troca mensagens entre componentes de aplicações
- [Azure Disks](https://docs.microsoft.com/pt-br/azure/virtual-machines/managed-disks-overview): Um storage para guardar volumes para máquinas virtuais Azure (Azure VMs)

Neste artigo iremos utilizar o serviço **Azure Blobs**, que irá armazenar os arquivos do nosso site estático.

Primeiramente, vamos criar um grupo de recursos - ou *resource group* (utilizado para agrupar recursos Azure), para separar os recursos deste guia do resto dos seus possível recursos. Acesse o [Portal do Microsoft Azure](https://portal.azure.com), faça o login e clique em "Resource Groups" (ou Grupos de Recurso se estiver em português) no menu de favoritos (do lado esquerdo da tela), ou utilize a barra de pesquisa, em seguida clique no botão "Create":

![Criando um Resource Group no Portal da Azure](/assets/img/posts/deploying-static-website-azure-storage-portal/create-resource-group.webp)*Criando um Resource Group no Portal da Azure*

Escolha o nome do Resource Group e a localização do datacenter e clique em Create:

![Preenchendo informações do Resource Group](/assets/img/posts/deploying-static-website-azure-storage-portal/create-resource-group2.webp)*Preenchendo informações do Resource Group*

Certifique-se de que está navegando dentro do Resource Group criado na etapa anterior e clique em `Create > Marketplace` para adicionar um recurso:

![Adicionando um recurso](/assets/img/posts/deploying-static-website-azure-storage-portal/add-resource.webp)*Adicionando um recurso*

Pesquise por storage aperte enter e selecione "Storage Account" da Microsoft, clique em Create:

![Pesquisando o Azure Storage](/assets/img/posts/deploying-static-website-azure-storage-portal/search-storage.webp)*Pesquisando o Azure Storage*

Preencha as informações necessárias conforme imagem, e clique em "Review + create":

![Preenchendo informações do storage](/assets/img/posts/deploying-static-website-azure-storage-portal/fill-storage-info.webp)*Preenchendo informações do storage*
> Lembre-se que o nome do storage deve ser único globalmente (único entre todos os storages registrados no Azure), ter entre 3 e 24 caracteres e deve conter apenas letras minúsculas e números, sem caracteres especiais

Deixe todas as informações com os valores padrão e clique em "Create":

![Adicionando o storage](/assets/img/posts/deploying-static-website-azure-storage-portal/add-storage.webp)*Adicionando o storage*

O Azure irá iniciar o processo de criação do storage e quando estiver tudo pronto a tela a seguir será apresentada, clique no botão "Go to resource":

![Storage criado com sucesso](/assets/img/posts/deploying-static-website-azure-storage-portal/storage-created.webp)*Storage criado com sucesso*

Se realmente estiver tudo certo, a dashboard do seu storage será exibida conforme a seguir:

![Dashboard do storage](/assets/img/posts/deploying-static-website-azure-storage-portal/storage-dashboard.webp)*Dashboard do Azure Storage*

## Instalando a extensão Azure Storage

Com a infraestrutura criada e pronta para abrigar seu site estático, é hora de garantir que seu Visual Studio Code tenha as extensões necessárias para poder publicar os arquivos do projeto no Azure Storage criado. Para isto, abra o vscode e no menu do lado esquerdo vá em `Extensions` ou aperte `ctrl+shift+X` e pesquise por `azure storage`:

![Pesquisando a extensão do azure storage](/assets/img/posts/deploying-static-website-azure-storage-portal/azure-storage-extension-search.webp)*Pesquisando a extensão do azure storage*

Ou simplesmente siga [este link](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurestorage) e clique em `Install`.

Esta extensão irá instalar automáticamente a extensão `Azure Account` onde irá criar o menu Azure no lado esquerdo da tela, no qual você irá realizar login utilizando seu e-mail e senha Azure. Siga os passos que a extensão irá lhe pedir e garanta que sua conta esteja logada e suas subscriptions apareçam conforme imagem:

![Extensão Azure Storage login com sucesso](/assets/img/posts/deploying-static-website-azure-storage-portal/azure-storage-extension-logged-in.webp)*Extensão Azure Storage login com sucesso*

## Clonando e publicando a aplicação

Agora vamos preparar o site estático para o deploy no Azure, no Visual Studio Code abra o terminal (`menu superior > terminal > new terminal` ou `` ctrl+shift+` `` ou `` cmd+shift+` `` no mac) navegue e escolha o diretório que preferir para abrigar o projeto. Em seguida clone o projeto utilizando e navegue até ele com:
```shell
git clone https://github.com/danielpadua/js-tic-tac-toe.git my-static-website
cd my-static-website
```

Agora abra o diretório criado no Visual Studio Code: `File > Open Folder > ...`:

![Estrutura do projeto](/assets/img/posts/deploying-static-website-azure-storage-portal/project-tree-vscode.webp)*Estrutura do projeto*

Para entregar o projeto no Azure Storage criado, é necessário simplesmente clicar no diretório que deseja entregar com o botão direito e em seguida escolher a opção `Deploy to static Website via Azure Storage`. Como queremos entregar todos os arquivos do diretório aberto, vamos clicar com o botão direito sobre o espaço vazio na raíz da árvore de arquivos conforme a seguir:

![Clique na opção indicada em vermelho para entregar todos os arquivos](/assets/img/posts/deploying-static-website-azure-storage-portal/ready-to-deploy.webp)*Clique na opção indicada em vermelho para entregar todos os arquivos*

Na sequência irão aparecer algumas opções para que você possa indicar à extensão em qual Azure Storage você quer entregar os arquivos, caso você tenha mais de uma subscription, você deverá selecionar a mesma que criou o Storage nos passos anteriores e em seguida selecione-o:


![Selecione o mesmo Storage criado nos passos anteriores](/assets/img/posts/deploying-static-website-azure-storage-portal/choose-which-azure-storage.webp)*Selecione o mesmo Storage criado nos passos anteriores*

Ao selecionar, a extensão poderá te avisar que a opção de hospedar sites estáticos não está habilitada no Storage selecionado e irá perguntar se você deseja habilitar. Escolha a opção `Enable website hosting`.

Em seguida você será questionado sobre qual será o nome do arquivo html que deverá ser considerado o renderizado ao usuário atingir a URL raíz do website, deixe escrito `index.html` e aperte enter. Na sequência irá te perguntar sobre qual nome de arquivo considerar quando o usuário tentar acessar algum documento que não existe. No caso deste projeto não há tratamento então podemos seguir com o `index.html` sugerido, mas caso seu projeto tenha indique o nome do arquivo correto.

Pressione enter novamente e o deploy irá iniciar. Após o término com sucesso, a mensagem a seguir deverá aparecer no canto inferior direito de sua tela:

![Deploy feito com sucesso](/assets/img/posts/deploying-static-website-azure-storage-portal/deploy-complete.webp)*Deploy feito com sucesso*

Navegue até o link indicado na mensagem e veja seu site!

![Website Pronto!](/assets/img/posts/deploying-static-website-azure-storage-portal/website-ready.webp)*Website Pronto!*


## Conclusão

Em apenas alguns minutos é possível entregar um site estático no Azure utilizando o Visual Studio Code. Mas não apenas fácil, é barato também. Na verdade acredito que o que torna este modelo mais atraente é o preço.

Neste momento eu mantenho 2 sites estáticos no Azure com poucos acessos e o custo gira em torno de R$13,00 ao mês, mas o cálculo de custo é feito com base por largura de banda (transferência de dados) e quantidade de storage usado (tamanho). O melhor jeito de ter uma noção de quanto irá gastar é ver na própria calculadora do Azure: [https://azure.microsoft.com/en-us/pricing/calculator/?service=storage](https://azure.microsoft.com/en-us/pricing/calculator/?service=storage).

Espero que este guia tenha sido útil para você, obrigado e até a próxima!
