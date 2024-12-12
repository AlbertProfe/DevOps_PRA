# CloudShell: image from DockerHub to ECR

## Private Repository

> 5 steps for pushing an image from Docker Hub to AWS ECR using the ARN

These commands will:

- `pull` the image from **DockerHub**,

- create an **ECR** repository (if needed),

- authenticate **Docker** to **ECR**,

- `tag` the image with the **ECR** repository URI,

- and finally `push` the image to ECR in the <mark>eu-central-1 region </mark>for the account (fake) <mark>111618524831</mark>.
1. Pull the image from Docker Hub:
   
   ```bash
   docker pull w3564/bookspageable:latest
   ```

2. Create an ECR repository (if not already created):
   
   ```bash
   aws ecr create-repository --repository-name bookspageable
   ```

3. Authenticate Docker to your ECR registry:
   
   ```bash
   aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 111618524831.dkr.ecr.eu-central-1.amazonaws.com
   ```

4. Tag the Docker image with the ECR repository URI:
   
   ```bash
   docker tag w3564/bookspageable:latest 111618524831.dkr.ecr.eu-central-1.amazonaws.com/bookspageable:latest
   ```

5. Push the image to ECR:
   
   ```bash
   docker push 111618524831.dkr.ecr.eu-central-1.amazonaws.com/bookspageable:latest
   ```

## Public repository

These commands will:

- `pull` the image from **DockerHub**,

- authenticate **Docker** to **ECR**,

- `tag` the image with the **ECR** repository URI,

- and finally `push` the image to ECR in the <mark>eu-central-1</mark> region

- and verify the pushed image

To pull an image from Docker Hub and push it to the specified public ECR repository, follow these steps:

1. Pull the image from DockerHub:
   
   ```bash
   docker pull w3564/bookspageable:latest
   ```

2. Authenticate Docker to your ECR registry:
   
   With your id repo: <mark> s4x3q8t5</mark> 
   
   ```bash
   aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/s4x3q8t5
   ```
   
   or a<mark> generic login</mark> to ECR service:
   
   ```bash
   aws ecr-public get-login-password --region eu-central-1 | docker login --username AWS --password-stdin public.ecr.aws
   ```

3. Tag the Docker image with the ECR repository URI:
   
   ```bash
   docker tag w3564/bookspageable:latest public.ecr.aws/s4x3q8t5/books/bookspageable:latest
   ```

4. Push the image to ECR:
   
   ```bash
   docker push public.ecr.aws/s4x3q8t5/books/bookspageable:latest
   ```

5. Verify the pushed image:
   
   ```bash
   aws ecr-public describe-images --repository-name books/bookspageable --region us-east-1
   ```

These commands will pull the image from Docker Hub, authenticate Docker to the public ECR registry, tag the image with the ECR repository URI, push the image to ECR, and finally verify that the image was successfully pushed.
