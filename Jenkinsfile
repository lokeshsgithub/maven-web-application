pipeline {
    agent any
    
    stages{
    
    stage('checkout code') {
        steps{
            sendSlackNotifications('STARTED')
            git credentialsId: 'github-credentials', url: 'https://github.com/lokeshsgithub/maven-web-application.git'
        }
    }

    }
}