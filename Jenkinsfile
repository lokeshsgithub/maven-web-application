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

    stage('nexus artifact uploader'){

        nexusArtifactUploader artifacts:
         [
            [
                artifactId: 'maven-web-application',
                classifier: '',
                file: 'target/maven-web-application.war',
                type: 'war'
                   ]
       ],
        credentialsId: 'Nexus_crd',
        groupId: 'com.mt',
        nexusUrl: '13.127.243.212:8081',
        nexusVersion: 'nexus3',
        protocol: 'http',
        repository: 'mavenwebapp-snapshot',
        version: '1.1.0'

    }
    
    stage ('Send Email') {
        echo "Mail Stage";

         mail to: "lokeshreddy4590@gmail.com",
         cc: 'lokeshreddy05690@gmail.com', charset: 'UTF-8', 
         from: 'lokeshreddy05690@gmail.com', mimeType: 'text/html', replyTo: '', 
         bcc: '',
         subject: "CI: Project name -> ${env.JOB_NAME}",
         body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}";
    }    
    
}