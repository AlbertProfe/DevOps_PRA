## MF06-PRA06: AWS Deployment for Spring Boot Docker Application

### CIFO La Violeta - DevOps IFCT0116-24 MF06

This practical exercise will guide you through setting up an AWS environment to deploy a Spring Boot Docker application created in MF05-PRA05, using AWS ECR, ECS, and Fargate.

### Tasks

#### 1. Create an AWS Account

1. Visit the AWS website and click "Create an AWS Account"
2. Follow the registration process, providing necessary information
3. Choose a support plan (Basic is free and sufficient for this exercise)

![](PRA06_ANSWER/screenshots/1-create-an-aws-account.png)

#### 2. Set Up AWS Budget and Billing Alerts

1. Navigate to AWS Budgets in the AWS Management Console
2. Click "Create budget" and choose "Customize (advanced)"
3. Select "Cost budget" and set a monthly fixed budget[5]
4. Configure alerts for 80% of your budgeted amount[5]
5. Set up an action to automatically apply an IAM policy restricting resource creation when the budget is exceeded[3]

![](PRA06_ANSWER/screenshots/2-1-set-up-aws-budget-and-billing-alerts.png)


Having problems during the budget creation:
![](PRA06_ANSWER/screenshots/2-2-problems-creation-budget.png)


Solved by creating a role who has full access to AWS Budget Actions:
![](PRA06_ANSWER/screenshots/2-3-creation-role-with-budget-permssion.png)


The budget has been created successfully:
![](PRA06_ANSWER/screenshots/2-4-budget-created.png)

#### 3. Create AWS Services for Spring Boot Docker Deployment

##### Set up Amazon Elastic Container Registry (ECR)

1. Open the Amazon ECR console
2. Click "Create repository"
3. Name your repository (e.g., "spring-boot-app")
4. Configure repository settings and create

![](PRA06_ANSWER/screenshots/3-1-elastic-container-registry.png)

##### Configure Amazon Elastic Container Service (ECS)

1. Open the Amazon ECS console
2. Click "Create Cluster"
3. Choose "Networking only" for Fargate compatibility
4. Name your cluster and create

![](PRA06_ANSWER/screenshots/3-2-cluster-creation.png)

##### Set up AWS Fargate

1. In the ECS console, create a new task definition
2. Choose Fargate as the launch type
3. Configure task size (CPU and memory)
4. Add container details using the ECR image

New task definition:
![](PRA06_ANSWER/screenshots/3-3-task-definition.png)

Container creation:
![](PRA06_ANSWER/screenshots/3-4-container-creation.png)

Service creation:
- Enviroment
![](PRA06_ANSWER/screenshots/3-5-1-service-creation-enviroment.png)

- Deployment
![](PRA06_ANSWER/screenshots/3-5-2-service-creation-deployment-configuration.png)

- Networking
![](PRA06_ANSWER/screenshots/3-5-3-service-creation-networking.png)

- Load Balancing
![](PRA06_ANSWER/screenshots/3-5-4-service-creation-load-balancing-1.png)
![](PRA06_ANSWER/screenshots/3-5-4-service-creation-load-balancing-2.png)




#### 4. Update Jenkins Pipeline for AWS Deployment

Modified Jenkins pipeline to include AWS deployment steps:

```groovy
pipeline {
    agent any
    
    environment {
        AWS_ACCOUNT_ID="954976290202"
        AWS_DEFAULT_REGION="eu-central-1"
        IMAGE_REPO_NAME="books/booksback"
        IMAGE_TAG="${env.BUILD_ID}"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
        IMAGE_NAME = 'books/booksback'
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
        
        stage('Push to ECR') {
            steps {
                script {
                    sh "aws ecr-public get-login-password --region eu-central-1 | docker login --username AWS --password-stdin public.ecr.aws/c3d9t1n8"
                    sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"
                    sh "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
                }
            }
        }

        stage('Deploy to ECS') {
            steps {
                script {
                    sh "aws ecs update-service --cluster booksback --booksbackSpringService --force-new-deployment"
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

#### 5. Deploy Spring Boot Application

1.Access key creation:
![](PRA06_ANSWER/screenshots/5-1-access-key.png)


2.Errors and Changes

Error 1:
![](PRA06_ANSWER/screenshots/5-4-error-1.png)

Change:
![](PRA06_ANSWER/screenshots/5-4-change-1.png)


Error 2:
![](PRA06_ANSWER/screenshots/5-4-error-2.png)

Change:
![](PRA06_ANSWER/screenshots/5-4-change-2.png)


Error 3:
![](PRA06_ANSWER/screenshots/5-4-error-3.png)

Changes:
![](PRA06_ANSWER/screenshots/5-4-change-3.1.png)

![](PRA06_ANSWER/screenshots/5-4-change-3.2.png)


Error 4:
![](PRA06_ANSWER/screenshots/5-4-error-4.png)

Change:
![](PRA06_ANSWER/screenshots/5-4-change-4.png)




I could not find a solution yet.