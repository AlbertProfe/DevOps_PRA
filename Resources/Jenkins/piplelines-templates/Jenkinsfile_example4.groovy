pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "M3"
    }

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/AlbertProfe/libraryH2command.git'

                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.jar'
                }
            }
        }
        
        stage('Build Docker Image') {
	      // build docker image
	      dockerImage = docker.build("libraryH2command:${env.BUILD_NUMBER}")
	    }
	   
	    stage('Deploy Docker Image'){
	      
	      // deploy docker image to nexus
			
	      echo "Docker Image Tag Name: ${dockerImageTag}"
		  
		  sh "docker stop libraryH2command"
		  
		  sh "docker rm libraryH2command"
		  
		  sh "docker run --name libraryH2command -d -p 8092:8092 libraryH2command:${env.BUILD_NUMBER}"
		  
		  // docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
	      //    dockerImage.push("${env.BUILD_NUMBER}")
	      //      dockerImage.push("latest")
	      //  }
	      
	    }
    }
}