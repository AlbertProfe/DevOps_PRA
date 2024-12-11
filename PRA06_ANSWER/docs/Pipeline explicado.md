## Pipeline explicado:

### 1. Declaración inicial y configuración de entorno

pipeline {
    agent any


    agent any: Indica que esta pipeline puede ejecutarse en cualquier nodo disponible de Jenkins.

    environment {
        IMAGE_NAME = 'testjenkins'
        IMAGE_TAG = "${IMAGE_NAME}-${BUILD_NUMBER}"
        AWS_ACCOUNT_ID = '559050249249'
        AWS_DEFAULT_REGION = 'us-east-1'
        IMAGE_REPO_NAME = "t6o5r2l4/test/jenkins"
        REPOSITORY_URI = "public.ecr.aws/${IMAGE_REPO_NAME}"
    }

    environment: Declara variables globales que se usan en toda la pipeline.
        IMAGE_NAME: Nombre base de la imagen Docker.
        IMAGE_TAG: Tag único para la imagen (combina el nombre y el número de compilación).
        AWS_ACCOUNT_ID: ID único de tu cuenta pública de AWS.
        AWS_DEFAULT_REGION: Región donde está configurado tu repositorio en Amazon ECR.
        IMAGE_REPO_NAME: Nombre completo del repositorio en ECR.
        REPOSITORY_URI: URI del repositorio donde se sube la imagen Docker.

### 2. Herramientas configuradas

    tools {
        maven 'M3'
        jdk 'JDK21'
    }

    tools: Especifica herramientas necesarias para la pipeline.
        maven 'M3': Usa Maven para compilar el proyecto (debe estar configurado en Jenkins).
        jdk 'JDK21': Usa JDK 21 como entorno para ejecutar el proyecto (también configurado previamente en Jenkins).

### 3. Stages principales

Stage 1: Checkout

        stage('Checkout') {
            steps {
                git 'https://github.com/Alexkano10/Test_Jenkins.git'
            }
        }

    git: Clona el repositorio remoto desde GitHub al workspace de Jenkins.

Stage 2: Build with Maven

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

    sh 'mvn clean package -DskipTests':
        Limpia el workspace del proyecto y empaqueta la aplicación.
        La opción -DskipTests omite la ejecución de pruebas para acelerar el proceso (puedes eliminar esta opción si deseas incluir las pruebas).

Stage 3: Build Docker Image

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                        docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                        docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}
                    """
                }
            }
        }

    docker build: Crea la imagen Docker usando el Dockerfile en el directorio actual. La etiqueta combina el nombre y el número de compilación.
    docker tag: Etiqueta la imagen creada para prepararla para subirla al repositorio público ECR.

Stage 4: Push Docker Image to ECR

        stage('Push Docker Image to ECR') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-access']]) {
                    script {
                        sh """
                            aws ecr-public get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin public.ecr.aws
                            docker push ${REPOSITORY_URI}:${IMAGE_TAG}
                        """
                    }
                }
            }
        }

    withCredentials: Usa las credenciales configuradas en Jenkins con el ID aws-access para autenticarse en AWS.
    aws ecr-public get-login-password: Obtiene una contraseña temporal para iniciar sesión en el registro público de Amazon ECR.
    docker push: Sube la imagen al repositorio público en Amazon ECR.

## 4. Limpieza al final

    post {
        always {
            sh """
                docker image rm ${IMAGE_NAME}:${IMAGE_TAG} || true
                docker image rm ${REPOSITORY_URI}:${IMAGE_TAG} || true
            """
        }
    }

    docker image rm: Elimina las imágenes Docker creadas para liberar espacio en el nodo Jenkins.
    || true: Ignora errores si la imagen ya no existe.

### Resumen de la pipeline

    Clona el código desde GitHub.
    Construye el proyecto usando Maven.
    Crea una imagen Docker del proyecto.
    Etiqueta y sube la imagen a Amazon ECR público.
    Limpia las imágenes Docker creadas.

