---
title: "Introduction to Azure Functions + Vscode"
description: "Azure Functions, Serverless: An introduction to the serverless world in microsoft azure platform by learning how to build and deliver an API build with javascript and nodejs"
date: 2020-02-24 12:00:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Serverless, Azure Functions]
tags: [serverless, azure functions, visual studio code, javascript]
image:
  src: /assets/img/posts/introduction-to-azure-functions-vscode/featured.png
  alt: Azure functions logo with a plus sign followed by visual studio code logo
---

## Intro
As a developer I was able to notice some significant transformation in the IT market, for instance:

* A big migration movement from structured to object oriented programming paradigm.
* More emphasis in web development instead of desktop.
* Creation and vertiginous rise of mobile apps development.
* More people switching from vertical scalability to horizontal with the appearance of cloud computing.
* Microservices architecture adoption instead of monolithic architecture.

And recently, actually in a while, I have noticed there is a huge adoption of [*serverless*](https://en.wikipedia.org/wiki/Serverless_computing) architecture to new and modern applications, in many cases even replacing microservices.

Serverless is capable of providing more easiness, flexibility, automatic scalability and even other benefits similar to microservices. However, the biggest differences between them in my opinion are the easiness and cost reduction.

With serverless you don't have to worry to configure and manage a server to your app, even less worrying about how to scale it. You just have to focus in your core problem solving with the code you write, this speeds up a lot releasing new features or products. And in most cloud providers, you just have to pay for what you use, so this provides a significant cost reduction compared to an instance that is always on, even if there is no load to process.

In this introductory article I will approach in how to begin serverless development in Microsoft Azure plataform, using vscode as code editor to develop and deploy a simple function that will return a "Hello World" after a HTTP action with GET or POST verb.

## Requirerements
* [Visual Studio Code](https://code.visualstudio.com/download)
* [Azure account](https://azure.microsoft.com/en-us/free/)

## Setup the development environment
To effectively work with functions it is minimally required to setup a local development environment which we can write, run and debug. Use the sections below according to you operating system.

### Windows

#### Install NodeJs

In this article, we will work with Azure Function version 3.x, **so we must install NodeJs versions 10.x.x or 12.x.x**. If there for any reason you want to use version 2.x then use NodeJs 8.x.x.
> There is an incompatibility in Windows with NodeJs version ≥ 13.x.x and Core Tools 3.x, so for now, use the versions listed above. ([https://github.com/Azure/azure-functions-core-tools/issues/1804](https://github.com/Azure/azure-functions-core-tools/issues/1804))

There are several ways of doing this:

* **[Direct installing from NodeJs website](https://nodejs.org/dist/)**

  Choose from the list one of the versions specified above and look for an installer with the suffix "**win-x64**", if this point in 2020 the architecture of the machine you are on is not 64 bits, then look for suffix "**win-x86**" for 32 bits architectures.

* **Installing NVM via package manager**

  [NVM](https://github.com/nvm-sh/nvm) is a command line program that has a feature of managing more easily multiple NodeJs versions at the same time. Using for example: [Chocolatey for Windows](/posts/using-chocolatey-for-windows) we can install nvm through command line: `choco install nvm`, and after install one of the versions above with: `nvm install $version` then you can link it in use with: `nvm use $version`.

#### Install Azure Core Tools
It is this guy that allow us to create a local execution environment for your function so you can run them via command line. It is even capable of communicating with real Azure resources, which it is not recommended, because completely separate the environments are more correct, but it works.

The installation in Windows is through NodeJs, running the following command line in PowerShell or cmd:
```powershell
npm install -g azure-functions-core-tools@3
```

If you want to install version 2.x, you would have to run this instead:
```powershell
npm install -g azure-functions-core-tools
```

After installing, try the installation only by running:
```powershell
func --version
```

If it displayed an error similar to this:

![NodeJs Scripts execution permission error](/assets/img/posts/introduction-to-azure-functions-vscode/nodejs_scripts_permission_error.png)*NodeJs Scripts execution permission error*

Run the following command line in PowerShell as administrator, so the scripts that are installed via NodeJs can be executed:
```powershell
Set-ExecutionPolicy RemoteSigned
```

If there is an error similar to: "**Unhandled 'error' event**", it is likely that there is an incompatibility between Core Tools and NodeJs. Redo the step above.

### MacOs

#### Install NodeJs
In this article, we will work with Azure Function version 3.x, **so we must install NodeJs versions 10.x.x or 12.x.x**. If there for any reason you want to use version 2.x then use NodeJs 8.x.x.

There are several ways of doing this:

* **[Direct installing from NodeJs website](https://nodejs.org/dist/)**

  Choose from the list one of the versions specified above and look for an installer with the extension name “**.pkg**” and do **NNF** installation (next, next and finish).

* **Installing NVM via package manager**

  [NVM](https://github.com/nvm-sh/nvm) is a command line program that has a feature of managing more easily multiple NodeJs versions at the same time. Using for example: [Homebrew for MacOs](/posts/using-homebrew-for-macos) we can install nvm through command line: `brew install nvm`, and after install one of the versions above with: `nvm install ${version}` then you can link it in use with: `nvm use ${version}`.

#### Install Azure Core Tools
It is this guy that allow us to create a local execution environment for your function so you can run them via command line. It is even capable of communicating with real Azure resources, which it is not recommended, because completely separate the environments are more correct, but it works.

Install version 3.x using Homebrew with the command lines:
```shell
brew tap azure/functions
brew install azure-functions-core-tools@3
# run the line below if you are upgrading version 2.x to 3.x in your machine
brew link --overwrite azure-functions-core-tools@3
```

For version 2.x use the command lines:
```shell
brew tap azure/functions
brew install azure-functions-core-tools
```

Finally, test it with the command line:
```shell
func --version
```

### Linux

#### Install NodeJs
In this article, we will work with Azure Function version 3.x, **so we must install NodeJs versions 10.x.x or 12.x.x**. If there for any reason you want to use version 2.x then use NodeJs 8.x.x.

There are several ways of doing this:

* **[Direct installing from NodeJs website](https://nodejs.org/dist/)**

  Choose from the list one of the versions specified above and look for an installer with the suffix “**.linux-x64.tar.gz**”, download it, extract in an easy access directory and create a symbolic link to file: "**/bin/node"**.

* **Installing NVM via package manager**

  [NVM](https://github.com/nvm-sh/nvm) is a command line program that has a feature of managing more easily multiple NodeJs versions at the same time. Use your distro package manager to install NVM and then install one of the versions above with: `nvm install ${version}`, and link it in use with: `nvm use ${version}`.

#### Install Azure Core Tools
This is the guy that allow us to create a local execution environment for your function so you can run them via command line. It is even capable of communicating with real Azure resources, which it is not recommended, because completely separate the environments are more correct, but it works.

If your distro is Debian based, you can use this [Microsoft guide](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=linux#v2) to install Core Tools. If is another distro, check [Core Tools README](https://github.com/Azure/azure-functions-core-tools/blob/master/README.md#linux) to install.

Finally, test Core Tools with the command line:
```shell
func --version
```

### Install Azure Functions plugin in vscode
Open **Extensions** and look for: **Azure Functions** or [use this link](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions).

![Installing Azure Functions plugin in vscode](/assets/img/posts/introduction-to-azure-functions-vscode/installing_functions_plugin_vscode.png)*Installing Azure Functions plugin in vscode*

After the installation, restart vscode and confirm that a Azure Account plugin was installed alongside Azure Functions plugin. Sign in to your Azure Account as the image below:

![Signing in Azure Account](/assets/img/posts/introduction-to-azure-functions-vscode/signin_azure_account.png)*Signing in Azure Account*

You should be redirected to Microsoft login page in your default browser. After that, return to vscode and your Azure resources will be displayed in the editor.

## Creating and debugging locally a function
Now, the development environment is ready, lets create our simple Hello World function. To do this, in vscode initial screen, use the keys combination: Ctrl+Shift+P (Windows or Linux) or Cmd+Shift+P (MacOs). The command palette should open. Start typing: **functions create new project**:

![Creating a functions project](/assets/img/posts/introduction-to-azure-functions-vscode/create_function_project.png)*Creating a functions project*

One function project is capable of nesting N different types functions triggered by: Http, time, queue and others.

If you are not with an open directory in vscode, you will be asked to open one. Create a directory where we will keep our project source and select it. After, you will be asked in what language you would like to develop, for this example we will stick with **Javascript**:

![Choose a development language to your function](/assets/img/posts/introduction-to-azure-functions-vscode/choose_language.png)*Choose a development language to your function*

Your next question is: Would I be using a function template according to the trigger type that will fire it? Again, to our example, we will stick to a Http trigger:

![Http Trigger function template](/assets/img/posts/introduction-to-azure-functions-vscode/http_trigger_template.png)*Http Trigger function template*

The next step consists only about giving a name to our function, I tend to use the nomenclature: **name_TriggerType**, for me to know the trigger type immediately. But you can use whatever pattern you are more comfortable with.

Now, select the authorization level of the function. There are 3 authorization types:

* **Function**: There is an access key created by default in Azure Portal when you deploy a function, that can be used to authenticate calls to your endpoints. You can pass it though Query String or Header parameter of your Http request. If this parameter is not filled or it is incorrect, the function will automatically return Http status 401 — Unauthorized.

* **Anonymous**: As the name itself, no authorization, your endpoints are exposed and can be called without any kind of authentication/authorization.

* **Admin**: As there is key with function level, there is a key called **host key**, also created by Azure. Only with this key your access to the endpoint will work, if the parameter it is not informed or incorrect this method will also return Http status 401 — Unauthorized.

Lastly, select the project in the same window, if you are not already with a directory opened.

Your project after the creation must look like this:

![Directory structure of a javascript function project](/assets/img/posts/introduction-to-azure-functions-vscode/javascript_function_structure.png)*Directory structure of a javascript function project*

For javascript the functions are always separated in directories with 3 files:

* **functions.json**

![function.json](/assets/img/posts/introduction-to-azure-functions-vscode/function_json.png)*function.json*

This file is responsible of telling Azure which bindings we will use. Bindings are a way of connecting with an Azure resource, like a queue, topic, database, http action and others with a function, and this binding may have a direction (input or output).

For example, the first object consist in a specific configuration for a http triggered function where the direction is **in**, which means, it is coming to your function via verbs: **get** or **post** through a parameter named `req`. And the second object is the return "**out**" of the http type, that can be accessed through parameter `res`.

* **index.js**

![index.js](/assets/img/posts/introduction-to-azure-functions-vscode/index_js.png)*index.js*

It is this file that will contain the logic of your function, where you will be able to develop freely. According to the configuration in **function.json**, the binding parameters named: `req` and `res`, are defined in the template. Notice in how they are used to get the parameters (`req`) sent to the endpoint and send the response to the caller (`res`).

* **sample.dat**

![sample.dat](/assets/img/posts/introduction-to-azure-functions-vscode/sample_dat.png)*sample.dat*

This file is only used to populate a test call to the API when you are using Azure Portal interface:

![This is where sample.dat is used](/assets/img/posts/introduction-to-azure-functions-vscode/sample_dat_in_azure_portal.png)*This is where sample.dat is used*

Last but not least, the file **local.setting.json** is where we call configure local "environment variables". The keys in this file are usually meant to keep non sensible configurations, **so is not a good idea to keep the password of your database user here**. A better idea would be [point a reference to extract the secret from **Azure Key Vault**, for example](https://medium.com/statuscode/getting-key-vault-secrets-in-azure-functions-37620fd20a0b).

Finally, put a breakpoint in line 4 (first if) and run the project:

![The beginning of our serverless saga](/assets/img/posts/introduction-to-azure-functions-vscode/run_debug_function.png)*The beginning of our serverless saga*

Wait until the messages below are displayed in your integrated terminal:

![Function up, running and debuggable!](/assets/img/posts/introduction-to-azure-functions-vscode/function_running.png)*Function up, running and debuggable!*
> If you ran into any problem, again, review the steps above. There is a high probability that there is a version incompatibility between Core Tools and NodeJs!

The function gets up a little before the debugger can attach to the process, so, if you call the endpoint faster than this attachment, the breakpoint won't hit.

Try to call in your browser the endpoint highlighted in the image above. Firstly, your breakpoint will be triggered, changing the focus to vscode:

![Debugging a Azure Function locally](/assets/img/posts/introduction-to-azure-functions-vscode/debugging_function.png)*Debugging a Azure Function locally*

Select the "resume" button to release the debugger, go back to the browser and the result should be this:

![Hello need a parameter](/assets/img/posts/introduction-to-azure-functions-vscode/need_parameter.png)*Hello need a parameter*

The Hello World template function expects a parameter named: `name` via query string or request body, with your name so it can give you a Hello. Take some time to understand how the code works and the passing of parameters through object `req`. After, make a call using query string, as the following image:

![Fully functional Hello World!](/assets/img/posts/introduction-to-azure-functions-vscode/functional_hello_world.png)*Fully functional Hello World!*

Our tests until here were only via verb: **get**. Lets do one using verb: **post**. To do so, you will need any tool of your preference, from [curl](https://curl.haxx.se/) to [Postman](https://www.postman.com/). For this example, we will use Postman:

![POST call with JSON parameter example](/assets/img/posts/introduction-to-azure-functions-vscode/call_function_from_postman.png)*POST call with JSON parameter example*

## Deploying to Azure Account
Now that we have setup the development environment, created the function and locally tested it, let's upload it to Azure to call it through Internet. The are several ways to do this, for example: create a function via Portal and upload it manually, create a automated CI/CD process (highly recommended) or deploy via vscode (actually the plugin uses Azure CLI behind the scenes), the latter is what I will approach in this article for simplicity sake.

Stop the function debug if you haven't did it already, open the command palette (Ctrl+Shift+P in Windows/Linux or Cmd+Shift+P in MacOs) and start typing: **azure functions deploy** and select "Azure Functions: Deploy to Function app…":

![Starting the deploy](/assets/img/posts/introduction-to-azure-functions-vscode/start_deploy.png)*Starting the deploy*

Select your subscription, if you already have any functions created, it will be displayed. Select "Create new Function App in Azure… Advanced":

![Create a function in Azure](/assets/img/posts/introduction-to-azure-functions-vscode/create_function_in_azure.png)*Create a function in Azure*

Choose a name for your function. This name must be globally unique, so in all Azure, a duplicated named function cannot exist. After that, select the target operating system to deploy, in this example I will be using **Linux**.

You will be asked about the "hosting plan" — this is how you will pay for this resource (function). There are three plans:

![Hosting plans](/assets/img/posts/introduction-to-azure-functions-vscode/hosting_plans.png)*Hosting plans*

* **Consumption**

  In this plan, instances of your function are dynamically allocated or deallocated according with the incoming load, ensuring your function will scale without you have to worry about it. Also, you are charged only during your function execution, this means, you do not have to pay anything if your function is completely idle.

  Currently, there is a monthly free grant of 1 million free requests, which makes serverless very cost effective and financially attractive. [You can find more pricing information here](https://azure.microsoft.com/en-us/pricing/details/functions/).

  However there is cost of this automatic scalability, a problem called: [cold start](https://azure.microsoft.com/en-us/blog/understanding-serverless-cold-start/). If your function become idle for a while, Azure might put it into a cold state which will take a little longer to warm if your function is triggered. Subsequent requests are faster.

  There is also a function total duration timeout (configurable), so functions are not meant for heavy processing.

* **Premium**

  Very similar to Consumption, however, it has some advantages like: there is no cold start — instances are always warm, VNet connectivity, unlimited duration timeout, and others. The billing is also different, so it can be substantially higher than Consumption due to extra benefits.

* **App Service Plan**

  With this plan your functions can run in the same traditional App Services VMs. This scenario might useful when you have an underused instance, so your cost benefit will raise. As your instance is always on, the function will always be warm too, and you will be charged the same way of your App Service, no other costs.

  We will choose Consumption in this example: choose it, and after choose the runtime of the function: **Node.js 12.x** (If you chose Core Tools v3):

![Runtime choices](/assets/img/posts/introduction-to-azure-functions-vscode/runtime_choices.png)*Runtime choices*

Select or create a resource group to nest your function and then also a Storage Account. This last one is necessary to store your function bundled code and the runtime parameters and your functions parameters too.

In step 9/10 you will be able to choose an Application Insight. This is a very interesting Azure resource which is used to extract logs and other important information about your functions health. As we are just doing a "Hello World", we can proceed without it by choosing: "Skip for now".

Lastly, select a supported region you want Azure to deploy your function, select your favorite, and your function will be created and our "Hello World" code will be packed and delivered. After that, click on the "Output" tab and at the bottom you can copy your function's link which is running now under Azure infrastructure, as below:

![Function deployed with success!](/assets/img/posts/introduction-to-azure-functions-vscode/function_deployed.png)*Function deployed with success!*

Quickly test it in your browser and you will see the same as in our local tests:

!["Production" running function](/assets/img/posts/introduction-to-azure-functions-vscode/production_running_function.png)*"Production" running function*

## Conclusion
I believe that serverless came to stay and will be more adopted with time, specially for the development speed and cost reduction benefits. Nonetheless, breaking our code in perhaps even more "micro" than microservices can make automatic integrated tests harder when you have so many pieces and their communication are variated.

I hope this helped at least a little about the understanding of serverless and Azure Functions. See you soon!

## References
- [**https://docs.microsoft.com/en-us/azure/azure-functions/functions-develop-vs-code?tabs=csharp**](https://docs.microsoft.com/en-us/azure/azure-functions/functions-develop-vs-code?tabs=csharp)
