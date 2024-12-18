## 

### 1. Create an AWS Account

- [x] Visit the AWS website and click "Create an AWS Account"
- [x] Follow the registration process, providing necessary information
- [x] Choose a support plan (Basic is free and sufficient for this exercise)

#### 2. Set Up AWS Budget and Billing Alerts

- [x] Navigate to AWS Budgets in the AWS Management Console

- [x] Click "Create budget" and choose "Customize (advanced)"

- [x] Select "Cost budget" and set a monthly fixed budget

- [x] Configure alerts for 80% of your budgeted amount

- [x] Set up an action to automatically apply an IAM policy restricting resource creation when the budget is exceeded

#### 3. Create AWS Services for Spring Boot Docker Deployment

###### Set up Amazon Elastic Container Registry (ECR)

- [x] Open the Amazon ECR console

- [x] Click "Create repository"

- [x] Name your repository (e.g., "spring-boot-app")

- [x] Configure repository settings and create 

###### Configure Amazon Elastic Container Service (ECS)

- [x] Open the Amazon ECS console

- [x] Click "Create Cluster"

- [x] Choose "Networking only" for Fargate compatibility

- [x] Name your cluster and create

##### Set up AWS Fargate

- [x] In the ECS console, create a new task definition
- [x] Choose Fargate as the launch type
- [x] Configure task size (CPU and memory)
- [x] Add container details using the ECR image

#### 4. Update Jenkins Pipeline for AWS Deployment

- [x] Modify your jenkins pipeline to include AWS deployment steps

#### 5. Deploy Spring Boot Application

- [x] Run the Jenkins pipeline to build and push the Docker image to ECR
