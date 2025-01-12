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

        withSonarQubeEnv(credentialsId: 'sonar_auth') {

        sh "${mavenTool}/bin/mvn clean package sonar:sonar"
       }
    }

    stage('Quality Gate'){


        waitForQualityGate abortPipeline: false, credentialsId: 'sonar_auth'
              timeout(time: 1, unit: 'HOURS') {
              def qg = waitForQualityGate()
              if (qg.status != 'OK') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
              }
          }
    }

    stage('nexus artifact uploader'){

        def readPomVersion = readMavenPom file: 'pom.xml'
        
        def nexusRepo = readPomVersion.version.endsWith("SNAPSHOT") ? "mavenwebapp-Snapshot" : "mavenwebapp-release"
        
        nexusArtifactUploader artifacts:
         [
            [
                artifactId: 'maven-web-application',
                classifier: '', file: 'target/maven-web-application.war',
                type: 'war'
                ]
       ],
        credentialsId: 'Nexus_crd',
        groupId: 'com.mt',
        nexusUrl: '13.127.59.129:8081',
        nexusVersion: 'nexus3',
        protocol: 'http',
        repository: nexusRepo,
        version: "${readPomVersion.version}"

    }

    stage('Deploy the application in tomcat server'){
        sshagent(['Tomcat_pwd']) {
            sh "scp -o StrictHostKeyChecking=no */*.war ec2-user@13.127.19.58:/opt/apache-tomcat-9.0.75/webapps"
    }
    
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