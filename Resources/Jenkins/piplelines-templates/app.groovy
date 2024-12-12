pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "albertprofehub/bookspageable"
        AWS_REGION = "us-east-1"
        ECR_REGISTRY = "<your-aws-account-id>.dkr.ecr.${AWS_REGION}.amazonaws.com"
        ECR_REPOSITORY = "bookspageable"
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

        stage('Docker Build') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        // This block will log in using the credentials specified
                    }
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_NUMBER}").push()
                    }
                }
            }
        }

        stage('Login to AWS ECR') {
            steps {
                script {
                    // Authenticate Docker to your Amazon ECR registry
                    sh '''
                        aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}
                    '''
                }
            }
        }

        stage('Tag and Push Image to ECR') {
            steps {
                script {
                    // Tag the image for ECR
                    sh "docker tag ${DOCKER_IMAGE}:${env.BUILD_NUMBER} ${ECR_REGISTRY}/${ECR_REPOSITORY}:${env.BUILD_NUMBER}"
                    
                    // Push the image to ECR
                    sh "docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${env.BUILD_NUMBER}"
                }
            }
        }

        stage('Deploy to ECS') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'fake-aws-credentials']]) {
                    sh '''
                        aws ecs update-service --cluster my-fake-cluster --service my-fake-service --force-new-deployment
                    '''
                }
            }
        }

        stage('Cleanup') {
            steps {
                sh 'docker image prune -af'
            }
        }
    }
}
