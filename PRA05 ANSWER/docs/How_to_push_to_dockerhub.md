# Configuración de Jenkins y Docker to push Dockerhub:

        Se configuraron las credenciales en Jenkins para acceder a Docker Hub.
        Se habilitó la autenticación en Docker Hub mediante un Personal Access Token (PAT) y se configuraron las credenciales en Jenkins usando un ID (en este caso, dockerhub_credentials).

## Pipeline Jenkins:

        Se creó una pipeline que ejecuta los siguientes pasos para crear y subir imágenes Docker a Docker Hub:
## Checkout (Obtener el código):
        En esta etapa, se realiza el git clone del repositorio desde GitHub (https://github.com/Alexkano10/Test_Jenkins.git), donde se encuentra el código fuente para construir la imagen Docker.
## Build (Construcción del proyecto):
        Se ejecuta un mvn clean package para compilar el proyecto y empaquetarlo en un archivo JAR. Este paso asegura que la aplicación esté lista para ser empaquetada en un contenedor Docker.
## Build Docker Image (Construcción de la imagen Docker):
        Utilizando el archivo Dockerfile en el repositorio, se construye la imagen Docker etiquetada con el nombre testjenkins_bookspageable y con una etiqueta que corresponde al número de construcción de Jenkins (${BUILD_NUMBER}). Además, se asigna la etiqueta latest.
## Login to DockerHub (Autenticación en Docker Hub):
        Jenkins usa las credenciales almacenadas para iniciar sesión en Docker Hub, utilizando el docker login con el nombre de usuario y el token de acceso.
## Push Docker Image to DockerHub (Subida de la imagen a Docker Hub):
        Se sube la imagen Docker con las etiquetas 5 y latest al repositorio en Docker Hub (alexkano10/test_jenkins_books_pageables). En esta etapa, se asegura que la imagen esté disponible públicamente en Docker Hub.
## Cleanup (Limpieza):
        Finalmente, se eliminan los contenedores y las imágenes locales en el entorno de Jenkins para evitar la acumulación de archivos innecesarios. Esto asegura que el entorno de Jenkins se mantenga limpio y eficiente.

Código de la última pipeline:

/*
pipeline {
    agent any

    environment {
        IMAGE_NAME = 'testjenkins_bookspageable'
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

        stage('Login to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                    }
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker push ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    // Remove the Docker container after the push
                    sh "docker rm -f ${IMAGE_NAME}"
                    sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker rmi ${IMAGE_NAME}:latest"
                }
            }
        }
    }
}
*/

***Detalles importantes:***

<!-- Autenticación en Docker Hub: La pipeline se asegura de realizar el login en Docker Hub utilizando las credenciales almacenadas en Jenkins, lo que permite subir las imágenes de manera segura.
    Automatización: Todos los pasos (build, push y limpieza) están automatizados, lo que garantiza un flujo de trabajo eficiente y libre de errores.
    Limpieza: Después de que las imágenes se suben correctamente, se realizan acciones de limpieza para eliminar los contenedores e imágenes locales, lo que ayuda a mantener el entorno de Jenkins limpio. -->
