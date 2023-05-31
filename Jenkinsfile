node{

    stage('checkout code'){

        git credentialsId: 'Jenkins_Github_crd', url: 'https://github.com/lokeshsgithub/maven-web-application.git'
    }

    stage('UNIT testing'){

        sh "mvn test"
    }

    stage('INTEGRATION testing'){

        sh "mvn verify -DskipUnitTests"
    }

    stage('Maven Build'){

        sh "mvn clean install"
    }

    stage('static code analysis'){

        withSonarQubeEnv(credentialsId: 'sonarqube_cred') {

        sh "mvn clean package sonar:sonar"
       }
    }

    stage('Quality Gate'){

        waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube_cred'
    }

    

}