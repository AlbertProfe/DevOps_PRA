# Step-by-Step Guide: Create an ECS Service

> This guide explains how to create an ECS service in **Amazon Elastic Container Service > Clusters > booksback > Create Service**.

It includes detailed steps for configuring the:

- environment,

- deployment,

- <mark>networking</mark>,

- and load balancing.

---

## **1. Create: Environment**

### **Cluster**

- **Existing Cluster**: Select the cluster `booksback` where your service will run.

### Launch Type

- **Launch Type**: Select `FARGATE`. 

**Explanation**: Fargate is a serverless compute engine that allows you to run containers without managing the underlying infrastructure. 

### **Compute Configuration**

- **Launch Type**: Choose `FARGATE` (for serverless container management).
- **Task Definition**: Select your pre-created task definition (e.g., `booksback-task`).
- **Service Name**: Enter a name for the service (e.g., `booksback-service`).
- **Number of Tasks**: Specify the desired number of tasks to launch and maintain (e.g., `1`).

**Explanation**: This step ensures that your service runs on the selected cluster with the specified task definition and maintains the desired number of tasks.

---


## **2. Deployment Configuration**

### **Service Type**

- **App Type**: Select `Application`.
  
  - **Explanation**: This is suitable for long-running applications or services that need to be highly available.

- **Service Type**: Select `Replica`.
  
  - **Explanation**: Replica ensures that the desired number of tasks are running at all times. This is ideal for most application workloads.

### **Rolling Update Deployment**

- Deployment Type: `Rolling Update` (default).
  - **Explanation**: Rolling updates replace tasks gradually to avoid downtime during updates.

### **Minimum Healthy Percent**

- Default: `100%` (or adjust based on your availability requirements).
  - **Explanation**: Ensures that at least this percentage of tasks remain healthy during deployments.

### **Maximum Percent**

- Default: `200%` (or adjust as needed).
  - **Explanation**: Allows this percentage of tasks to run during deployments, including both old and new tasks.



This configuration ensures that your ECS service is set up with a serverless launch type, uses a replica service type for high availability, and deploys updates with minimal disruption.

**Explanation**: Deployment configuration determines how tasks are replaced during updates to ensure availability.

---

## **3. Networking**

### **VPC**

- Select the VPC where your ECS service will run.

### **Subnets**

- Choose at least two subnets in different Availability Zones for high availability.

### **Security Group**

- Select or create a security group with the following inbound rules:
  - **Custom TCP Rule**: Port 80, Source: Anywhere (`0.0.0.0/0`) – Allows HTTP traffic to reach the load balancer.
  - **Custom TCP Rule**: Port 8080, Source: Anywhere (`0.0.0.0/0`) – Allows traffic from the load balancer to reach containers.
  - **HTTP Rule**: Port 80, Source: Anywhere (`0.0.0.0/0`) – Enables web traffic.

### **Auto-assign Public IP**

- Set to `Enabled` if your service needs internet access.

**Explanation**: Networking ensures that your service is accessible via the internet and securely routes traffic to containers using security groups.

---

## **4. Load Balancing**

### **Load Balancer Type**

- Select `Application Load Balancer (ALB)` for HTTP/HTTPS traffic.

### **Listener Configuration**

- Listener Port: `80` (HTTP).

### **Target Group**

1. Create a new target group:
   
   - Name: Enter a name (e.g., `booksback-target-group`).
   - Protocol: `HTTP`.
   - Port: `8080` (the port your container listens on).
   - Target Type: `IP` (for Fargate tasks).

2. Configure health checks:
   
   - Path: `/` or a specific endpoint for health checks.
   - Healthy Threshold: Default value or adjust as needed.
   - Interval and Timeout: Use default values unless specific requirements exist.

3. Register Targets:
   
   - Ensure ECS tasks are automatically registered as targets in this group.

**Explanation**: The ALB distributes incoming traffic from port 80 to the target group, which forwards it to container tasks running on port 8080.

---

## **5. Review and Create**

1. Review all configurations, including environment, deployment, networking, and load balancing.
2. Click "Create Service" to deploy your ECS service.

---

## Monitoring

After creating the service:

1. Go to the "Tasks" tab in your cluster to verify that tasks are running.
2. Check the ALB's target group health status to ensure targets are healthy.
3. Test accessing your application via the ALB's DNS name or public IP.

This setup ensures that traffic flows from the internet through the Application Load Balancer on port 80 and is forwarded securely to containers listening on port 8080.
