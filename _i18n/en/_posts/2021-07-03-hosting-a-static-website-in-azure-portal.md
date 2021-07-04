---
title: "Hosting a static website in Azure via Portal"
description: "Learn how to create the required infraestructure to host a static website in Azure, using Azure Storage via portal and deploy the project source with Visual Studio Code"
date: 2021-07-03 17:00:00 -0300
last_modified_at: 2021-07-03 17:00:00 -0300
categories: [Azure]
tags: [azure storage, visual studio code]
image:
  src: /assets/img/posts/deploying-static-website-azure-storage-portal/featured.webp
  alt: Html5, css3 and javascript logos followed by a horizontal arrow pointing to visual studio code logo and another horizontal arrow pointing to azure storage logo
---

> In this article I'll show how easy is to host and deploy a static web application (that doesn't require server-side processing) to Azure's infraestructure making use of Azure Storage and delivering it with Visual Studio Code

## Intro

There are times when our front-end projects doesn't require any kind of server-side processing. When that happens we can make use of completly static web applications such as [SPA and MPA](https://merehead.com/blog/single-page-application-vs-multi-page-application).
With the advent of javascript frameworks such as [react](https://pt-br.reactjs.org/), [angular](https://angular.io/), [vue](https://vuejs.org/), etc... and the static website generators like [gatsbyjs](https://www.gatsbyjs.com/), [jekyll](https://jekyllrb.com/), [hugo](https://gohugo.io/), etc... static websites grown better, faster, cleaner and more able to meet most requirements of any project.

In this introductory article I'll show how to deploy a simple tictactoe static website to Azure's infraestructure using Azure Storage and Visual Studio Code. Let's get to it.

## Requirements
* [Visual Studio Code](https://code.visualstudio.com/download)
* [Azure Account](https://azure.microsoft.com/en-us/free)

## Creating a Azure Storage
Azure Storage is Microsoft's cloud solution to store objects (structured or non-structured). It encompasses several services, for different purposes:
- [Azure Blobs](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction): A massive object store used to retain any kind of text or binary data. It also supports analytics big data through Data Lake Storage Gen2
- [Azure Files](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-introduction): A completely managed file share for cloud or on-premises environment
- [Azure Queues](https://docs.microsoft.com/en-us/azure/storage/queues/storage-queues-introduction): A reliable area to store data exchange messages between applications and components
- [Azure Disks](https://docs.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview): A storage to retain volumes for Azure Virtual Machines (Azure VMs)

In this article we'll use **Azure Blobs** service, that will store all our static website files.

First of all, let's create a resource group to separate this guide's resources from all your possible other resources. Access [Microsoft Azure Portal](https://portal.azure.com), log in and click `Resource Groups` in favorites menu (left side of the screen), or use the search bar. Next click `Create` button:

![Creating a Resource Group in Azure's Portal](/assets/img/posts/deploying-static-website-azure-storage-portal/create-resource-group.webp)*Creating a Resource Group in Azure's Portal*

Choose the Resource Group name and the datacenter location and click `Create` again:

![Filling Resource Group information](/assets/img/posts/deploying-static-website-azure-storage-portal/create-resource-group2.webp)*Filling Resource Group information*

Ensure that you are navigating inside the recently created Resource Group and click `Create > Marketplace` to add a resource:

![Adding a resource](/assets/img/posts/deploying-static-website-azure-storage-portal/add-resource.webp)*Adding a resource*

Search for "storage" and hit enter, then select "Storage Account" from Microsoft and click `Create`:

![Search for Azure Storage](/assets/img/posts/deploying-static-website-azure-storage-portal/search-storage.webp)*Search for Azure Storage*

Fill all the required fields as the following image and click `Review + create`:

![Filling storage information](/assets/img/posts/deploying-static-website-azure-storage-portal/fill-storage-info.webp)*Filling storage information*
> Storage name must be globally unique (accross all storages registered in Azure), it must be 3 to 24 characters long and can contain only lowercase letters and numbers

Leave all informations with default values and click `Create`:

![Adding the storage](/assets/img/posts/deploying-static-website-azure-storage-portal/add-storage.webp)*Adding the storage*

Azure will begin the creation of the storage and when it's ready, the following screen will be presented. Click the button `Go to resource`:

![Storage successfully created](/assets/img/posts/deploying-static-website-azure-storage-portal/storage-created.webp)*Storage successfully created*

If everything is ok, your storage dashboard will look like this:

![Storage's dashboard](/assets/img/posts/deploying-static-website-azure-storage-portal/storage-dashboard.webp)*Storage's dashboard*

## Installing Azure Storage extension

With the required infraestructure to store our static website ready, it's time to ensure that your Visual Studio Code have the required extensions to publish your project files to the recently created Azure Storage. So, open your vscode, look for `Extensions` in the left side menu or simply press `ctrl+shift+X` and search for `azure storage`:

![Searching for azure storage extension](/assets/img/posts/deploying-static-website-azure-storage-portal/azure-storage-extension-search.webp)*Searching for azure storage extension*

Or, you can click [this link](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurestorage) then click `Install`.

This extension will automatically install `Azure Account` extension, which will create Azure menu in screen's left side. Click it and log in using your Azure email and password, follow the steps the extension show you and make sure your account is logged in and your subscriptions are showing, like this:

![Azure Account logged in](/assets/img/posts/deploying-static-website-azure-storage-portal/azure-storage-extension-logged-in.webp)*Azure Account logged in*

## Cloning and deploying the app

Now let's get our tictactoe static website ready to deploy to Azure. In Visual Studio Code open the terminal (`superior menu > terminal > new terminal` or `` ctrl+shift+` `` or `` cmd+shift+` `` in mac) navigate to a directory of your preference to store the project. Then clone the project and navigate to it with:
```shell
git clone https://github.com/danielpadua/js-tic-tac-toe.git my-static-website
cd my-static-website
```

Now open the created directory in Visual Studio Code via `File > Open Folder > ...`:

![Project structure](/assets/img/posts/deploying-static-website-azure-storage-portal/project-tree-vscode.webp)*Project structure*

To deploy the project to the recently created Azure Storage, you simply have to right-click in the directory you wish to deploy and choose the `Deploy to static Website via Azure Storage` option. In this project, we'll want to deliver all the opened files, so, let's right-click over the empty space in the root of the files tree as following:

![Click the highlighted option to deploy all files](/assets/img/posts/deploying-static-website-azure-storage-portal/ready-to-deploy.webp)*Click the highlighted option to deploy all files*

Then some options will pop-up for you to tell the extension in which Azure Storage you want to deliver the files, if you have more than one subscription, you must select the same one that you created the Storage earlier:

![Select the same Storage you created earlier](/assets/img/posts/deploying-static-website-azure-storage-portal/choose-which-azure-storage.webp)*Select the same Storage you created earlier*


After selecting, the extension might warn you that the static website hosting is not enabled in the selected Storage and will ask you if you wish to enable. We do want that, so choose `Enable website hosting` option.

You will then be asked what will be the name of the html file that must be considered when your user hit the root URL of your website, leave it written `index.html` and hit enter. Next, you will be asked the name of the file to present when your user try to access a nonexistent document. In this project there is no page to present in this scenario so we can keep the suggested `index.html`, but if your project have one, fill the name correctly.

Press enter again and the deploy will begin. After it successfully ends, the following message will appear in your screen's inferior right side:

![Successfully deployed](/assets/img/posts/deploying-static-website-azure-storage-portal/deploy-complete.webp)*Successfully deployed*

Navigate to the link written in the message and see your website running!

![Website ready](/assets/img/posts/deploying-static-website-azure-storage-portal/website-ready.webp)*Website ready*


## Conclusion

In just a few minutes it's possible to deploy a static website to Azure using Visual Studio Code. Not only easy, but also cheap. Actually I believe that the price is what's more attractive in this hosting model.

At this moment I maintain 2 static websites in Azure with little access and I pay around $2,57/mo. But the better cost calculation is done considering bandwidth and storage size used. The best way to estimate is using Azure calculator: [https://azure.microsoft.com/en-us/pricing/calculator/?service=storage](https://azure.microsoft.com/en-us/pricing/calculator/?service=storage).

I hope this guide was useful to you, thanks and see you guys soon!
