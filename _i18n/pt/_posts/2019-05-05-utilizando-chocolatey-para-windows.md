---
title: "Utilizando Chocolatey para Windows"
description: "Chocolatey, Windows: Aprenda para que serve, como instalar e utilizar o gerenciador de pacotes chocolatey para windows"
date: 2019-05-05 12:30:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Dicas]
tags: [chocolatey, windows, microsoft]
image:
  src: /assets/img/posts/using-chocolatey-for-windows/featured.png
  alt: Logotipo do windows com um sinal de soma, seguido pelo logotipo do chocolatey
---

## Introdução
Bom, vamos começar pela pergunta básica: "O que seria o Chocolatey?" Assim como a pergunta a resposta é bem direta: "É um gerenciador de pacotes desenvolvido para Windows".

Sim, agora (nem tão agora pois já vem rolando desde antes de 2014 minimamente) temos um gerenciador de pacotes para Windows nos moldes do [apt-get](https://pt.wikipedia.org/wiki/Advanced_Packaging_Tool) ou [yum](https://en.wikipedia.org/wiki/Yum_(software)) para Linux ou o [Homebrew](https://en.wikipedia.org/wiki/Homebrew_(package_management_software)) para Mac. E o assim como nos mencionados, podemos utilizá-lo em [ferramentas automação de infraestrutura (ou infraestrutura como código)](https://en.wikipedia.org/wiki/Infrastructure_as_code) como o [Puppet](https://puppet.com/), [Chef](https://www.chef.io/) e [Ansible](https://www.ansible.com/)

Neste guia irei mostrar o básico para começar a utilizar o Chocolatey, como instalação e principais comandos para manipulação de pacotes.

## Pré-Requisitos
* Windows 7 ou superior / Windows Server 2003 ou superior

* Powershell v2 ou superior

* .NET Framework 4 ou superior (a instalação do Chocolatey irá tentar instalar esta dependência caso você não possua)

## Instalação

Primeiramente é necessário executar o [Powershell](https://en.wikipedia.org/wiki/PowerShell) ou o [Cmd](https://en.wikipedia.org/wiki/Cmd.exe) em modo administrador, para isto pesquise por *Powershell* ou *Cmd* no *Menu Iniciar*, clique com o botão direito e selecione *Executar como administrador*.

Para Powershell utilize a linha de comando:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Para Cmd utilize a linha de comando:
```shell
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

## Utilização
E pronto, a instalação é apenas isto. Agora vamos aos comandos básicos para manipular os pacotes:

### Pesquisar pacotes
```powershell
choco search $nome_aproximado_do_pacote
```

ou visite [https://chocolatey.org](https://chocolatey.org/) e pesquise

### Listar pacotes instalados
```powershell
choco list --local-only
```

### Instalação de pacotes
```powershell
choco install $nome_do_pacote
```

*obs.: Utilize -y caso deseje ignorar as confirmações*

### Remoção de pacotes
```powershell
choco uninstall $nome_do_pacote
```
*obs.: Utilize -y caso deseje ignorar as confirmações*

### Atualização de pacotes
```powershell
choco upgrade $nome_do_pacote
```

para atualizar todos os pacotes use:
```powershell
choco upgrade all
```
*obs.: Utilize -y caso deseje ignorar as confirmações*

## Conclusão

O Chocolatey veio pra facilitar a vida dos usuários de Windows e principalmente dos administradores. E também tornou mais viável a utilização de ambientes windows para esteiras [devops](https://en.wikipedia.org/wiki/DevOps).

Até a próxima!
