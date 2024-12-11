
# Configuração do Jenkins no Tomcat com Monitoramento via Prometheus e Grafana

## Introdução

Esta atividade tem como objetivo configurar um servidor Jenkins atualizado em um servidor de aplicação Tomcat, seguido da implantação de um sistema de monitoramento utilizando Prometheus e Grafana. Este processo é parte essencial para a avaliação e teste de ferramentas de integração e entrega contínuas (CI/CD) utilizadas pela empresa.

## Passo a Passo da Configuração do Jenkins no Tomcat

### Preparação do Ambiente

1. Criei um diretório para armazenar os arquivos necessários:
   
   ```bash
   mkdir ESIG-AtividadePratica
   ```

2. Baixei os arquivos oficiais do Tomcat e do Jenkins.

![2](https://github.com/user-attachments/assets/3c2b5450-ac66-4147-bec7-bb17525c4f3b)

   

4. Extraí o arquivo `apache-tomcat-11.0.2.zip` para o diretório `/opt/`:
   
   ```bash
   sudo unzip apache-tomcat-11.0.2.zip -d /opt/
   ```

5. Dei permissão de execução aos arquivos `.sh` da pasta `bin`:
   
   ```bash
   sudo chmod +x *.sh
   ```

### Configuração do Tomcat

1. Editei o arquivo de usuários do Tomcat para adicionar credenciais:
   
   ```bash
   sudo vim /opt/apache-tomcat-11.0.2/conf/tomcat-users.xml
   ```
   
   Adicionei o seguinte conteúdo dentro da tag `<tomcat-users>`:

   ![config-usuario-tomcat](https://github.com/user-attachments/assets/27d10cf2-c347-4737-bab9-96eab8117d2c)


2. Iniciei o Tomcat:
   
   ```bash
   sudo ./startup.sh
   ```

3. Acessei o Tomcat Web Application Manager em: `http://localhost:8282`.

 ![manager-app](https://github.com/user-attachments/assets/0c737c0f-d297-41bb-bb67-2129c957ca5d)


### Configuração do Jenkins

1. Movi o arquivo `jenkins.war` para a pasta `webapps` do Tomcat:
   

```bash
   sudo mv jenkins.war /opt/apache-tomcat-11.0.2/webapps/
   ```


2. Atualizei o Tomcat e como podemos ver o Jenkins se encontra disponível na aplicação.

   ![jenkins](https://github.com/user-attachments/assets/168baa73-7506-42ae-8848-4fba95dd0386)


4. Recuperei a senha inicial do Jenkins com o comando:
   
   ```bash
   sudo cat /root/.jenkins/secrets/initialAdminPassword
   ```

5. Configurei o Jenkins com as credenciais administrativas e siga os passos iniciais.
![jenkins3](https://github.com/user-attachments/assets/d5e327e9-ee00-469e-8387-485897f61940)
![jenkins2](https://github.com/user-attachments/assets/398899e3-ef13-447e-8020-a2d7f060cccc)
[jenkins2](https://github.com/user-attachments/assets/b2793394-a56a-425e-b300-6795f6c44fe0)
![nova-credenciais](https://github.com/user-attachments/assets/0522070f-0ac9-4a05-a740-9e5c834fd4f1)
![jenkins4](https://github.com/user-attachments/assets/6e8263c6-a8a4-4153-9b06-907c4e96d0f3)


6. Teste de uma simple pipeline
 ![teste](https://github.com/user-attachments/assets/97baeda4-01cf-45cf-aa16-1a9bd66bbc55)


   

## Monitoramento do Jenkins com Prometheus e Grafana

### Arquivo `prometheus.yml`

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: "jenkins"
    metrics_path: "/jenkins/prometheus"
    static_configs:
      - targets:
          ['172.25.0.1:8282']
```

### Arquivo `docker-compose.yml`

```yaml
services:
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    ports:
      - "3000:3000"
```

### Configuração do Monitoramento



1. Iniciei os serviços Prometheus e Grafana:
   
   ```bash
   docker-compose up -d
   ```
3. Baixei o plugin chamado Prometheus metrics plugins que serve para expor métricas do Jenkins em um formato que pode ser coletado pelo Prometheus.
![Captura de tela de 2024-12-10 20-04-21](https://github.com/user-attachments/assets/a6001353-09b5-46c5-bc5b-495d206f134c)

2. Acessei o Prometheus em: `http://localhost:9090` e o Grafana em: `http://localhost:3000`.
 ![Captura de tela de 2024-12-10 21-48-08](https://github.com/user-attachments/assets/96858cd5-9abe-4e13-95b4-29bbb753de35)

![Captura de tela de 2024-12-10 23-07-10](https://github.com/user-attachments/assets/1ecdcfb5-2b88-42b3-9d6b-4bcd4e8aac93)


4. No Grafana, configurei o Prometheus como fonte de dados e criei um painel para monitorar as métricas do Jenkins.
 ![Captura de tela de 2024-12-10 22-01-58](https://github.com/user-attachments/assets/f4f78065-9bef-48e1-8c57-72e865abce92)
 ![Captura de tela de 2024-12-10 23-21-55](https://github.com/user-attachments/assets/48008cc6-92de-49ef-851e-d6d539404757)



## Tecnologias utilizadas
![Jenkins](https://img.shields.io/badge/Jenkins-blue?logo=jenkins&logoColor=white&style=flat-square)
![Tomcat](https://img.shields.io/badge/Tomcat-yellow?logo=apache-tomcat&logoColor=white&style=flat-square)
![Prometheus](https://img.shields.io/badge/Prometheus-orange?logo=prometheus&logoColor=white&style=flat-square)
![Grafana](https://img.shields.io/badge/Grafana-red?logo=grafana&logoColor=white&style=flat-square)
![Docker](https://img.shields.io/badge/Docker-blue?logo=docker&logoColor=white&style=flat-square)







