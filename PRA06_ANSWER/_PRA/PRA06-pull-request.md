# PRA06

# TODO DELETE  
rsync -ar ~/Pictures/aws/./* ~/Documents/devops/prácticas/DevOps_PRA/PRA06_ANSWER/_PRA/img/pra06/
rsync -ar ~/Pictures/aws/./* ~/Documents/curso-devops/DevOps_PRA/PRA06_ANSWER/_PRA/img/pra06/
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/getting-started-fargate.html



## Tasks

1. [x] Create an AWS Account
    1. [x] Visit the AWS website and click "Create an AWS Account"
    2. [x] Follow the registration process, providing necessary information
    3. [x] Choose a support plan (Basic is free and sufficient for this exercise)
2. [ ] Set Up AWS Budget and Billing Alerts
    1. [x] Navigate to AWS Budgets in the AWS Management Console
    2. [x] Click "Create budget" and choose "Customize (advanced)"
    3. [x] Select "Cost budget" and set a monthly fixed budget
    4. [x] Configure alerts for 80% of your budgeted amount
    5. [ ] Set up an action to automatically apply an IAM policy restricting resource creation when the budget is exceeded
3. [x] Create AWS Services for Spring Boot Docker Deployment
    1. [x] Set up Amazon Elastic Container Registry (ECR)
    2. [x] Configure Amazon Elastic Container Service (ECS)
    3. [x] Set up AWS Fargate
4. [ ] Update Jenkins Pipeline for AWS Deployment
5. [ ] Deploy Spring Boot Application


## Execution

login to aws
```
aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 183631312119.dkr.ecr.eu-central-1.amazonaws.com/jcprograms/spring-conference
```

pull del docker de github y luego subirlo a ECR
```
docker pull jcprograms/springconference 
docker tag jcprograms/springconference 183631312119.dkr.ecr.eu-central-1.amazonaws.com/jcprograms/spring-conference
docker push 183631312119.dkr.ecr.eu-central-1.amazonaws.com/jcprograms/spring-conference
```

## Data

docker pull jcprograms/springconference 
docker tag jcprograms/springconference 183631312119.dkr.ecr.eu-central-1.amazonaws.com/jcprograms/spring-conference
docker push 183631312119.dkr.ecr.eu-central-1.amazonaws.com/jcprograms/spring-conference


dockerhub: docker imate
jcprograms/springconference

ECR: private image
183631312119.dkr.ecr.eu-central-1.amazonaws.com/jcprograms/spring-conference

ECS: Cluster
springConferenceClusterV2
arn:aws:ecs:eu-central-1:183631312119:cluster/springConferenceClusterV2

    SpringConferenceContainer

    

Fargate:


## Screenshots

![Alertas](img/pra06/01-alerts.png)
![Asignar región por defecto](img/pra06/02-set-default-region.png)
![Download mi docker a ECR](img/pra06/03-downloaded-docker-in-ECR.png)
![Push de mi docker a ECR](img/pra06/04-pushed-docker-to-ECR.png)
![Docker en ECR](img/pra06/05-ECR-docker-image.png)
![Inicio de ECS](img/pra06/06-ECS-service.png)
![Definición de task 1](img/pra06/07-ECS-service-task-definition.png)
![Definición de task 2](img/pra06/08-ECS-service-task-definition-2.png)
![Definición de task 3](img/pra06/09-ECS-service-task-definition-3.png)
![Task creada](img/pra06/10-ECS-service-task-created.png)
![Task deployment definición 1](img/pra06/11-ECS-service-task2-deployment-1.png)
![Task deployment definición 2](img/pra06/12-ECS-service-task2-deployment-2.png)
![Task deployment 1](img/pra06/13-ECS-service-deployment-1.png)
![Task deployment 2](img/pra06/14-ECS-service-deployment-2.png)


![](img/pra06/15-ECS-service-network.png)
![ Security group networking](img/pra06/16-ECS-security-group-networking.png)
![](img/pra06/1)
![](img/pra06/1)
![](img/pra06/1)
![Fargate is working](img/pra06/20-Fargate-working.png)
![](img/pra06/2)


### Alertas
01. ![Alertas](img/pra06/01-alerts.png)
### Asignar región por defecto
02. ![Asignar región por defecto](img/pra06/02-set-default-region.png)
### Download mi docker a ECR
03. ![Download mi docker a ECR](img/pra06/03-downloaded-docker-in-ECR.png)
### Push de mi docker a ECR
04. ![Push de mi docker a ECR](img/pra06/04-pushed-docker-to-ECR.png)
### Docker en ECR
05. ![Docker en ECR](img/pra06/05-ECR-docker-image.png)
### Inicio de ECS
06. ![Inicio de ECS](img/pra06/06-ECS-service.png)
### Definición de task 1
07. ![Definición de task 1](img/pra06/07-ECS-service-task-definition.png)
### Definición de task 2
08. ![Definición de task 2](img/pra06/08-ECS-service-task-definition-2.png)
### Definición de task 3
09. ![Definición de task 3](img/pra06/09-ECS-service-task-definition-3.png)
### Task creada
10. ![Task creada](img/pra06/10-ECS-service-task-created.png)
### Task deployment definición 1
11. ![Task deployment definición 1](img/pra06/11-ECS-service-task2-deployment-1.png)
### Task deployment definición 2
12. ![Task deployment definición 2](img/pra06/12-ECS-service-task2-deployment-2.png)
### Task deployment 1
13. ![Task deployment 1](img/pra06/13-ECS-service-deployment-1.png)
### Task deployment 2
14. ![Task deployment 2](img/pra06/14-ECS-service-deployment-2.png)
### 
15. ![](img/pra06/1x)


### Fargate is working
20. ![Fargate is working](img/pra06/20-Fargate-working.png)
