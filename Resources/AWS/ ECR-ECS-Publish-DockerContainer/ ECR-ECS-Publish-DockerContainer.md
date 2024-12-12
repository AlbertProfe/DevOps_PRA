# ECR and ECS to Publish Docker Container

## Summary

> **Amazon Elastic Container Service (Amazon ECS**) is a fully managed container orchestration service that simplifies the deployment, management, and scaling of containerized applications.
> 
> It integrates seamlessly with AWS and third-party tools like **Amazon Elastic Container Registry (ECR)** and **Docker**, allowing teams to focus on application development rather than infrastructure management.

[Learn more about Amazon ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html). 

## Amazon ECS Components

Amazon ECS consists of three main layers:

1. **Capacity**: The infrastructure where containers run.

2. **Controller**: Manages application deployment and runtime.

3. **Provisioning**: Tools for interfacing with the scheduler to deploy and manage applications and containers.

![Amazon ECS Layers](https://docs.aws.amazon.com/images/AmazonECS/latest/developerguide/images/ecs-layers.png)

## Step-by-Step Guide

### 1. Push Docker Image to ECR

Create a public repository in Amazon ECR and push your Docker image from DockerHub, a Linux machine CLI, or Jenkins.

#### Application lifecycle

The following diagram shows the application lifecycle and how it works with the Amazon ECS components.

![](https://docs.aws.amazon.com/images/AmazonECS/latest/developerguide/images/ecs-lifecycle.png)

### 2. Create an ECS Cluster

Set up a new ECS cluster to host your containerized application.

### 3. Create Task Definition

Define a task definition in JSON format or using the UI-AWS, specifying:

- Docker image to use

- CPU and memory requirements

- Networking mode

- IAM roles

- Other container parameters

[Learn more about Amazon ECS task definitions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html).

### 4. Create an ECS Service

Set up an ECS service to maintain a specified number of task instances:

- Define the desired task count.

- Select the task definition family.

- Configure the Networking

- Configure load balancing (optional).

- Set up task placement strategies and constraints.

[Learn more about Amazon ECS services](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_services.html).

### 5. Verify Public IP

After service deployment, check the public IP address assigned to your container for access.

## Key Concepts

- **Task Definition**: A blueprint for your application, describing container parameters and requirements.

- **ECS Service**: Maintains a specified number of task instances, ensuring continuous operation and automatic task replacement upon failure.

- **Cluster**: A logical grouping of tasks or services running on registered capacity infrastructure.
