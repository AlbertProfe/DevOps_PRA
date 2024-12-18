# Test 2 Docker Build

/*

pipeline {
    agent any

    environment {
        IMAGE_NAME = 'testjenkins'
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
                    // Build the Docker image
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }
    }

    post {
        always {
            // Clean up the Docker image after the build
            sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true"
        }
    }
}
*/
