# Installing docker #3: executing a pipeline



This setup demonstrates how to<mark> run a Jenkins pipeline that builds and pushes a Docker image to DockerHub</mark>. Here's an explanation of the key components:

1. Jenkins Container Setup:
   The `docker run` command launches a Jenkins container with Docker capabilities:
   
   - Exposes ports 8080 (web interface) and 50000 (agent communication)
   - Mounts the Docker socket to allow Docker commands inside Jenkins
   - Uses the `--privileged` flag for extended permissions

2. Pipeline Structure:
   The pipeline is defined using declarative syntax and consists of several stages:
   
   a. Environment Setup:
   
   - Defines DockerHub credentials and image details
   
   b. Tools:
   
   - Specifies Maven and JDK versions
   
   c. Agent:
   
   - Runs on any available agent
   
   d. Stages:
   
   - Install Dependencies: Updates and installs sudo
   - Install Docker: Sets up Docker within the Jenkins environment
   - Test Docker: Verifies Docker installation
   - Checkout: Retrieves source code from GitHub
   - Build: Compiles the project using Maven
   - Archive: Stores build artifacts
   - Build Docker Image: Creates a Docker image of the application
   - Push to DockerHub: Authenticates and pushes the image to DockerHub
   
   e. Post Actions:
   
   - Cleans up by removing local Docker images

3. Key Points:
   
   - The pipeline installs Docker within the Jenkins environment
   - It uses credentials to securely access DockerHub
   - The image is tagged with both the build number and 'latest'
   - Sudo is used for Docker commands, indicating the pipeline runs in a non-root environment

This setup allows for a complete CI/CD workflow, from code checkout to Docker image deployment, all within a Jenkins pipeline.

## Pipeline

```bash
docker run -d \
 --name jenkins \
 -p 8080:8080 \
 -p 50000:50000 \
 -v jenkins_home:/var/jenkins_home \
 -v /var/run/docker.sock:/var/run/docker.sock \
 --privileged \
 jenkins/jenkins:lts
```

```
pipeline {
 environment {
 DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
 IMAGE_NAME = 'w3564/bookspageable'
 IMAGE_TAG = "${BUILD_NUMBER}"
 }

tools {
    maven "M3"
    jdk "JDK21"
}

agent any

stages {
    stage('Install Dependencies') {
        steps {
            sh '''
                apt-get update
                apt-get install -y sudo
            '''
        }
    }

    stage('Install Docker') {
        steps {
            sh '''
                sudo apt-get update
                sudo apt-get install -y \
                    apt-transport-https \
                    ca-certificates \
                    curl \
                    gnupg \
                    lsb-release
                curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
                sudo add-apt-repository \
                    "deb [arch=amd64] https://download.docker.com/linux/debian \
                    $(lsb_release -cs) stable"
                sudo apt-get update
                sudo apt-get install -y docker-ce docker-ce-cli containerd.io
                sudo usermod -aG docker jenkins
                sudo service docker start
            '''
        }
    }

    stage('Test Docker') {
        steps {
            sh 'docker --version'
        }
    }

    stage('Checkout') {
        steps {
            git 'https://github.com/AlbertProfe/BooksPageable.git'
        }
    }

    stage('Build') {
        steps {
            sh 'mvn clean package'
        }
    }

    stage('Archive') {
        steps {
            archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
        }
    }

    stage('Build Docker Image') {
        steps {
            script {
                sh """
                    sudo docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                """
            }
        }
    }

    stage('Push to DockerHub') {
        steps {
            script {
                withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo ${DOCKER_PASS} | sudo docker login -u ${DOCKER_USER} --password-stdin
                        sudo docker push ${IMAGE_NAME}:${IMAGE_TAG}
                        sudo docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
                        sudo docker push ${IMAGE_NAME}:latest
                    """
                }
            }
        }
    }
}

post {
    always {
        sh """
            sudo docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true
            sudo docker rmi ${IMAGE_NAME}:latest || true
        """
    }
}
```

}
