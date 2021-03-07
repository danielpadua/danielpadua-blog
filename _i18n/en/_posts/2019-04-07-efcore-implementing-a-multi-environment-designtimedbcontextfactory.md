---
title: "EFCore: Implementing a multi-environment DesignTimeDbContextFactory"
description: "DesignTimeDbContextFactory, EFCore, Dotnet Core: Learn how to create a multi-environment DesignTimeDbContextFactory for your Dotnet Core with EF Core Migrations projects"
date: 2019-04-07 12:00:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Dotnet, Dotnet Core]
tags: [ef core, dotnet core, csharp, code first, microsoft]
image:
  src: /assets/img/posts/efcore-implementing-a-multi-environment-designtimedbcontextfactory/featured.png
  alt: Asp.net core entity framework logo with "generic multi-environment DesignTimeDbContextFactory" subtitling it
---

## Intro

For those who already worked with Entity Framework Core using Code-First approach, knows that Migrations was a really good way to “version” the database structure of your project or service. Using CLI commands like: `dotnet ef migrations add application_v1` or `dotnet ef database update` , we can reflect the changes created from the class models to database, and deploy automatically through development, tests and production environments. However, when executing these commands in different environments, Entity Framework does not know in which database to connect to perform the updates unless you tell it explicitly. To solve this, the `IDesignTimeDbContextFactory<YourDbContext>` was created, and through it, it’s possible to configure it to search for different connection strings of your environments.

In this guide I’ll show an effective implementation of a generic `DesignTimeDbContextFactory` that supports development and production environments, and reads connection strings using the files `appsettings.Development.json` and `appsettings.json`. To simplify, I’ll use EF Core with SQLite, the whole code is available [in this github repository](https://github.com/danielpadua/dotnet-efcore-designtime-example).

## Creating the project

Create a *WebApi* project named *DesignTimeExample* in the IDE/editor of your choice. I recommend you to use the following project structure:

![Project Structure Example](/assets/img/posts/efcore-implementing-a-multi-environment-designtimedbcontextfactory/project_structure_example.png)*Project Structure Example*

Add a directory at project's root named: *Data*. We'll store in this folder all classes responsible for data access such as *DbContext* and our implementation of `DesignTimeDbContextFactory`. Also create a directory inside *Data* named: *Migrations*. This one will hold all **snapshots** of our database state. It's important to notice that despite these files are auto-generated, they define the state of the application, so **it is** necessary to version them.

Also add a folder named: *Models*. It will keep all classes related to business model or [POCOs](https://en.wikipedia.org/wiki/Plain_old_CLR_object), in this example I'll use a really simple model of **Plane** and **Flight**.

## Creating the Models

The following classes will be used as models to interact with the database tables:

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

## Data Access

In this example we won't configure the names of the output tables for the sake of simplicity, so all tables will be named after the classes by default.

### DbContext

To interact with the database we'll have to create a `DbContext` for the application, so create a file named: `ApplicationDbContext.cs` inside *Data* directory such as:

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

Now we will configure a connection string in our development environment project configuration file. Edit `appsettings.Development.json` as it follows:

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

We'll pretend that this will be our development database, and the production will be in `appsettings.json`, like this:

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

Naturally in real scenario, the connection strings will point to different machines, so development and production are in separated infrastructures. But, in order to pretend this separation, the databases files generated for SQLite will be named: `application_dev.db` for development and `application_prod.db` for production.

### DesignTimeDbContextFactory

To correctly identify the different connection strings when running EFCore's CLI commands, we'll need to implement `IDesignTimeDbContextFactory` interface. To do so, create a file named: `DesignTimeDbContextFactory.cs` in `Data` directory as it follows:

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

Explaining a bit of the code, we receive as parameters in constructor: *connectionStringName* and *migrationAssemblyName*. We also read the `ASPNETCORE_ENVIRONMENT` system's environment variable, which is the standard .NET Core variable for us to check in which environment we are in. **We'll assume that if it contains with anything other than "Development", our implementation will assume the current environment is production**. The files `appsettings.Development.json` and `appsettings.json` are added so it can read the input parameters and generate the migrations.

With this done, we'll only need to create a concrete implementation of this Factory, using the `DbContext` above. To do so, add the following class in `ApplicationDbContext.cs`:

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

Basically we only extended our `DesignTimeDbContextFactory` and passed the connection string name that is in the configuration files.

### Creating and updating the migrations

With all this done, we can already test the migrations creation. Execute the following CLI command to create the initial version of our database structure:
```shell
dotnet ef migrations add application_v1 -o Data/Migrations
```
With the initial migration created, let's execute it in **development** environment. But before, check the content of the `ASPNETCORE_ENVIRONMENT` of your machine using:

**Linux/OSx**
```shell
echo $ASPNETCORE_ENVIRONMENT
```

**Windows**
```powershell
echo %ASPNETCORE_ENVIRONMENT%
```

To set the variable content, use:
**Linux/OSx**
```shell
export ASPNETCORE_ENVIRONMENT=Development
```

**Windows**
```shell
set ASPNETCORE_ENVIRONMENT=Development
```

Run the CLI Command with your environment set to **development:**
```shell
dotnet ef database update
```

Notice that the file `application_dev.db` was generated at the root directory of your project. After that, set your environment to **production** and run again the command:
```shell
dotnet ef database update
```

Now the file `application_prod.db` was generated:

![](/assets/img/posts/efcore-implementing-a-multi-environment-designtimedbcontextfactory/application_prod_generated.png)

## Conclusion

With this implementation it's easy to segregate environments in Design time (CLI commands executions), and it helps us to gain more control over the commands that are being executed by us or by a CI/CD software if you are running DevOps model.

See you soon!
