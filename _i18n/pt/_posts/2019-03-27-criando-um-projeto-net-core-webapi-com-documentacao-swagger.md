---
title: "Criando um projeto .NET Core WebApi com documentação Swagger"
description: "Swagger, Dotnet Core: Aprenda a criar um projeto com documentação swagger integrada ao código com dotnet core webapi"
date: 2019-03-27 12:00:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Dotnet, Dotnet Core]
tags: [dotnet core, swagger, swagger ui, swashbuckle, csharp, microsoft]
image:
  src: /assets/img/posts/creating-a-net-core-webapi-with-swagger-documentation/featured.png
  alt: Logotipo do .net core com um sinal de soma, seguido pelo logotipo do swagger
---

## Introdução

Quando criamos um projeto do tipo WebApi no .NET Core ou em qualquer outra linguagem, pretendemos que outras aplicações, serviços ou até mesmo bots, utilizem os endpoints criados e consumam a resposta destes processamentos via HTTP ou qualquer outro protocolo.

É de extrema importância que sua API seja bem documentada, pois quem irá consumi-la necessitará saber o funcionamento e parâmetros de entrada/saída de cada um de seus endpoints, principalmente caso sua API seja consumida pela Web.
Hoje, há algumas maneiras de se automatizar e agilizar esta documentação, e irei abordar uma delas, que é o **Swagger**.

O Swagger é um framework open-source que possui várias ferramentas que ajudam os desenvolvedores a modelar, construir e **documentar** REST APIs.

Neste artigo irei mostrar um exemplo de documentação através o pacote [Nuget: Swashbuckle](https://www.nuget.org/packages/Swashbuckle/)

## Exemplo .NET Core + Swashbuckle

Neste artigo irei utilizar apenas o vscode e o terminal integrado. Caso não saiba como configurar um ambiente de desenvolvimento para .NET Core, você pode conferir em [meu outro post](/pt/posts/vscode-asp-net-core-preparar-ambiente-de-desenvolvimento).

Caso você esteja utilizando Windows, sugiro fortemente que configure o terminal integrado do vscode para apontar para o git-bash, utilizando [este outro artigo](/pt/posts/git-bash-com-vscode).

### Estrutura do projeto

Irei utilizar uma estrutura de projeto que costumo utilizar em meus projetos, que é:

![](/assets/img/posts/creating-a-net-core-webapi-with-swagger-documentation/project_tree.png)

A primeira coisa a se fazer é criar um diretório para seu projeto WebApi, para isso, sugiro que crie um diretório “projetos” dentro da pasta home de seu usuário. Abra seu vscode, abra o terminal integrado (`ctrl+’`) e digite o seguinte comando:
```shell
mkdir ~/projects
```

Após, entre no diretório projetos crie um diretório para o próprio projeto WebApi:
```shell
cd ~/projects
mkdir dotnet-web-api-swagger-example
```

Obs.: Para criar tudo de uma vez utilize:
```shell
mkdir -p ~/projects/dotnet-webapi-swagger-example
```

Agora vamos criar a solution, execute as linhas abaixo:
```shell
cd ~/projects dotnet-webapi-swagger-example
dotnet new sln --name WebApiSwagger
```

Depois devemos criar o projeto em si e o projeto de testes unitários:
```shell
dotnet new webapi -o src/WebApiSwagger
dotnet new xunit -o tests/WebApiSwagger.Tests
```

E na sequência, é necessário incluir estes dois novos projetos à Solution:
```shell
dotnet sln add src/WebApiSwagger/WebApiSwagger.csproj
dotnet sln add tests/WebApiSwagger.Tests/WebApiSwagger.Tests.csproj
```

Agora é só abrir o diretório "dotnet-webapi-swagger-example" no vscode:

![Clique no botão para abrir uma pasta](/assets/img/posts/creating-a-net-core-webapi-with-swagger-documentation/open_folder_vscode.png)*Clique no botão para abrir uma pasta*

![Projeto carregado no vscode](/assets/img/posts/creating-a-net-core-webapi-with-swagger-documentation/project_loaded_vscode.png)*Projeto carregado no vscode*

### Adicionar e configurar o middleware do Swashbuckle

Com isto, a estrutura do projeto já está montada. Agora vamos baixar do *nuget* o pacote *Swashbuckle*. Mas antes, não se esqueça de mudar para o diretório do projeto principal:
```shell
cd src/WebApiSwagger/
dotnet add package Swashbuckle.AspNetCore
```

Swashbuckle adicionado. Devemos configurar o Swashbuckle no método ConfigureServices, para que o .NET Core reconheça que iremos utilizá-lo. Para isto, adicione o trecho de código a seguir no método *ConfigureServices* da classe *Startup.cs*:

```c#
// This method gets called by the runtime. Use this method to add services to the container.
public void ConfigureServices(IServiceCollection services)
{
    // Swagger Config
    services.AddSwaggerGen(c =>
    {
        c.SwaggerDoc("v1", new Info
        {
            Version = "v1",
            Title = "WebApi Swagger Example API",
            Description = "Values API Swagger Example",
            TermsOfService = "None",
            Contact = new Contact
            {
                Name = "Daniel Padua",
                Email = "daniel.padua@outlook.com",
                Url = "https://www.linkedin.com/in/danielpadua"
            }
        });
        // Set the comments path for the Swagger JSON and UI.
        var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
        var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
        c.IncludeXmlComments(xmlPath);
    });

    services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2);
}
```

obs.: Caso não consiga importar o namespace do Swashbuckle através do (ctrl+.), pressione (ctrl+shift+p) e escreva: "Reload Window" e aperte o enter. Isto irá forçar um reinício do vscode e ele voltará com o intellisense atualizado.

E também registrar na pipeline:

```c#
// This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
public void Configure(IApplicationBuilder app, IHostingEnvironment env)
{
    if (env.IsDevelopment())
    {
        app.UseDeveloperExceptionPage();
    }
    else
    {
        // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
        app.UseHsts();
    }

    // Add Swagger/SwaggerUI to pipeline
    app.UseSwagger(c =>
    {
        c.PreSerializeFilters.Add((document, request) =>
        {
            document.Paths = document.Paths.ToDictionary(p => p.Key.ToLowerInvariant(), p => p.Value);
        });
    }).UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "WebApi Swagger API v1");
        c.RoutePrefix = string.Empty;
    });

    app.UseHttpsRedirection();
    app.UseMvc();
}
```

Estamos apenas configurando o que irá ser exibido no swagger.json/SwaggerUI, informações de contato, termos de utilização, versão e etc. O mais importante a notar é que estamos buscando um arquivo XML que tem o mesmo nome da DLL gerada no processo de compilação, e adicionando à configuração do Swagger. Este arquivo não é nada mais do que o arquivo de documentação XML do [projeto dotnet](https://docs.microsoft.com/pt-br/dotnet/csharp/codedoc).

Para que este arquivo seja gerado ao compilar, devemos editar manualmente o arquivo *WebApiSwagger.csproj* e incluir as linhas abaixo na seção *PropertyGroup*:
```xml
<GenerateDocumentationFile>true</GenerateDocumentationFile>
<NoWarn>$(NoWarn);1591</NoWarn>
```

A primeira linha habilita em si a geração do XML, já a segunda diz ao compilador não exibir warning caso exista algum método que não esteja devidamente documentado.

Importante ressaltar também que na linha `c.RoutePrefix = string.Empty` estamos dizendo para o Swashbuckle que o SwaggerUI (Interface gráfica para documentação) será executada na URL raíz da sua API. Caso deseje jogar para outra rota, basta substituir o `string.Empty` pela rota desejada (ex.: “*swagger*”).

Escreva também para fins de teste, uma documentação sobre o endpoint Get do `ValuesController`:

```c#
// GET api/values
/// <summary>
/// Documentação sobre o método GET
/// </summary>
/// <returns>String array</returns>
[HttpGet]
[ProducesResponseType(typeof(string[]), StatusCodes.Status200OK)]
public ActionResult<IEnumerable<string>> Get()
{
    return new string[] { "value1", "value2" };
}
```

A annotation (`ProducesResponseType`) define a documentação dos possíveis `HttpStatusCodes` de saída do seu endpoint

### Executando o projeto

Execute o projeto através de um "dotnet run" estando no mesmo diretório do "WebApiSwagger.csproj" ou execute através do [debug do OmniSharp](https://github.com/OmniSharp/omnisharp-vscode/wiki/How-to-run-and-debug-unit-tests).

Abra seu navegador e acesse "[http://localhost:5000](http://localhost:5000)"

![Atente na documentação do GET](/assets/img/posts/creating-a-net-core-webapi-with-swagger-documentation/swagger_ui_running.png)*Atente na documentação do GET*

![Possíveis StatusCodes de resposta do endpoint](/assets/img/posts/creating-a-net-core-webapi-with-swagger-documentation/swagger_ui_http_responses.png)*Possíveis StatusCodes de resposta do endpoint*

## Conclusão

O pacote nuget Swashbuckle facilita muito a documentação Swagger de um projeto WebApi, trazendo velocidade para documentação e também talvez para teste local através do SwaggerUI. Agora não tem desculpa pra não fazer documentação :)

Até a próxima!

O código na integra deste guia está [neste repositório do github](https://github.com/danielpadua/dotnet-webapi-swagger-example).
