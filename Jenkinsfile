/**
@Library('lokeshsharedlibs') _
pipeline {
    agent any
    
    stages{
    
    stage('checkout code') {
        steps{
            sendSlackNotifications('STARTED')
            git credentialsId: 'github-credentials', url: 'https://github.com/lokeshsgithub/maven-web-application.git'
        }
    }

    }//stages closed
    post{
        success{
            sendSlackNotifications(currentBuild.result)
        }
        failure{
            sendSlackNotifications(currentBuild.result)
        }
    }
}//pipeline closed
**/
pipeline {
    agent any

    stages{

        stage('checkout code'){
            steps{
                git credentialsId: 'github-credentials', url: 'https://github.com/lokeshsgithub/maven-web-application.git'
            }
        }
    }
}