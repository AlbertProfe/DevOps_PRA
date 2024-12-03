# PRA04

## Explanation

I created scripts to automate all the process using .env variables to:  
- prepare resources to create both dockers: `copy-resources-sh`
    - backend
    - frontend
- create backend and frontend dockers: `docker-build.sh`
    Replaced `openjdk:21-jdk-slim` by `bellsoft/liberica-openjdk-alpine:21` because is lighter and is the official recomendation from [spring.io](https://spring.io/quickstart)
- create `docker-run.sh` to execute both dockers

To load variables from .env file I created some util files:
- remove-comments.sed  
    remove all shell comments, after # char, but keeping strings. Code based on [this post](https://sleeplessbeastie.eu/2012/11/07/how-to-remove-comments-from-a-shell-script/)

    Example cleaning of comments and empty lines:
    ```
    bash util/clean-env-file.sh util/to-test.sh
    ```

    Example of loading env vars:
    ```
    bash util/test-load-env.sh
    ```

I created also `compose.yaml` that uses both docker images created before.  
To use `docker compose`:  

    ```
    docker compose up

    # if detached is needed:
    docker compose up -d
    # and then to kill dockers:
    docker kill pra04_answer-backend-1
    docker kill pra04_answer-frontend-1
    ```



## Screenshots

### docker build backend
![docker build backend](img/pra04/01-build-backend.png)

### docker build frontend
![docker build frontend](img/pra04/02-build-frontend.png)

### list docker images
![list docker images](img/pra04/02--docker-images.png)

### launching dockers
![launching dockers](img/pra04/03-launch-dockers.png)

### dockers working
![dockers working](img/pra04/04-web-working.png)

### killing dockers
![killing dockers](img/pra04/05-killing-dockers.png)

### running docker compose
![docker compose running](img/pra04/06-docker-compose-running.png)


## Tasks

1. [x] Install Docker CLI
2. [x] Create a DockerHub Account
3. [x] Create Dockerfiles
4. [x] Build and Run Docker Containers
5. [ ] H2 Database Configuration
6. [ ] Implement Book API with Spring Boot
7. [x] Consume API with React using Axios
8. [x] docker compose
