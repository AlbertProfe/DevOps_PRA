# CI/CD (Continuous Integration/Continuous Deployment) Jenkins pipeline

## Key elements

The **CI/CD (Continuous Integration/Continuous Deployment) pipeline** is used for deploying applications to the AWS cloud.

The <mark>key elements of the pipeline are:</mark>

1\. **Docker**: The pipeline starts with a Docker container, which likely contains the application code and its dependencies.

2\. **Jenkins**: Jenkins is an open-source automation server that orchestrates the various stages of the CI/CD pipeline.

3\. **GitHub**: The application code is stored in a GitHub repository, which is integrated with the Jenkins pipeline.

4\. **AWS ECR (Elastic Container Registry):** After the Docker image is built, it is pushed to the AWS ECR, which is a private Docker container registry hosted on AWS.

5\. **AWS ECS (Elastic Container Service)**: The Docker image stored in AWS ECR is then deployed to the AWS ECS, which is a fully managed container orchestration service.

6\. **AWS Fargate or EC2**: The container workloads are then run on either AWS Fargate (a serverless compute engine for containers) or EC2 (Elastic Compute Cloud) instances.

## Flow summary

The <mark>flow of the pipeline</mark> is as follows:

1\. A developer commits code changes to the GitHub repository.

2\. Jenkins, which is integrated with GitHub, detects the code changes and triggers the pipeline.

3\. Jenkins builds a new Docker image using the updated code.

4\. The Docker image is pushed to the AWS ECR.

5\. The updated Docker image is then deployed to the AWS ECS, which runs the application on either Fargate or EC2 instances.

This pipeline automates the process of building, testing, and deploying the application to the AWS cloud, ensuring that changes are integrated and deployed quickly and consistently.

## Pipeline

> By integrating Jenkins with GitHub, t**he pipeline is triggered automatically whenever code changes are pushed** to the repository. 

Jenkins then <mark>orchestrates the entire process</mark> of building, containerizing, and deploying the application to the AWS cloud infrastructure, specifically utilizing the ECR for container image storage and the ECS with Fargate for scalable and managed container deployment.

1. **Jenkins** Integration with **GitHub**:
   - The Jenkins server is integrated with the GitHub repository where the application code is hosted.
   - This integration allows Jenkins to monitor the GitHub repository for any code changes or new commits.
   - When a developer pushes code changes to the GitHub repository, Jenkins is automatically notified about the update.
2. **Jenkins** as the <mark>Pipeline Orchestrator:</mark>
   - Jenkins is the central orchestrator of the entire CI/CD pipeline.
   - It does not directly store the application code itself. Instead, Jenkins retrieves the code from the connected GitHub repository when needed.
   - Jenkins manages the various stages of the pipeline, such as building, testing, packaging, and deploying the application.
3. Triggering the Pipeline on **Code Push**:
   - When a developer pushes code changes to the GitHub repository, the integration with Jenkins triggers the pipeline automatically.
   - This trigger event signals Jenkins to start the predefined pipeline workflow.
4. Building and **Dockerizing** the Spring Boot Application:
   - The pipeline executed by Jenkins will first build the Spring Boot application.
   - Jenkins then creates a Docker image from the built application, packaging the code and its dependencies into a containerized format.
5. Pushing the Docker Image to **AWS ECR**:
   - After the Docker image is built, Jenkins pushes the image to the AWS Elastic Container Registry (ECR).
   - ECR is a private Docker container registry hosted on AWS, which provides a secure and scalable location to store the application's Docker images.
6. Deploying to **AWS ECS with Fargate**:
   - The pipeline then deploys the Docker image from ECR to the AWS Elastic Container Service (ECS).
   - ECS is the container orchestration service provided by AWS, and it is responsible for managing the lifecycle of the containerized application.
   - In this case, the application is deployed to run on the AWS Fargate compute engine, which is a serverless option for running containers without the need to manage the underlying infrastructure (EC2 instances).



## AWS Services Deployment

The use of  AWS services in this pipeline helps to achieve continuous integration and continuous deployment, which are important practices in modern software development and deployment workflows.​​​​​​​​​​​​​​​​

1. **AWS ECR (Elastic Container Registry):**
   - This is a fully managed Docker container registry provided by AWS.
   - It allows you to store, manage, and deploy Docker container images securely.
   - By storing the Docker images in ECR, the pipeline can ensure that the same consistent and vetted container images are deployed across different environments (e.g., development, staging, production).
   - ECR integrates seamlessly with other AWS services, such as ECS, making it easy to deploy the container images.
2. **AWS ECS (Elastic Container Service):**
   - ECS is a fully managed container orchestration service provided by AWS.
   - It allows you to run and scale Docker containers on a serverless infrastructure.
   - ECS takes care of tasks like provisioning and managing the underlying infrastructure (EC2 instances or Fargate) needed to run your containers.
   - In the pipeline depicted, the updated Docker image from ECR is deployed to the ECS service, which then manages the containerized application.
3. **AWS Fargate:**
   - Fargate is a serverless compute engine for containers provided by AWS.
   - It allows you to run containers without having to manage the underlying infrastructure (EC2 instances).
   - With Fargate, you only pay for the resources (CPU and memory) consumed by your containers, without having to provision or manage the servers.
   - In the pipeline, the containerized application can be deployed to run on the Fargate compute engine.
4. **AWS EC2 (Elastic Compute Cloud):**
   - EC2 is the core compute service provided by AWS, allowing you to run virtual machines (instances) on the cloud.
   - In the pipeline, the containerized application can also be deployed to run on EC2 instances, where you have more control over the underlying infrastructure.
   - EC2 instances provide more flexibility and customization options compared to the serverless Fargate, but require more management overhead.