# Jenkins Pipeline with Docker

## Prerequisties

### Add dockerfile to root/project

> We need a dockerfile for building a [Docker](https://docker.com) image for running a Spring Boot application. 

We start with a basic `Dockerfile` and make a few tweaks. Then we show a couple of options that use build plugins (for Maven and Gradle) instead of `docker`.
 This is a “getting started” guide, so the scope is limited to a few 
basic needs. If you are building container images for production use, 
there are many things to consider, and it is not possible to cover them 
all in a short guide.

https://spring.io/guides/gs/spring-boot-docker

### Volumes

Use the recommended official [`jenkins/jenkins` image](https://hub.docker.com/r/jenkins/jenkins/) from the [Docker Hub repository](https://hub.docker.com/). This image contains the current [Long-Term Support (LTS) release of Jenkins](https://www.jenkins.io/download), which is production-ready.

However, this image doesn’t contain Docker CLI, and is not bundled with the frequently used Blue Ocean plugins and its features.

To use the full power of Jenkins and Docker, you may want to go through the installation process described below.

https://www.jenkins.io/doc/book/installing/docker/

```bash
docker run --name jenkins-blueocean --restart=on-failure --detach  
--network jenkins --env DOCKER_HOST=tcp://docker:2376  
--env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1  
--publish 8080:8080 --publish 50000:50000  
--volume jenkins-data:/var/jenkins_home  
--volume jenkins-docker-certs:/certs/client:ro  
myjenkins-blueocean:2.462.3-1
```

### Tools

- Go to **Manage Jenkins** > **Configure System**.
- Scroll down to the **Docker** section and add your Docker host details if needed. If you're using the default local Docker setup, you may not need to change anything.

### Plugins

Install the Docker plugin and Docker Pipeline plugin in Jenkins

### Credentials

To add <mark>Docker Hub credentials to Jenkins</mark>:

1. Go to "Manage Jenkins" > "Manage Credentials"

2. Click on "Jenkins" under "Stores scoped to Jenkins"

3. Click "Global credentials (unrestricted)"

4. Click "Add Credentials"

5. Fill out the form:
   
   - Kind: Username with password
   - Scope: Global
   - <mark>Username</mark>: Your Docker Hub username
   - <mark>Password</mark>: Your Docker Hub access token (not your account password)
   - ID: <mark>dockerhub_id</mark> (or another memorable ID)
   - Description: Docker Hub credentials

### Set variables (optional)

1. **Set Environment Variables**. Still in **Manage Jenkins** > **Configure System**, add an environment variable for Docker if needed:
   
   - Variable Name: `PATH+EXTRA`
   - Value: `/usr/local/bin` (or wherever your Docker binary is located).

### Permissions (optional)

Ensure the Jenkins user has permissions to access the Docker daemon:

`sudo usermod -aG docker jenkins`

## Approach when Docker is not installed

Table outlining different methods to install or access Docker in a Jenkins container running on Docker when the Jenkins tools are not working to install the Docker tool. The host machine is Linux Mint:





| #   | Title                                | Description & Example                                                                                                                                                                                                                                                                                                                                   |
| --- | ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | Accessing the bash console           | Access the Jenkins container's bash console to manually install Docker:<br><br>`bash<br>docker exec -it jenkins bash<br>apt-get update && apt-get install -y docker.io<br>`                                                                                                                                                                             |
| 2   | Using jenkins-cli                    | Use jenkins-cli to run commands inside Jenkins:<br><br>`bash<br>java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin docker-plugin<br>`                                                                                                                                                                                                   |
| 3   | Running sh within a Jenkins pipeline | Add a shell script step in your Jenkins pipeline to install Docker:<br><br>`groovy<br>pipeline {<br> agent any<br> stages {<br> stage('Install Docker') {<br> steps {<br> sh '''<br> apt-get update<br> apt-get install -y docker.io<br> '''<br> }<br> }<br> }<br>}<br>`                                                                                |
| 4   | Mounting the Docker socket           | When starting your Jenkins container, mount the Docker socket to use the host's Docker installation:<br><br>`bash<br>docker run -p 8080:8080 -p 50000:50000 \<br>-v /var/run/docker.sock:/var/run/docker.sock \<br>jenkins/jenkins:lts<br>`                                                                                                             |
| 5   | Docker-in-Docker (DinD)              | Create a custom Dockerfile to build a Jenkins image with Docker installed:<br><br>`dockerfile<br>FROM jenkins/jenkins:lts<br>USER root<br>RUN apt-get update && <br> apt-get -y install apt-transport-https <br> ca-certificates <br> curl <br> gnupg2 <br> software-properties-common && <br> curl -fsSL https://download.docker.com/linux/debian/gpg` |
| 6   | Using an installation script         | Use a script to automate Docker installation in Jenkins:<br><br>`bash<br>curl -fsSL https://get.docker.com -o get-docker.sh<br>sudo sh get-docker.sh<br>`                                                                                                                                                                                               |
