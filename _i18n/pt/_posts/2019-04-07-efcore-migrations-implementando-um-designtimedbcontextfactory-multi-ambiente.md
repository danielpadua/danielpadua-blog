---
title: "EFCore Migrations: Implementando um DesignTimeDbContextFactory multi-ambiente"
description: "DesignTimeDbContextFactory, EFCore, Dotnet Core: Aprenda a criar um DesignTimeDbContextFactory multi-ambiente em seus projetos Dotnet Core com EF Core Migrations"
date: 2019-04-07 12:00:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Dotnet, Dotnet Core]
tags: [ef core, dotnet core, csharp, code first, microsoft]
image:
  src: /assets/img/posts/efcore-implementing-a-multi-environment-designtimedbcontextfactory/featured.png
  alt: Logotipo do asp.net core entity framework com o texto "Generic multi-environment DesignTimeDbContextFactory" como legenda
---

## Introdução

Para quem já trabalhou com o Entity Framework Core utilizando o modelo Code-First, o Migrations foi uma sacada bem legal para “versionar” através da aplicação, os estados da estrutura de seu banco de dados. Utilizando os comando CLI, por exemplo: `dotnet ef migrations add application_v1` ou `dotnet ef database update`, podemos refletir as mudanças criadas a partir do modelo de classes no banco de dados e subir automaticamente entre os ambientes de desenvolvimento, testes e produção. No entanto, ao executar estes comandos nos diferentes ambientes, o Entity Framework não saberá em qual banco de dados se conectar para fazer as atualizações a menos que você diga explicitamente a ele. Para isto foi criada a interface `IDesignTimeDbContextFactory<SeuDbContext>`, e através dela é possível configurar para olhar diferentes connection strings de seus ambientes.

Neste artigo irei mostrar uma implementação efetiva de um `DesignTimeDbContextFactory` genérico que suporta ambientes de: desenvolvimento e produção e que lê connection strings utilizando os arquivos `appsettings.Development.json` e `appsettings.json`. Para simplificar, utilizarei o EF Core com o SQLite, e todo código estará disponível [neste repositório](https://github.com/danielpadua/dotnet-efcore-designtime-example).

## Criação do projeto

Crie um projeto do tipo *WebApi* com o nome *DesignTimeExample* na IDE/editor de preferência. Dê preferência a seguinte estrutura de projeto:

![Exemplo de estrutura de projeto](/assets/img/posts/efcore-implementing-a-multi-environment-designtimedbcontextfactory/project_structure_example.png)*Exemplo de estrutura de projeto*

Inclua um diretório na raíz do projeto com o nome: *Data*. Nele iremos guardar todos as classes relativas ao acesso de dados, como por exemplo o *DbContext* e nossa implementação do *DesignTimeDbContextFactory*. Crie também dentro da pasta *Data*, a pasta: *Migrations*. Ela servirá para guardar os **snapshots** (ou fotos) do estado do nosso banco de dados. Importante observar que é apesar de serem arquivos auto-gerados, eles definem o estado da aplicação, então é necessário **sim** versioná-los.

Inclua também um diretório chamado: *Models*. Nele iremos guardar todas as classes relativas ao modelo do negócio ou [POCOs](https://en.wikipedia.org/wiki/Plain_old_CLR_object), irei usar um modelo bem simples de **Avião** e **Voo**, representados por: `Plane` e `Flight`.

## Criação dos Models

As classes a seguir servem como modelos para interagir com as tabelas no banco de dados:

```c#
using System.Collections.Generic;

namespace DesignTimeExample.Models
{
    public class Plane
    {
        public int Id { get; set; }
        public int SeatsNumber { get; set; }
        public PlaneModel Model { get; set; }
        public ICollection<Flight> Flights { get; set; }
    }

    public enum PlaneModel
    {
        AIRBUS_A380,
        BOEING_707,
        AIRBUS_A320,
        BOEING_727,
        BOEING_767,
        BOEING_757,
        BOEING_787,
        BOEING_737,
        BOEING_777,
        BOEING_747
    }
}
```

```c#
using System.ComponentModel.DataAnnotations;

namespace DesignTimeExample.Models
{
    public class Flight
    {
        public int Id { get; set; }
        public string Code { get; set; }
        [Required]
        public Plane Plane { get; set; }
        public int PassengerNumber { get; set; }
    }
}
```

## Acesso aos dados

Neste exemplo não iremos configurar um mapeamento das classes de modelo para um padrão de nomenclatura de banco de dados, portanto, as tabelas serão geradas exatamente como as classes.

### DbContext

Para interagir com o banco de dados, precisamos criar um `DbContext` da aplicação, então crie o arquivo `ApplicationDbContext.cs` no diretório *Data* conforme a seguir:

```c#
using System.Reflection;
using DesignTimeExample.Models;
using Microsoft.EntityFrameworkCore;

namespace DesignTimeExample.Data
{
    public class ApplicationDbContext : DbContext
    {
        public DbSet<Plane> Planes { get; set; }
        public DbSet<Flight> Flights { get; set; }

        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }
    }
}
```

### Connection String

Agora vamos configurar a connection string em nosso arquivo de configuração para o ambiente de desenvolvimento. Edite o `appsettings.Development.json` conforme a seguir:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Data Source=application_dev.db"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Debug",
      "System": "Information",
      "Microsoft": "Information"
    }
  }
}
```

Iremos simular que este será nosso banco de dados de desenvolvimento. O de produção será o `appsettings.json`, conforme a seguir:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Data Source=application_prod.db"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*"
}
```

Naturalmente num cenário real, as connection strings apontarão para diferentes máquinas, pois desenvolvimento e produção estarão em infraestruturas segregadas. Mas para apenas simular esta separação, os nomes dos arquivos gerados do banco de dados SQLite serão `application_dev.db` para desenvolvimento e `application_prod.db` para produção.

### DesignTimeDbContextFactory

Para identificar as diferentes connection strings ao rodar os comandos CLI do EF Core, necessitamos implementar a interface `IDesignTimeDbContextFactory`. Para isto crie um arquivo chamado `DesignTimeDbContextFactory.cs` no diretório `Data`, conforme a seguir:

```c#
using System;
using System.IO;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;

namespace DesignTimeExample.Data
{
    public abstract class DesignTimeDbContextFactoryBase<TContext> :
        IDesignTimeDbContextFactory<TContext> where TContext : DbContext
    {
        protected string ConnectionStringName { get; }
        protected string MigrationsAssemblyName { get; }

        public DesignTimeDbContextFactoryBase(string connectionStringName, string migrationsAssemblyName)
        {
            ConnectionStringName = connectionStringName;
            MigrationsAssemblyName = migrationsAssemblyName;
        }

        public TContext CreateDbContext(string[] args)
        {
            return Create(
                Directory.GetCurrentDirectory(),
                Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT"),
                ConnectionStringName, MigrationsAssemblyName);
        }
        protected abstract TContext CreateNewInstance(
            DbContextOptions<TContext> options);

        public TContext CreateWithConnectionStringName(string connectionStringName, string migrationsAssemblyName)
        {
            var environmentName =
                Environment.GetEnvironmentVariable(
                    "ASPNETCORE_ENVIRONMENT");

            var basePath = AppContext.BaseDirectory;

            return Create(basePath, environmentName, connectionStringName, migrationsAssemblyName);
        }

        private TContext Create(string basePath, string environmentName, string connectionStringName, string migrationsAssemblyName)
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(basePath)
                .AddJsonFile("appsettings.json")
                .AddJsonFile($"appsettings.{environmentName}.json", true)
                .AddEnvironmentVariables();

            var config = builder.Build();

            var connstr = config.GetConnectionString(connectionStringName);
            Console.WriteLine($"Environment: {environmentName ?? "PRODUCTION"}");

            if (string.IsNullOrWhiteSpace(connstr))
            {
                throw new InvalidOperationException(
                    $"Could not find a connection string named '{connectionStringName}'.");
            }
            else
            {
                return CreateWithConnectionString(connectionStringName, connstr, migrationsAssemblyName);
            }
        }

        private TContext CreateWithConnectionString(string connectionStringName, string connectionString, string migrationsAssembly)
        {
            if (string.IsNullOrEmpty(connectionString))
                throw new ArgumentException(
             $"{nameof(connectionString)} is null or empty.",
             nameof(connectionString));

            var optionsBuilder =
                 new DbContextOptionsBuilder<TContext>();

            Console.WriteLine(
                "DesignTimeDbContextFactory.Create(string): Connection string: {0}",
                connectionStringName);

            optionsBuilder.UseSqlite(connectionString, db => db.MigrationsAssembly(migrationsAssembly));

            DbContextOptions<TContext> options = optionsBuilder.Options;

            return CreateNewInstance(options);
        }
    }
}
```

Resumindo o código desta classe, recebemos como parâmetro no construtor: *connectionStringName* e a *migrationAssemblyName*. Também lemos a variável de ambiente `ASPNETCORE_ENVIRONMENT` que é a variável padrão que é utilizada para verificar em que ambiente estamos no .NET Core. **Caso ela esteja preenchida com algo diferente de “Development” ele irá assumir que o ambiente é produtivo**. Os arquivos `appsettings.Development.json` e `appsettings.json` são adicionados para que consiga ler os parâmetros de entrada e gerar as migrations.

Com isto implementado, apenas precisamos criar uma implementação concreta desta Factory, utilizando o `DbContext` acima. Para isto, inclua a classe abaixo no `ApplicationDbContext.cs`:

```c#
using System.Reflection;
using DesignTimeExample.Models;
using Microsoft.EntityFrameworkCore;

namespace DesignTimeExample.Data
{
    public class ApplicationContextDesignFactory : DesignTimeDbContextFactoryBase<ApplicationDbContext>
    {
        public ApplicationContextDesignFactory() : base("DefaultConnection", typeof(Startup).GetTypeInfo().Assembly.GetName().Name)
        { }
        protected override ApplicationDbContext CreateNewInstance(DbContextOptions<ApplicationDbContext> options)
        {
            return new ApplicationDbContext(options);
        }
    }
}
```

Basicamente apenas estendemos a `DesignTimeDbContextFactory` e passamos o nome da connection string que está nos arquivos de configuração.

### Criação e atualização das migrations

Com tudo isto feito, já podemos testar a criação das migrations. Execute o comando a seguir para criar a versão inicial da estrutura do banco de dados:
```shell
dotnet ef migrations add application_v1 -o Data/Migrations
```

Com a migration inicial criada, vamos executa-la em ambiente de **desenvolvimento**. Verifique o conteúdo de sua variável de ambiente `ASPNETCORE_ENVIRONMENT`.

Para ler a variável, no terminal use:

**Linux/OSX**
```shell
echo $ASPNETCORE_ENVIRONMENT
```

**Windows**
```powershell
echo %ASPNETCORE_ENVIRONMENT%
```

Para atribuir a variável, no terminal use:
**Linux/OSX**
```shell
export ASPNETCORE_ENVIRONMENT=Development
```

**Windows**
```powershell
set ASPNETCORE_ENVIRONMENT=Development
```

Rode o comando a seguir com o ambiente configurado para **developemnt:**
```shell
dotnet ef database update
```

Perceba que foi gerado no diretório raíz de seu projeto, o arquivo `application_dev.db`. Agora configure a variável de ambiente para **production** e rode o comando novamente:
```shell
dotnet ef database update
```

Agora o arquivo `application_prod.db` foi gerado.

![](/assets/img/posts/efcore-implementing-a-multi-environment-designtimedbcontextfactory/application_prod_generated.png)

## Conclusão

Com esta implementação é possível segregar os ambientes no momento de Design (execução dos comandos CLI), e nos ajuda a ter mais controle nos comandos que executamos, ou que mandamos para uma esteira executar no caso de estar rodando no modelo DevOps.

Até a próxima!
