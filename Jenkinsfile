@Library('lokeshsharedlibs') _
pipeline {
    agent any
tools{
    maven 'maven3.9.0'
}
environment {
  buildNumber = "BUILD_NUMBER"
}

    stages{

    stage('Checkoutcode'){
        steps{
            sendSlackNotifications('STARTED')
            git credentialsId: 'github-credentials', url: 'https://github.com/lokeshsgithub/maven-web-application.git'
        }
    }
   /**
    stage('RUn UnitTest: Maven'){
        steps{
            sh "mvn test"
        }
    }

    stage('Integration test cases: Maven'){
        steps{
            sh "mvn verify -DskipunitTests"
        }
    }

    stage('Build the package'){
        steps{
            sh "mvn clean install"
        }
    }

    stage('code quality: sonarqube'){
        steps{
            withSonarQubeEnv(credentialsId: 'sonarqube_credentials',installationName: 'sonarqube'){
            sh "mvn clean package sonar:sonar"
            }
        }
    }

    stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
    }
    
    stage('Build the Docker image'){
        steps{
            sh "docker build -t lokeshsdockerhub/mavenwebapp:$BUILD_NUMBER ."
        }
    }

    stage('Scan the image: Trivy'){
        steps{
            sh "trivy image lokeshsdockerhub/mavenwebapp:$BUILD_NUMBER > scan.txt"
            sh "cat scan.txt"
        }
    }**/
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