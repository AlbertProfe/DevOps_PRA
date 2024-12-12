# Install docker #1: bash from host

## Step by step guide

Installing Docker inside a Jenkins container is essential for enabling seamless integration of containerization into your CI/CD pipeline. This setup allows you to:

1. **Build and Test Containerized Applications**: Run Docker commands directly in Jenkins pipelines to build, tag, and push images.

2. **Enhance Flexibility**: Bypass limitations of pre-installed tools and provide a self-contained CI/CD environment.

3. **Improve Pipeline Capabilities**: Execute Docker commands seamlessly and implement multi-stage builds.

The main reason why the Jenkins tool does not install Docker properly is due to <mark>permission issues within the Jenkins container</mark>[1](https://www.reddit.com/r/jenkinsci/comments/1fyaio2/jenkins_dockerindocker_setup_issues/)[4](https://forums.docker.com/t/docker-not-found-in-jenkins-pipeline/31683). 

When<mark> Jenkins runs as a non-root user,</mark> it lacks the necessary permissions to install and manage Docker directly. This is because Docker typically requires root or elevated privileges to function correctly[2](https://www.jenkins.io/doc/book/installing/docker/)[5](https://github.com/jenkinsci/docker/issues/345).

Additionally, the Jenkins container **often doesn't come with Docker pre-installed,** and attempting to install it within the container can lead to complications due to the containerized environment's limitations[3](https://dev.to/msrabon/step-by-step-guide-to-setting-up-jenkins-on-docker-with-docker-agent-based-builds-43j5)[6](https://dockerpros.com/integrations-and-use-cases/common-issues-when-integrating-docker-with-jenkins/). 

The standard Jenkins image is not designed to include Docker, which is why manual installation or custom Docker images are often required to integrate Docker functionality within Jenkins[1](https://www.reddit.com/r/jenkinsci/comments/1fyaio2/jenkins_dockerindocker_setup_issues/)[3](https://dev.to/msrabon/step-by-step-guide-to-setting-up-jenkins-on-docker-with-docker-agent-based-builds-43j5).

Here's a summary of the steps to install Docker in a Jenkins container:

1. On the Linux host:
   
   ```bash
   docker exec -it jenkins bash
   ```
   
   This command accesses the Jenkins container's bash console.

2. Inside the Jenkins container:
   
   ```bash
   curl https://get.docker.com/ > dockerinstall && chmod 777 dockerinstall && ./dockerinstall
   ```
   
   This downloads and runs the Docker installation script.

3. Still inside the Jenkins container:
   
   ```bash
   usermod -aG docker jenkins
   ```
   
   This adds the Jenkins user to the Docker group.

4. If permission issues persist, inside the Jenkins container:
   
   ```bash
   chmod 666 /var/run/docker.sock
   ```
   
   This changes the permissions of the Docker socket.

5. Back on the Linux host:
   
   ```bash
   docker restart jenkins2
   ```
   
   This restarts the Jenkins container to apply the changes.

Note that steps 2-4 are executed within the Jenkins container's bash, while steps 1 and 5 are performed on the Linux host machine[1].

Citations:
[1] https://get.docker.com

## Succes installation

### Console output:

The installation process completed successfully, and Docker is now operational within the container. The system also provided recommendations for running Docker as a non-privileged user and warnings about API access security.

1. Essential packages were installed, including ca-certificates and curl.

2. Docker's GPG key was downloaded and added to the system's keyring.

3. Docker's repository was added to the system's sources list.

4. Docker packages were installed, including docker-ce, docker-ce-cli, containerd.io, and related tools.

5. Docker version information was displayed, confirming the installation:
   
   - Client version: 27.3.1
   - Server version: 27.2.0
+ sh -c DEBIAN_FRONTEND=noninteractive apt-get -y -qq install ca-certificates curl >/dev/null
+ sh -c install -m 0755 -d /etc/apt/keyrings
+ sh -c curl -fsSL "https://download.docker.com/linux/debian/gpg" -o /etc/apt/keyrings/docker.asc
+ sh -c chmod a+r /etc/apt/keyrings/docker.asc
+ sh -c echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bookworm stable" > /etc/apt/sources.list.d/docker.list
+ sh -c apt-get -qq update >/dev/null
+ sh -c DEBIAN_FRONTEND=noninteractive apt-get -y -qq install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-ce-rootless-extras docker-buildx-plugin >/dev/null
  debconf: delaying package configuration, since apt-utils is not installed
+ sh -c docker version

> Client: Docker Engine - Community
> Version:           27.3.1
> API version:       1.47
> Go version:        go1.22.7
> Git commit:        ce12230
> Built:             Fri Sep 20 11:41:11 2024
> OS/Arch:           linux/amd64
> Context:           default
> 
> Server:
>  Engine:
>   Version:          27.2.0
>   API version:      1.47 (minimum version 1.24)
>   Go version:       go1.21.13
>   Git commit:       3ab5c7d
>   Built:            Fri Sep  6 19:08:45 2024
>   OS/Arch:          linux/amd64
>   Experimental:     false
>  containerd:
>   Version:          v1.7.21
>   GitCommit:        472731909fa34bd7bc9c087e4c27943f9835f111
>  runc:
>   Version:          1.1.13
>   GitCommit:        
>  docker-init:
>   Version:          0.19.0
>   GitCommit:        de40ad0

================================================================================

To run Docker as a non-privileged user, consider setting up the
Docker daemon in rootless mode for your user:

    dockerd-rootless-setuptool.sh install

Visit https://docs.docker.com/go/rootless/ to learn about rootless mode.

To run the Docker daemon as a fully privileged service, but granting non-root
users access, refer to https://docs.docker.com/go/daemon-access/

WARNING: Access to the remote API on a privileged Docker daemon is equivalent
         to root access on the host. Refer to the 'Docker daemon attack surface'
         documentation for details: https://docs.docker.com/go/attack-surface/

================================================================================

root@e492324d654e:/#

## Jenkins pipeline

```bash
pipeline {

agent any

environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
    IMAGE_NAME = 'w3564/bookspageable'
    IMAGE_TAG = "${BUILD_NUMBER}"
}

tools {
    maven 'M3'
    jdk 'JDK21'
}

stages {
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

    stage('Test') {
        steps {
            sh 'mvn test'
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
                // Build the Docker image and tag it with both BUILD_NUMBER and latest
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest ."
            }
        }
    }

    stage('Push to DockerHub') {
        steps {
            script {
                // Login to DockerHub
                sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"

                // Push both the specific tag and the latest tag
                sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                sh "docker push ${IMAGE_NAME}:latest"
            }
        }
    }
}

post {
    always {
        // Logout from DockerHub and remove images
        sh "docker logout"
        sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true"
        sh "docker rmi ${IMAGE_NAME}:latest || true"
    }
}
}
```
