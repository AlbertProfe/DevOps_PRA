## MF06-PRA06: AWS Deployment for Spring Boot Docker Application

### CIFO La Violeta - DevOps IFCT0116-24 MF06

This practical exercise will guide you through setting up an AWS environment to deploy a Spring Boot Docker application created in MF05-PRA05, using AWS ECR, ECS, and Fargate.

### Tasks

#### 1. Create an AWS Account

1. Visit the AWS website and click "Create an AWS Account"
2. Follow the registration process, providing necessary information
3. Choose a support plan (Basic is free and sufficient for this exercise)

#### 2. Set Up AWS Budget and Billing Alerts

1. Navigate to AWS Budgets in the AWS Management Console
2. Click "Create budget" and choose "Customize (advanced)"
3. Select "Cost budget" and set a monthly fixed budget[5]
4. Configure alerts for 80% of your budgeted amount[5]
5. Set up an action to automatically apply an IAM policy restricting resource creation when the budget is exceeded[3]

#### 3. Create AWS Services for Spring Boot Docker Deployment

##### Set up Amazon Elastic Container Registry (ECR)

1. Open the Amazon ECR console
2. Click "Create repository"
3. Name your repository (e.g., "spring-boot-app")
4. Configure repository settings and create

##### Configure Amazon Elastic Container Service (ECS)

1. Open the Amazon ECS console
2. Click "Create Cluster"
3. Choose "Networking only" for Fargate compatibility
4. Name your cluster and create

##### Set up AWS Fargate

1. In the ECS console, create a new task definition
2. Choose Fargate as the launch type
3. Configure task size (CPU and memory)
4. Add container details using the ECR image

#### 4. Update Jenkins Pipeline for AWS Deployment

Modify your Jenkins pipeline to include AWS deployment steps:

```groovy
pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID="your-account-id"
        AWS_DEFAULT_REGION="your-region"
        IMAGE_REPO_NAME="spring-boot-app"
        IMAGE_TAG="${env.BUILD_ID}"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }

    stages {
        // Previous stages (build, test) here

        stage('Push to ECR') {
            steps {
                script {
                    sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                    sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"
                    sh "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
                }
            }
        }

        stage('Deploy to ECS') {
            steps {
                script {
                    sh "aws ecs update-service --cluster your-cluster-name --service your-service-name --force-new-deployment"
                }
            }
        }
    }
}
```

#### 5. Deploy Spring Boot Application

1. Run the Jenkins pipeline to build and push the Docker image to ECR
2. The pipeline will trigger a new deployment in ECS using Fargate

### Additional Notes

- Ensure proper IAM roles and permissions are set for Jenkins to interact with AWS services
- Configure network settings in ECS task definition for your Spring Boot application
- Set up an Application Load Balancer if needed for routing traffic to your Fargate tasks

### Submission Guidelines

- Fork the repository or create a new one on GitHub
- Create a branch named `MF06-PRA06-YourNameAndSurname`
- Implement the required changes and add necessary configuration files
- Commit with clear messages
- Push your branch and create a pull request titled `MF06-PRA06-YourNameAndSurname-AWSDeployment`
- Create a `PRA06_ANSWER` folder to save the answer, docs, and images

### Evaluation Criteria

- Successful creation and configuration of AWS account with proper budget controls
- Correct setup of ECR, ECS, and Fargate services
- Proper modification of Jenkins pipeline for AWS deployment
- Successful deployment of Spring Boot application to AWS
- Clear documentation and commit messages

Citations:
[1] https://repost.aws/es/questions/QU3DjdqNvwSnW1maqrMxseuw/how-to-add-a-total-monthly-spend-limit-in-2023
[2] https://docs.aws.amazon.com/cost-management/latest/userguide/management-limits.html
[3] https://docs.aws.amazon.com/cost-management/latest/userguide/budgets-controls.html
[4] https://www.youtube.com/watch?v=SX6LoXTmpdM
[5] https://aws.amazon.com/getting-started/hands-on/control-your-costs-free-tier-budgets/
[6] https://docs.aws.amazon.com/cost-management/latest/userguide/budgets-managing-costs.html?icmpid=docs_costmanagement_hp-choose-type
[7] https://www.youtube.com/watch?v=zt6Dur9fVGk
[8] https://www.reddit.com/r/aws/comments/l362qg/is_there_a_tool_for_limiting_aws_spending/
[9] https://curc.readthedocs.io/en/latest/cloud/aws/lca1/billing/budget-actions.html