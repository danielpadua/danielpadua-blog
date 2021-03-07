---
title: "Utilizando o Homebrew no macOS"
description: "Homebrew, macOS: Aprenda para que serve, como instalar e utilizar o gerenciador de pacotes homebrew para macOS"
date: 2019-05-05 12:40:00 -0300
categories: [Dicas]
tags: [homebrew, macos, apple]
image:
  src: /assets/img/posts/using-homebrew-for-macos/featured.png
  alt: Logotipo do macos com um sinal de soma, seguido pelo logotipo do homebrew
---

## Introdução

O [macOS](https://pt.wikipedia.org/wiki/MacOS) é um sistema operacional baseado no kernel do Unix, e apesar de a Apple prover a AppStore como uma espécie de [gerenciador de pacotes](https://pt.wikipedia.org/wiki/Sistema_gestor_de_pacotes), faltam muitas coisas importantes, principalmente para quem é um usuário avançado. Pensando nisto a comunidade criou o projeto [Homebrew ou apenas brew](https://brew.sh/index_pt-br) que é um gerenciador de pacotes de linha de comando que possui um repositório extensivo e organizado de bibliotecas e aplicativos ([cask](https://github.com/Homebrew/homebrew-cask)) e é largamente utilizado por usuários Mac.

Neste guia irei mostrar como instalar o Homebrew e alguns comandos básicos para instalação, remoção e atualização de pacotes.

## Pré-Requisitos

* Um processador Intel de 64 bits

* macOS 10.12 ou superior

* Command Line Tools (CLT) for Xcode (instale via AppStore ou [https://developer.apple.com/downloads](https://developer.apple.com/downloads))

* Um instalação de shell: o terminal padrão (bash), [ksh](https://pt.wikipedia.org/wiki/Korn_Shell) ou [zsh](https://en.wikipedia.org/wiki/Z_shell)

## Instalação

Com todos os pré-requisitos devidamente instalados, a instalação torna-se muito fácil. O brew é um projeto desenvolvido em [ruby](https://www.ruby-lang.org/pt), então basta abrir seu *terminal* favorito e executar o comando a seguir:
```shell
/usr/bin/ruby -e “$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
```

## Utilização
Com o Homebrew instalado na máquina, basta abrir o *terminal *e começar a usar o brew. Use os comandos das categorias a seguir para manipulação:

### Pesquisar pacotes e casks
```shell
brew search ${nome_aproximado_do_pacote_ou_cask}
```

### Listar pacotes instalados
```shell
brew list
```

### Instalação de pacotes
```shell
brew install ${nome_do_pacote}
```

### Remoção de pacotes
```shell
brew remove ${nome_do_pacote}
```

### Atualização de pacotes
```shell
brew upgrade ${nome_do_pacote}
```

ou para atualizar todos os pacotes que possui (incluindo o próprio homebrew)
```shell
brew upgrade
```

### Obter informações de um pacote instalado
```shell
brew info ${nome_do_pacote}
```

O Homebrew também possui uma extensão chamada **cask** e ela tem o objetivo de prover a mesma experiência do brew core, mas para instalação de aplicativos de área de trabalho para Mac. A utilização é bem parecida com a mencionada acima:

### Instalação de casks
```shell
brew install ${nome_da_cask} --cask
```

### Listar casks instaladas
```shell
brew list --cask
```

### Remoção de casks
```shell
brew remove ${nome_da_cask} --cask
```

### Atualização de casks
```shell
brew upgrade ${nome_da_cask} --cask
```

ou para atualizar todas as casks que possui
```shell
brew upgrade --cask
```

### Obter informações de uma cask instalada
```shell
brew info ${nome_da_cask} --cask
```

Outra funcionalidade que vale muito a pena mencionar é a capacidade de gerenciar [daemons](https://en.wikipedia.org/wiki/Daemon_(computing)) diretamente pelo brew sem ter que usar o nativo [launchctl](https://en.wikipedia.org/wiki/Launchd#launchctl).

### Listar serviços em execução
```shell
brew services list
```

### Executar serviço
```shell
brew services run ${nome_do_serviço}
```

### Finalizar serviço
```shell
brew services stop ${nome_do_serviço}
```

### Reiniciar serviço
```shell
brew services restart ${nome_do_serviço}
```

## Conclusão
O Homebrew facilita muito a vida de quem utiliza o macOS e principalmente aqueles que são desenvolvedores. Como ele é um software bem extenso e maduro, existem outras funcionalidades não mencionadas neste guia que vale a pena conferir caso você queira se aprofundar no assunto. Utilize a [documentação](https://docs.brew.sh/) para maiores informações.

Até a próxima!
