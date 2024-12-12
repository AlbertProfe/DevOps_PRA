pipeline
{
    agent any
    tools { 
        maven 'mvn-jenkins' 
        jdk 'jdk-jenkins' 
    }
    environment {
        DOCKER_COMMON_CREDS = credentials('dockerhubcredentials')
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
                //build docker project with dockerfile located at project root and tagged
                bat 'docker build -f Dockerfile.groovy -t albertprofedev/libraryh2command:latest .'
            }
         }
        stage ('docker image push to Docker Hub')
        {
            steps {  
                //https://www.jenkins.io/doc/pipeline/steps/credentials-binding/
                echo 'pushing docker to dockerhub' 
                // credentials from jenkins global > groovy enviroment > withDockerRegistry
                withDockerRegistry([ credentialsId: "dockerhubcredentials", url: "" ]) {
                    bat 'echo %DOCKER_COMMON_CREDS_USR%'
                    bat 'echo %DOCKER_COMMON_CREDS_PSW%'
                    //bat 'docker login -u %DOCKER_COMMON_CREDS_USR% --password-stdin'
                    bat 'docker login -u %DOCKER_COMMON_CREDS_USR% -p %DOCKER_COMMON_CREDS_PSW%' 
                    bat 'docker push  %DOCKER_COMMON_CREDS_USR%/libraryh2command:latest'
                }
               // bat 'mvn Dockerfile.groovy:push'                    
            }
        }
    }
}
