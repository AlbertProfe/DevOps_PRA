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
