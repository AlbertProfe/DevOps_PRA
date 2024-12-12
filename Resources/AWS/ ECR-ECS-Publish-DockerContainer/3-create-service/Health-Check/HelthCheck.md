## AWS Fargate Health Checks

[Enabling Health Checks and CloudWatch Logs for AWS Fargate Tasks &#8211; My Devops Journal](https://skundunotes.com/2024/06/27/enabling-health-checks-and-cloudwatch-logs-for-aws-fargate-tasks/)

> In **Amazon Elastic Container Service (ECS)**, `HealthCheck` is a mechanism for <mark>monitoring the health status of containerized</mark> applications running in tasks.
> 
> It helps ensure that only healthy containers (with health check passing) serve traffic and unhealthy containers are replaced automatically.

### What are Health Checks?

- Monitoring mechanism for containerized applications in ECS tasks
- <mark>Periodically sends pings</mark> (HTTP, HTTPS, or gRPC) to specific container `endpoints`
- Determines container health based on <mark>successful responses</mark>

### Why are Health Checks Relevant?

1. **Availability**: Ensures only healthy containers serve traffic
2. **Reliability**: Automatically replaces unhealthy containers
3. **Load Balancing**: Routes traffic only to healthy containers
4. **Auto Scaling**: Helps determine when to scale out or in based on container health
5. **Monitoring**: Enables tracking of container health status via CloudWatch

### Key Features

- Configured in the `healthCheck` section of AWS Fargate task definition
- Supports various protocols (HTTP, HTTPS, gRPC)
- Integrates with Elastic Load Balancing for traffic routing
- Facilitates container replacement for maintaining application responsiveness
- Enhances auto-scaling decisions based on container health

### Implementation

- Add health check file to Docker image
- Update ECS task definition with health check configuration
- Monitor logs using Amazon CloudWatch

### Limitations

- Only ECS Managed HealthCheck available for AWS Fargate tasks
- Docker container health checks not supported in Fargate
