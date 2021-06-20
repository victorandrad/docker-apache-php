# Local Docker Apache + PHP 5.6 / 7.2 /7.3 + Mailhog SMTP + PHPMyAdmin

## Ambiente de desenvolvimento provisionado pelo Docker.

[⛓ Links](#-links) |
[🛠 Pré-requisitos](#-pré-requisitos) |
[⚙ Instalação](#%EF%B8%8F-instalação) |
[🕹 Comandos Importantes](#-comandos-importantes) |
[🔐 Instalando o certificado ssl no Chrome](#-instalando-o-certificado-ssl-no-chrome) |
[⚙ Avançado](#-avançado) |
[🦠 Erros conhecidos](#-erros-conhecidos) |
[⚙ Configuração](#%EF%B8%8F-configuração) |
[📝 Documentação Docker](#-documentação-docker)

---

## ⛓ Links

- Apache c/ PHP 7.3 - <http://php73.local.docker/>
- Apache c/ PHP 7.2 - <http://php72.local.docker/>
- Apache c/ PHP 5.6 - <http://php56.local.docker/>
- PHPMyAdmin - <http://phpmyadmin.local.docker/>
- Servidor de SMTP - <http://smtp.local.docker>
- MailHog - <http://mailhog.local.docker/>

---
Obs: Para usar o MySQL utilize esse link para baixar [https://github.com/victorandrad/docker-mysql](https://github.com/victorandrad/docker-mysql)
---

## 🛠 Pré-requisitos

- [Docker](https://www.docker.com/)

---

## ⚙️ Instalação

### Clone o repositório

```bash
git clone https://github.com/victorandrad/docker-apache-php.git
```

### Renomeie o arquivo `.env.example` para `.env`

> Se desejar mudar a senha do banco de dados ou instalar o cliente **Oracle** para conexão veja mais em [Configuração](#%EF%B8%8F-configuração)

### Altere seu arquivo `hosts` com a seguinte entrada

```bash
127.0.0.1 php73.local.docker php72.local.docker php56.local.docker phpmyadmin.local.docker smtp.local.docker mailhog.local.docker mysql.local.docker
```

> Como alterar o `hosts` no [Windows](https://tecnoblog.net/199539/editar-arquivo-hosts-windows/) | Como alterar o `hosts` no [Mac OS](https://www.hostinger.com.br/tutoriais/como-editar-o-arquivo-hosts-no-mac/)

### Acesse a pasta do projeto

```bash
cd docker-php-56-72-73-apache
```

### Suba os containers

```bash
docker-compose up -d
```

---

## 🕹 Comandos Importantes

### Subir os containers

```bash
docker-compose up -d
```

> _A flag `-d` serve para o processo rodar em background, não ocupando o seu terminal_

### Parar os containers

```bash
docker-compose down -v --remove-orphans
```

### Reiniciar os containers

```bash
docker-compose down -v --remove-orphans && docker-compose up -d
```

### Rebuildar os containers

```bash
docker-compose down -v --remove-orphans && docker-compose build
```

---

## 🔐️ Instalando o certificado SSL no Chrome

Para que o HTTP**S** funcione, você precisa adicionar o certificado SSL em seu Chrome.

### Como fazer no WINDOWS

Para utilizar o certificado, siga as seguintes etapas:

1. Abra o seu e acesse `Configurações > Gerenciar Certificados`.
2. Clique em Importar.
3. Selecione o arquivo `local_docker_ssl.pem` que esta na pasta raiz.
4. Selecione o repositório `Autoridades de Certificação Raiz Confiáveis`.
5. Feche e abra o navegador
6. Verifique se o link [https://php72.local.docker/](https://php72.local.docker/) está funcionando, se não funcionar reinicie o computador.


### Como fazer no MacOS

Para utilizar o certificado, siga as seguintes etapas:

1. Dê dois cliques no arquivo `local_docker_ssl.pem` que esta na pasta raiz.
2. Confirme sua senha no aplicativo `Acesso às chaves`, utilize a busca para procurar o certificado `local.docker`.
3. Dê dois cliques, vá em `confiar -> ao usar este certificado -> Confiar Sempre`.
4. Feche e abra o navegador.
5. Verifique se o link [https://php72.local.docker/](https://php72.local.docker/) está funcionando, se não funcionar reinicie o computador.

> Ps: Caso tenha dúvidas utilize [este link](https://tosbourn.com/getting-os-x-to-trust-self-signed-ssl-certificates/) ou [veja este vídeo](https://www.youtube.com/watch?v=TGrX8XgSuZ4)

---

## ⚙️ Avançado

### Apache - Virtual hosts

A configuração do Apache pode ser acessada pela pasta `docker-configs/apache/`. O arquivo `docker-configs/apache/vhosts/1-vhost_80.conf` é onde ficam os vhosts.

### SSL - Certificado vencido

Caso o certificado SSL que está no repositório esteja vencido, é possível gerar um novo executando o bash `./ssl/generate_self_signed_certificate.sh`.

Após executar o comando é só reiniciar o container e reinstalar o certificado seguindo o processo [🔐️ Instalando o certificado SSL no Chrome](#-instalando-o-certificado-ssl-no-chrome)

---

## 🦠 Erros conhecidos

**ERRO:** `Couldn't connect to Docker daemon - you might need to run docker-machine start default`

MacBook-Pro-de-Victor:docker-localdev russ$ docker-machine start default
Starting "default"...
Machine "default" is already running.`

**SOLUÇÃO:** Rodar o comando: `eval $(docker-machine env default)`
Ref: [https://github.com/docker/compose/issues/2180#issuecomment-147769429](https://github.com/docker/compose/issues/2180#issuecomment-147769429)

**ERRO:** Domínio respondendo Connection Refused

Atualizar o arquivo hosts com o ip que aparece no comando `docker-machine ls`

```bash
NAME      ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER     ERRORS
default   *        virtualbox   Running   tcp://192.168.99.100:2376           v18.09.3
```

Então o hosts ficaria

```bash
192.168.99.100 php72.local.docker php56.local.docker phpmyadmin.local.docker smtp.local.docker mailhog.local.docker mysql.local.docker

```

---

## ⚙️ Configuração

No arquivo `.env` você pode definir configurações básicas como dados de acesso ao Mysql

```bash
SHARED_FOLDER_DIR=<CAMINHO ONDE FICARA OS PROJETOS>
```

```bash
MYSQL_HOST=mysql
MYSQL_ROOT_USER=root
MYSQL_ROOT_PASSWORD=123
```

Para instalar o OCI8 (cliente para conexão com bancos de dados Oracle) é só setar a variavel para 1 que no processo de build dos containers o cliente será instalado.

```bash
OCI8_INSTALL=1
```

---

## 📝 Documentação Docker

[Docker Doc](https://docs.docker.com/)

---
