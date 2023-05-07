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

    tools{
        maven 'maven3.9.0'
    }

    stages{

        stage('checkout code'){
            steps{
                git credentialsId: 'github-credentials', url: 'https://github.com/lokeshsgithub/maven-web-application.git'
            }
        }
        
        stage('Unit test: Maven'){
            steps{
                sh "mvn test"
            }
        }

        stage('Integration of testcases: Maven'){
            steps{
                sh "mvn verify -DskipunitTests"
            }
        }

        stage('Building the package: Maven'){
            steps{
                sh "mvn clean install"
            }
        }
    }
}