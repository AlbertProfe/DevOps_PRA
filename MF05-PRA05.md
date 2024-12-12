## MF05-PRA05: Jenkins CI/CD Pipeline for Spring Boot Application

### CIFO La Violeta - DevOps IFCT0116-24 MF05

This practical exercise will guide you through setting up a Jenkins CI/CD pipeline for a Spring Boot project, including Docker integration.

### Tasks

#### 1. Pull Jenkins Docker Image

Pull the official Jenkins Docker image from DockerHub:

```bash
docker pull jenkins/jenkins:lts
```

#### 2. Build and Run Jenkins Container

Create and run a Jenkins container:

```bash
docker run -d -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home --name jenkins jenkins/jenkins:lts
```

To pause the container:

```bash
docker pause jenkins
```

To resume:

```bash
docker unpause jenkins
```

#### 3. Configure Jenkins Account

Access Jenkins at `http://localhost:8080` and follow the setup wizard. Retrieve the initial admin password from the Docker logs:

```bash
docker logs jenkins
```

Create an admin account during the setup process.

#### 4. Install Basic Plugins

In Jenkins, go to "Manage Jenkins" > "Manage Plugins" and install these plugins:

- Maven Integration
- Git
- Docker
- SSH
- SonarQube Scanner

#### 5. Create a Pipeline for Spring Boot Project

Create a new pipeline job in Jenkins and use this script:

```groovy
pipeline {
    agent any

    tools {
        maven 'Maven'
        jdk 'JDK'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/yourusername/PageableBooks.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    docker.build("pageablebooks:${env.BUILD_ID}")
                }
            }
        }

        stage('Docker Run') {
            steps {
                script {
                    docker.image("pageablebooks:${env.BUILD_ID}").run('-p 8080:8080')
                }
            }
        }
    }
}
```

Ensure your Spring Boot project (PageableBooks) has a Dockerfile in its root directory:

```dockerfile
FROM openjdk:11-jre-slim
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
```

This pipeline will checkout your code, build the Spring Boot application, create a Docker image, and run it[1][2][3][4][5].

### Additional Notes

- Ensure Docker is installed on the Jenkins server.
- Configure Docker permissions for the Jenkins user.
- Adjust the pipeline script according to your project structure and requirements.

### Submission Guidelines

- Fork the repository or create a new one on GitHub.
- Create a branch named `MF05-PRA05-YourNameAndSurname`.
- Implement the required changes and add the Jenkins pipeline script.
- Commit with clear messages.
- Push your branch and create a pull request titled `MF05-PRA05-YourNameAndSurname-JenkinsPipeline`.
- Create a `PRA05_ANSWER` folder to save the answer, docs, and images.

### Evaluation Criteria

- Successful setup of Jenkins in Docker.
- Correct installation and configuration of required plugins.
- Proper implementation of the Jenkins pipeline for the Spring Boot project.
- Successful Docker integration within the pipeline.
- Clear documentation and commit messages.

Citations:
[1] https://dev.to/hackmamba/jenkins-in-docker-running-docker-in-a-jenkins-container-1je?comments_sort=top
[2] https://www.red-gate.com/simple-talk/devops/containers-and-virtualization/deploying-a-dockerized-application-to-the-kubernetes-cluster-using-jenkins/
[3] https://devopscube.com/docker-containers-as-build-slaves-jenkins/
[4] https://www.youtube.com/watch?v=RKaxATb2kz8
[5] https://www.jenkins.io/doc/book/installing/docker/
[6] https://github.com/jenkinsci/docker
[7] https://phoenixnap.com/kb/how-to-configure-docker-in-jenkins