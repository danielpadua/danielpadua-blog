---
title: "Git-bash com vscode"
description: "Git Bash, Visual Studio Code: Veja como configurar o git bash como terminal padrão no visual studio code"
date: 2019-03-27 12:00:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Dicas]
tags: [visual studio code, git, git bash, windows, microsoft]
image:
  src: /assets/img/posts/git-bash-with-vscode/featured.png
  alt: Logotipo do visual studio code com um sinal de soma, seguido pelo logo do git
---

## Introdução

O git-bash é uma aplicação para Windows que emula a experiência de utilizar o shell do Linux ou Osx, além de conter todos os comandos Git. Neste breve artigo mostrarei como modificar o terminal integrado do vscode, atribuindo o **git-bash**. No entanto o passo a passo a seguir também pode ser utilizado para definir o **powershell** como terminal padrão, uma vez que o vscode vem com o **cmd.exe** configurado por padrão.

## Guia

1. [Instale o Git/Git Bash em seu Windows](https://git-scm.com/downloads);

2. Abra o vscode e clique em: `File > Preferences > Settings`;

3. Na aba `User Settings`, selecione: `Features` e depois `Terminal`;

4. Procure a seção: `Integrated > Shell: Windows` e coloque o caminho para o executável do seu git bash, conforme imagem abaixo:

![Definindo caminho do executável do terminal integrado do vscode](/assets/img/posts/git-bash-with-vscode/vscode_config.png)*Definindo caminho do executável do terminal integrado do vscode*

Apenas explicando o que o vscode fez por trás dos panos, caso você abra o `settings.json` e o edite manualmente, você verá algo como abaixo:

![Configuração do terminal integrado](/assets/img/posts/git-bash-with-vscode/settings_json.png)*Configuração do terminal integrado*

A partir desse momento quando você abrir o terminal integrado do vscode, ele irá abrir um **git-bash** ao invés do cmd do windows.

Para adicionar o Powershell como terminal integrado, pasta apontar o caminho completo do Powershell em sua máquina nesta mesma variável do vscode!
