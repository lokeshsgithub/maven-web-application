node{

   def mavenTool = tool 'maven3.9.2'

    stage('checkout code'){

        git credentialsId: 'Jenkins_Github_crd', url: 'https://github.com/lokeshsgithub/maven-web-application.git'
    }

    stage('UNIT testing'){

      sh "${mavenTool}/bin/mvn test"
    
    }

    stage('INTEGRATION testing'){

        sh "${mavenTool}/bin/mvn verify -DskipUnitTests"
    }

    stage('Maven Build'){

        sh "${mavenTool}/bin/mvn clean install"
    }

    stage('static code analysis'){

        withSonarQubeEnv(credentialsId: 'sonarqube_cred') {

        sh "${mavenTool}/bin/mvn clean package sonar:sonar"
       }
    }

    stage('Quality Gate'){

        waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube_cred'
    }
    post{
        failure{
            emailext to: "lokeshreddy4590@gmail.com",
            subject: "jenkins build:${currentBuild.currentResult}: ${env.JOB_NAME}",
            body: "${currentBuild.currentResult}: Job ${env.JOB_NAME}\nMore Info can be found here: ${env.BUILD_URL}"
        }
    } 

}