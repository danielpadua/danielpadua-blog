---
title: "Entregando um site estático para azure storage"
description: "Aprenda a entregar um site estático para Azure Storage em poucos minutos"
date: 2021-03-07 21:48:00 -0300
last_modified_at: 2021-03-07 21:48:00 -0300
categories: [Azure]
tags: [azure storage]
image:
  src: /assets/img/posts/deploying-static-website-azure-storage/featured.webp
  alt: Logotipos de html5, css3 e javascript seguidos de uma seta horizontal apontando para o logotipo do visual studio code e outra seta horizontal apontando para o logotipo do azure storage
---

> Neste artigo irei demonstrar o quão fácil e barato é realizar o deploy de uma aplicação web estática (que não faz uso de processamento do lado do servidor) na infraestrutura do Azure utilizando o Azure Storage e fazendo a entrega usando o Visual Studio Code.

## Introdução

Muitas vezes quando temos requisitos onde não é necessário haver algum tipo de processamento do front-end do lado do servidor ou [SEO](https://pt.wikipedia.org/wiki/Otimiza%C3%A7%C3%A3o_para_motores_de_busca), podemos fazer uso de aplicações web estáticas ([SPA, MPA](https://imasters.com.br/front-end/por-que-utilizamos-single-page-applications-spa)). Com o adventos dos frameworks javascript ([react](https://pt-br.reactjs.org/), [angular](https://angular.io/), [vue](https://vuejs.org/), etc...) e os geradores de site estáticos ([gatsbyjs](https://www.gatsbyjs.com/), [jekyll](https://jekyllrb.com/), [hugo](https://gohugo.io/), etc...) os sites estáticos passaram a ficar cada vez melhores, além de performarem muito bem (desde que otimizados) e até muitas vezes atender a maioria dos requisitos de qualquer projeto.

Neste artigo introdutório, irei mostrar como realizar o deploy na infraestrutura da Azure, usando o Azure Storage de um website que oferece um jogo da velha. Também irei discutir um pouco sobre os custos de manter este website.

## Requisitos
* [Visual Studio Code](https://code.visualstudio.com/download)
* [Conta Azure](https://azure.microsoft.com/pt-br/free)

## Criando o Azure Storage
O Azure Storage é a solução de armazenamento de objetos (estruturados e não-estruturados) da Microsoft para cloud. Ele engloba vários serviços, para diferentes fins:
- [Azure Blobs](https://docs.microsoft.com/pt-br/azure/storage/blobs/storage-blobs-introduction): Uma object store massiva para guardar dados do tipo texto ou binário, suporta também analytics big data através do Data Lake Storage Gen2
- [Azure Files](https://docs.microsoft.com/pt-br/azure/storage/files/storage-files-introduction): Um compartilhamento de arquivos (file share) completamente gerenciado para uso cloud ou on-premises
- [Azure Queues](https://docs.microsoft.com/pt-br/azure/storage/queues/storage-queues-introduction): Uma área confiável para guardar dados de troca mensagens entre componentes de aplicações
- [Azure Disks](https://docs.microsoft.com/pt-br/azure/virtual-machines/managed-disks-overview): Um storage para guardar volumes para máquinas virtuais Azure (Azure VMs)

Neste artigo iremos utilizar o serviço Azure Blobs, que irá armazenar os arquivos do nosso site estático.

Primeiramente, vamos criar um grupo de recursos - ou *resource group* (utilizado para agrupar recursos Azure), para separar os recursos deste guia do resto dos seus possível recursos. Acesse o [Portal do Microsoft Azure](https://portal.azure.com), faça o login e clique em "Resource Groups" (ou Grupos de Recurso se estiver em português) no menu de favoritos (do lado esquerdo da tela), ou utilize a barra de pesquisa, em seguida clique no botão "Create":

![Criando um Resource Group no Portal da Azure](/assets/img/posts/deploying-static-website-azure-storage/create-resource-group.webp)*Criando um Resource Group no Portal da Azure*

Escolha o nome do Resource Group e a localização do datacenter e clique em Create:

![Preenchendo informações do Resource Group](/assets/img/posts/deploying-static-website-azure-storage/create-resource-group2.webp)*Preenchendo informações do Resource Group*

Clique em Add para adicionar um recurso:

![Adicionando um recurso](/assets/img/posts/deploying-static-website-azure-storage/add-resource.webp)*Adicionando um recurso*

Pesquise por storage aperte enter e selecione "Storage Account" da Microsoft, clique em Create:

![Pesquisando o Azure Storage](/assets/img/posts/deploying-static-website-azure-storage/search-storage.webp)*Pesquisando o Azure Storage*

Preencha as informações necessárias conforme imagem, e clique em "Review + create":

![Preenchendo informações do storage](/assets/img/posts/deploying-static-website-azure-storage/fill-storage-info.webp)*Preenchendo informações do storage*
> Lembre-se que o nome do storage deve ter entre 3 e 24 caracteres e deve conter apenas letras minúsculas e números, sem caracteres especiais

Deixe todas as informações com os valores padrão e clique em "Create":

![Adicionando o storage](/assets/img/posts/deploying-static-website-azure-storage/add-storage.webp)*Adicionando o storage*

A Azure irá iniciar o processo de criação do storage e quando estiver tudo pronto a tela a seguir será apresentada, clique no botão "Go to resource":

![Storage criado com sucesso](/assets/img/posts/deploying-static-website-azure-storage/storage-created.webp)*Storage criado com sucesso*

Se realmente estiver tudo certo, a dashboard do seu storage será exibida conforme a seguir:

![Dashboard do storage](/assets/img/posts/deploying-static-website-azure-storage/storage-dashboard.webp)*Dashboard do storage*

## Clonando a aplicação




