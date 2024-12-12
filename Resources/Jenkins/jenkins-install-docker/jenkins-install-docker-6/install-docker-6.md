# Install docker #6: script

## Using Docker in Jenkins Pipeline Jobs

This summary outlines how to integrate Docker with Jenkins pipeline jobs for improved continuous integration and deployment:

1. **Prerequisites**:
   
   - Install Docker on the Jenkins host machine
   - Install two Jenkins plugins: "Docker" and "Docker Pipeline"

2. **Creating a Docker Pipeline Job**:
   
   - Create a new pipeline job in Jenkins
   - Use the pipeline script to define Docker operations

3. **Sample Pipeline Script**:
   
   ```groovy
   pipeline {
    agent any
    stages {
        stage('Run Docker') {
            steps {
                script {
                    def image = 'httpd:2.4-alpine'
                    docker.image(image).run('-p 80:80 -d')
                }
            }
        }
    }
   }
   ```

4. **Key Components**:
   
   - `docker.image(image)`: Specifies the Docker image to use
   - `.run()`: Executes the Docker container
   - Arguments like `-p 80:80 -d`: Set port mapping and detached mode

5. **Verification**:
   
   - Check Docker images and running containers on the host
   - Access the deployed application (e.g., http://host-ip:80 for Apache)

This setup demonstrates basic Docker integration in Jenkins, allowing for containerized application deployment within CI/CD pipelines.

Citations:
[1] [DevOps: How to Use Docker in Your Jenkins Pipeline Job | Docker Plugin - YouTube](https://youtu.be/H9ZHnJb3Zw8?feature=shared)


