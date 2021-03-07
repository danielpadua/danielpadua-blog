---
title: "Java + Lombok"
description: "Lombok, Java: Descubra para que serve o lombok, como instalar e utilizar com as principais IDEs para java e veja também exemplos práticos sobre o uso"
date: 2019-05-05 12:00:00 -0300
last_modified_at: 2020-12-31 17:04:00 -0300
categories: [Java]
tags: [java, lombok]
image:
  src: /assets/img/posts/java-lombok/featured.png
  alt: Logotipo do java com um sinal de soma, seguido pelo logotipo do projeto lombok
---

## Introdução
Sempre ouço outros desenvolvedores comentarem coisas do tipo: “O java é uma linguagem muito verbosa”, ou comparativos de quantidade de linhas de código do clássico Hello World no java vs Linguagem XPTO. E realmente, quando desenvolvido de maneira pura (sem extensões, plugins etc) comparado a outras linguagens mais novas, o programador acaba tendo que escrever mais para atingir o objetivo.
No entanto, há algum tempo, temos uma biblioteca (ou lib) chamada [lombok](https://projectlombok.org/) que consegue simplificar (e muito) a vida de quem desenvolve java.

## Características
O *lombok* é uma lib que provê uma coleção de anotações que simplifica algumas tarefas repetitivas do java (como por exemplo, criação de getters e setters). Além de ser uma dependência do seu projeto, ele pluga na sua IDE para que entenda as anotações, portanto ele requer uma configuração. Neste guia irei demonstrar como configurar no [eclipse](https://www.eclipse.org/), [intellij idea](https://www.jetbrains.com/idea/) e também no [vscode](https://code.visualstudio.com/). Caso não saiba como trabalhar com java no **vscode** veja [este post](/pt/posts/java-spring-boot-vscode).

O repositório com as classes exemplo estão em: [https://github.com/danielpadua/lombok-examples](https://github.com/danielpadua/lombok-examples)

## Pré-requisitos
* Java JDK 8 ou superior
* Eclipse ou IntelliJ IDEA ou vscode

## Configuração na IDE
Use as seções abaixo dependendo da IDE que esteja usando:

### Eclipse
Faça o download do *lombok.jar* em: [https://projectlombok.org/download](https://projectlombok.org/download), guarde este arquivo em algum diretório de sua máquina (ex.: home do seu usuário). A partir deste ponto existem duas maneiras de configurar no eclipse:

1. Execute o arquivo *lombok.jar*. Irá abrir uma janela onde irá varrer sua máquina em busca de IDEs e caso encontre o eclipse aparecerá uma check-box para habilitar, então clique em instalar e estará feito, conforme imagem abaixo:

![Instalação no eclipse via jar](/assets/img/posts/java-lombok/lombok_eclipse_installtion.png)*Instalação no eclipse via jar*

2. Caso o método 1 não tenha funcionado ou não encontrado nenhuma IDE, iremos fazer na mão o que o jar faz por trás das cortinas. Abra o arquivo `eclipse.ini` que fica localizado no diretório da configuração do eclipse que você utiliza, edite-o conforme abaixo:

![Configurando o lombok no eclipse manualmente](/assets/img/posts/java-lombok/configuring_lombok_eclipse_manually.png)*Configurando o lombok no eclipse manualmente*
```
-javaagent:<caminho_completo>/lombok.jar
```

Estamos apenas adicionando o caminho completo jar do *lombok* como argumento na inicialização do eclipse, e isto fará com que ele entenda o lombok. O jar do *lombok* faz exatamente este processo, porém copia o jar para dentro da pasta de instalação do eclipse e o vincula no **ini** de maneira automática

### IntelliJ IDEA
É muito simples habilitar suporte do Lombok no IntelliJ IDEA, para isto, basta abrir a seção de instalação de plugins e instalar o plugin destacado a seguir:

![Plugin do Lombok no IntelliJ IDEA](/assets/img/posts/java-lombok/lombok_plugin_intellij.png)*Plugin do Lombok no IntelliJ IDEA*

Reinicie o IntelliJ IDEA e o suporte do Lombok estará habilitado e funcional.

### vscode
Pesquise por lombok na seção de extensões do vscode:

![Pesquisa de plugin do lombok no vscode](/assets/img/posts/java-lombok/lombok_plugin_vscode.png)*Pesquisa de plugin do lombok no vscode*

Instale a extensão do Gabriel Basilio Brito, que por sinal é recomendado pelo próprio site do lombok: [https://projectlombok.org/setup/vscode](https://projectlombok.org/setup/vscode). Reinicie o vscode:

![Lombok funcional no vscode](/assets/img/posts/java-lombok/lombok_working_vscode.png)*Lombok funcional no vscode*

## Projeto
Primeiramente devemos criar um projeto java spring-boot, portanto:

* Para criar um projeto java spring-boot no eclipse siga [este guia](/pt/posts/java-spring-boot-eclipse).

* Para criar um projeto java spring-boot no vscode siga [este guia](/pt/posts/java-spring-boot-intellij-idea).

* Para criar um projeto java spring-boot no intellij idea siga [este guia](/pt/posts/java-spring-boot-vscode).

Após o projeto criado, use as seções abaixo dependendo da build-tool que você esteja usando:

### Maven
Adicione a dependência no arquivo `pom.xml`:
```xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.6</version>
    <scope>provided</scope>
</dependency>
```

*Pode ser que você tenha que forçar atualização do maven na IDE*.

### Gradle

Adicione a dependência no arquivo `build.gradle`:
```groovy
repositories {
  mavenCentral()
}

dependencies {
  compileOnly ‘org.projectlombok:lombok:1.18.6’
  annotationProcessor ‘org.projectlombok:lombok:1.18.6’
}
```

## Utilização
Agora vamos explorar o que o *lombok* pode fazer para nos ajudar a reduzir o [código boilerplate](https://pt.wikipedia.org/wiki/Boilerplate_code):

### Getters, Setters, Construtores, ToString, Equals e HashCode
Para habilitar getter em todos os fields da sua classe, anote sobre a classe: `@Getter`.

Para habilitar setter em todos os fields da sua classe, anote sobre a classe: `@Setter`.

Para criar um construtor com todos os atributos como parâmetro, anote sobre a classe: `@AllArgsConstructor`, sem argumentos: `@NoArgsConstrutor`, com argumentos requeridos (ou não-nulos): `@RequiredArgsConstructor`

Para implementar o `toString()` use: `@ToString`,

Para implementar o `equals()` e `hashCode()` use: `@EqualsAndHashCode`

O `@Data` anotado na classe é um atalho para: `@ToString`, `@EqualsAndHashCode`, `@Getter`, `@Setter` e `@RequiredArgsConstructor` juntos.

Sem lombok:

```java
package br.com.danielpadua.lombok_examples;

public class Dog {
	private Integer id;
	private String name;
	private String breed;

	public Dog(Integer id, String name, String breed) {
		this.id = id;
		this.name = name;
		this.breed = breed;
	}

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBreed() {
		return breed;
	}
	public void setBreed(String breed) {
		this.breed = breed;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((breed == null) ? 0 : breed.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Dog other = (Dog) obj;
		if (breed == null) {
			if (other.breed != null)
				return false;
		} else if (!breed.equals(other.breed))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Dog [id=" + id + ", name=" + name + ", breed=" + breed + "]";
	}
}
```

Com lombok:

```java
package br.com.danielpadua.lombok_examples;

import lombok.Data;
import lombok.NonNull;

@Data
public class Dog {
	@NonNull
	private Integer id;
	@NonNull
	private String name;
	@NonNull
	private String breed;
}
```

### [Classes imutáveis](https://stackoverflow.com/questions/3162665/immutable-class)
Use a anotação: `@Value` sobre a classe, para torná-la imutável

Sem lombok:

```java
package br.com.danielpadua.lombok_examples;

public class DogCreateRequest {
	private final String name;
	private final String breed;

	public DogCreateRequest(final String name, final String breed) {
		this.name = name;
		this.breed = breed;
	}

	public String getName() {
		return name;
	}

	public String getBreed() {
		return breed;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((breed == null) ? 0 : breed.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DogCreateRequest other = (DogCreateRequest) obj;
		if (breed == null) {
			if (other.breed != null)
				return false;
		} else if (!breed.equals(other.breed))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "DogCreateRequest [name=" + name + ", breed=" + breed + "]";
	}
}
```

Com lombok:

```java
package br.com.danielpadua.lombok_examples;

import lombok.Value;

@Value
public class DogCreateRequest {
	String name;
	String breed;
}
```

### [Builder pattern](https://en.wikipedia.org/wiki/Builder_pattern)
Use a anotação: `@Builder` sobre a classe, para criar o builder pattern

Sem lombok:

```java
package br.com.danielpadua.lombok_examples;

import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class Kennel {
	private Integer id;
	private String name;
	private Set<Dog> dogs;

	public Kennel(Integer id, String name, Set<Dog> dogs) {
		this.id = id;
		this.name = name;
		this.dogs = dogs;
	}

	public static KennelBuilder builder() {
		return new KennelBuilder();
	}

	public static class KennelBuilder {
		private Integer id;
		private String name;
		private HashSet<Dog> dogs;

		KennelBuilder() {
		}

		public KennelBuilder id(Integer id) {
			this.id = id;
			return this;
		}

		public KennelBuilder name(String name) {
			this.name = name;
			return this;
		}

		public KennelBuilder dog(Dog dog) {
			if (this.dogs == null) {
				this.dogs = new HashSet<Dog>();
			}
			this.dogs.add(dog);
			return this;
		}

		public KennelBuilder dogs(Collection<? extends Dog> dogs) {
			if (this.dogs == null) {
				this.dogs = new HashSet<Dog>();
			}
			this.dogs.addAll(dogs);
			return this;
		}

		public KennelBuilder clearDogs() {
			if (this.dogs != null) {
				this.dogs.clear();
			}
			return this;
		}

		public Kennel build() {
			Set<Dog> dogs = Collections.unmodifiableSet(this.dogs);
			return new Kennel(this.id, this.name, dogs);
		}

		@Override
		public String toString() {
			return "KennelBuilder [id=" + id + ", name=" + name + ", dogs=" + dogs + "]";
		}
	}
}
```

Com lombok:

```java
package br.com.danielpadua.lombok_examples;

import java.util.Set;
import lombok.Builder;
import lombok.Singular;

@Builder
public class Kennel {
	private Integer id;
	private String name;
	@Singular
	private Set<Dog> dogs;
}
```

### Logging
Slf4j é um dos suportados, ver: [https://projectlombok.org/features/log](https://projectlombok.org/features/log) para todos os suportados

Sem lombok:

```java
package br.com.danielpadua.lombok_examples;

public class App
{
	private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(App.class);

    public static void main( String[] args )
    {
        log.info( "Hello World!" );
    }
}
```

Com lombok:

```java
package br.com.danielpadua.lombok_examples;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class App {

	public static void main(String... args) {
		log.info("Hello world");
	}
}
```

## Conclusão

Apesar do tempo de setup e configuração gasto, o *lombok* foi desenvolvido pensando em aumentar a produtividade do desenvolvedor java. Venho utilizando esta lib há algum tempo e não penso em deixar de usá-la.

Até a próxima!
