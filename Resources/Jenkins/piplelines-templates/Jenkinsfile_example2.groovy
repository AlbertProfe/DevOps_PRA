 pipeline {
 agent {
    docker {
      image 'node:10-alpine'
      args '-p 20001-20100:3000 -u root' 
    }
  }
  environment {
    CI = 'true'
    HOME = '.'
    npm_config_cache = 'npm-cache'
  }
  stages {
    stage('chekout'){
       steps {
             git 'https://github.com/albertProfe/Create-React-App'
        }
    }
    stage('Install Packages') {
      steps {
        sh 'npm install'
      }
    }
    stage('Test and Build') {
      parallel {
        stage('Run Tests') {
          steps {
            sh 'npm run test'
          }
        }
        stage('Create Build Artifacts') {
          steps {
            sh 'npm run build'
            sh 'mvn clean install'
          }
        }
      }
    }
    stage('Deployment') {
      parallel {
        stage('Staging') {
          when {
            branch 'staging'
          }
          steps {
            withAWS(region:'us-west-1',credentials:'jenkins-s3-push') {
              s3Delete(bucket: 'springbootbookswebbuild', path:'**/*')
              s3Upload(bucket: 'springbootbookswebbuild', workingDir:'build', includePathPattern:'**/*');
            }
            mail(subject: 'Staging Build', body: 'New Deployment to Staging', to: 'jenkins-mailing-list@mail.com')
          }
        }
        stage('Production') {
          when {
            branch 'master'
          }
          steps {
             withAWS(region:'us-west-1',credentials:'jenkins-s3-push') {
              s3Delete(bucket: 'springbootbookswebbuild', path:'**/*')
              s3Upload(bucket: 'springbootbookswebbuild', workingDir:'build', includePathPattern:'**/*');
            }
            mail(subject: 'Production Build', body: 'New Deployment to Production', to: 'jenkins-mailing-list@mail.com')
          }
        }
      }
    }
 }
}