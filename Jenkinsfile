@Library('lokeshsharedlibs') _
pipeline {
    agent any
tools{
    maven 'maven3.9.0'
}
    stages{

    stage('Checkoutcode'){
        steps{
            sendSlackNotifications('STARTED')
            git credentialsId: '8dbd25e4-e09c-4e66-8b3f-69dfa5533519', url: 'https://github.com/lokeshsgithub/maven-web-application.git'
        }
    }
}
post{
    success{
        sendSlackNotifications(currentBuild.result)
    }
    failure{
        sendSlackNotifications(currentBuild.result)
    }
}
}