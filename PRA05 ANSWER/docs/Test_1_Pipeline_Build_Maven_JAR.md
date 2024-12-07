# Test 1, Build Maven JAR Pipeline


/*
pipeline {
    agent any

    environment {
        JAR_OUTPUT_DIR = 'target'  // Ruta donde se guardará el JAR
    }

    tools {
        maven 'M3'
        jdk 'JDK21'
    }

    stages {
        stage('Checkout') {
            steps {
                // Hacer checkout del proyecto de Git
                git 'https://github.com/Alexkano10/Test_Jenkins.git'
            }
        }

        stage('Build') {
            steps {
                // Ejecutar el comando Maven para limpiar y empaquetar el proyecto
                sh 'mvn clean package'
            }
        }

        stage('Archive JAR') {
            steps {
                // Archivar el archivo JAR generado en la carpeta 'target'
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
    }

    post {
        always {
            // Limpiar cualquier recurso si es necesario
            cleanWs()
        }
    }
}
*/
