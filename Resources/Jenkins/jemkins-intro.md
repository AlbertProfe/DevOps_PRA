# Jenkins

## Installing

### Prerequisites

Minimum hardware requirements:

- 256 MB of RAM

- 1 GB of drive space (although 10 GB is a recommended minimum if running
  Jenkins as a Docker container)

Recommended hardware configuration for a small team:

- <mark>4 GB+ of RAM</mark>

- <mark>50 GB+ of drive space</mark>

Comprehensive hardware recommendations:

- Hardware: see the [Hardware Recommendations](https://www.jenkins.io/doc/book/scaling/hardware-recommendations) page

Software requirements:

- Java: see the [Java Requirements](https://www.jenkins.io/doc/book/platform-information/support-policy-java/) page

- Web browser: see the [Web Browser Compatibility](https://www.jenkins.io/doc/administration/requirements/web-browsers/) page

- For Windows operating system: [Windows Support Policy](https://www.jenkins.io/doc/administration/requirements/windows/)

- For Linux operating system: [Linux Support Policy](https://www.jenkins.io/doc/book/platform-information/support-policy-linux/)

- For servlet containers: [Servlet Container Support Policy](https://www.jenkins.io/doc/book/platform-information/support-policy-servlet-containers/)

*Links*

Installing [Linux](https://www.jenkins.io/doc/book/installing/linux/)

Installing [Docker](https://www.jenkins.io/doc/book/installing/docker/)

Download docker for [Jenkins](https://hub.docker.com/r/jenkins/jenkins)

Official Jenkins Docker [image]([docker/README.md at master · jenkinsci/docker · GitHub](https://github.com/jenkinsci/docker/blob/master/README.md))

## Pipeline

To automate the deployment of a <mark>Spring Boot project from GitHub using Jenkins and Docker</mark>, follow these steps:

1. **Set Up Jenkins**: Install Jenkins and configure it to use Docker. Ensure Docker is installed on the Jenkins server-

2. **Create Jenkins Pipeline**:
   
   - Use a Jenkinsfile to define the pipeline stages: checkout code, build with Maven, create a Docker image, and push it to DockerHub.

3. **Dockerize the Application**:
   
   - Create a `Dockerfile` in your Spring Boot project to containerize the application.

4. **Deploy the Docker Image**:
   
   - Pull and run the Docker image on your production server.
   
   - Consider deploying to platforms like AWS, Azure, or Google Cloud for scalability and reliability

### Dockerfile

Create a `Dockerfile` in your Spring Boot project directory

```javadoclike
# Use an official OpenJDK runtime as the base image
FROM openjdk:17-jdk-alpine

# Add a volume pointing to /tmp
VOLUME /tmp

# Make port 8080 available to the world outside this container
EXPOSE 8080

# The application's jar file
ARG JAR_FILE=target/*.jar

# Add the application's jar to the container
ADD ${JAR_FILE} app.jar

# Run the jar file
ENTRYPOINT ["java","-jar","/app.jar"]
```

### Jenkinsfile

Create a `Jenkinsfile` in your <mark>project root.</mark> To use the pipeline:

1. Ensure Jenkins is set up with necessary plugins (<mark>Docker Pipeline, AWS Credentials,</mark> Kubernetes CLI.

2. Configure AWS credentials in Jenkins.

3. Create an Amazon ECR repository named "bookspageable".

4. Set up an EKS cluster and replace "your-eks-cluster-name" in the Jenkinsfile.

5. *(Optional)* Create a Kubernetes deployment manifest for your application and apply it to your EKS cluster before running this pipeline.

This pipeline will checkout your code, build the Spring Boot application, create a Docker image, push it to Amazon ECR, and update the deployment in your EKS cluster with the new image

### AWS Credentials

```yaml
stage('Deploy to AWS') {
    steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'fake-aws-credentials']]) {
            sh '''
                aws ecs update-service --cluster my-fake-cluster --service my-fake-service --force-new-deployment
            '''
        }
    }
}
```

Explanation of the Pipeline Stage

- **withCredentials**: This block allows Jenkins to use the specified AWS credentials securely during the execution of commands within it.
- **sh command**: The command `aws ecs update-service` updates your ECS service with a new deployment, ensuring that it uses the latest Docker image that was pushed earlier in the pipeline

### Deployment on AWS

We are using ECS AWS:

1. **ECS Setup**: Use Amazon ECS to manage Docker containers. Create a cluster and define a task with your Docker image.
2. **Service Update**: Use the AWS CLI command in the Jenkins pipeline to update the ECS service, triggering a new deployment with the latest Docker image.

*AWS and DockerHub:*

> Ensure you have configured AWS credentials in Jenkins and have access to your DockerHub account for pushing images. 

AWS can retrieve Docker images from Docker Hub, but it typically involves a few steps to facilitate the process. Here’s how it works:

1. **Pulling from Docker Hub**: You can pull a Docker image directly from Docker Hub to an AWS service like EC2 or ECS. This process involves using the `docker pull` command on your AWS instance to download the image.

2. **Using Amazon ECR**: Alternatively, many users prefer to push their Docker images from Docker Hub to Amazon Elastic Container Registry (ECR). This allows for better integration with other AWS services and provides a more secure environment for storing container images.

3. **Steps to Push an Image from Docker Hub to ECR**:
   
   - **Authenticate with ECR**: Use the AWS CLI to log in to your ECR registry.
   - **Pull the Image**: Pull the desired image from Docker Hub using `docker pull`.
   - **Tag the Image**: Tag the pulled image with the ECR repository URI.
   - **Push to ECR**: Finally, push the tagged image to your ECR repository using `docker push`.

4. **AWS Services Deployment**: Once the image is in ECR, you can deploy it using services like Amazon ECS or EKS by referencing the image stored in ECR.

This process ensures that your Docker images are securely stored and easily accessible within your AWS environment, facilitating seamless deployment and scaling of applications.

### Execute Pipeline

Run your Jenkins pipeline. 

> The deployment command will execute using the fake credentials you configured, simulating what would happen in a real environment without making actual changes to any AWS resources.
