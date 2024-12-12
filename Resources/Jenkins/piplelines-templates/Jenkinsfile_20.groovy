pipeline {
    agent any
    tools { 
        maven 'mvn-jenkins' 
        jdk 'jdk-jenkins' 
    }
    stages {
        stage ('Checking java version') {
            steps {
                bat 'java -version'
                echo 'This is a minimal pipeline.' 
            }
        }
        stage ('Cloning github repository') {
            steps {
                git 'https://github.com/AlbertProfe/libraryH2command.git'
            }
        }
        
        stage ('maven version') {
            steps {     
                bat 'mvn -version'                
            }
        }
        
        stage ('build app test') {
            steps {               
                bat 'mvn clean install -DskipTests=true '                                    
            }
        }
        
        stage ('docker image build')
        {
            steps {
                //build 
                  bat 'docker build -f Dockerfile.groovy -t project/libraryh2command:latest .'
                }
          }
        stage ('docker image push to Docker Hub') {
            steps {  
                echo 'to do ....' 
                //withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
        	    //sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                //sh 'docker push project/springbootlibraryH2command:latest'
                bat 'mvn dockerfile:push'                          
            }
        }
    }
}
