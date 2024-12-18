# Test 4 Docker Build and Run passed

/* 

pipeline {
    agent any

    environment {
        IMAGE_NAME = 'testjenkins_bookspageable'  // Cambié el nombre aquí
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    tools {
        maven 'M3'
        jdk 'JDK21'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Alexkano10/Test_Jenkins.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image with a custom tag
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container with a valid container name
                    sh "docker run -d -p 8081:8080 --name ${IMAGE_NAME} ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }

    post {
        always {
            // Clean up by stopping and removing the container after the job
            sh "docker stop ${IMAGE_NAME} || true"
            sh "docker rm ${IMAGE_NAME} || true"
        }
    }
}

*/


