pipeline {
    agent {
        label 'citibanknode'
    }

    tools{
        maven 'maven3.9.0'
    }
    
    environment {
        buildNumber = "BUILD_NUMBER"
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
        
        stage('code quality: sonarqube'){
            steps{
                withSonarQubeEnv(credentialsId: 'sonarqube-credentials',installationName: 'sonarqube') {
                 sh "mvn clean package sonar:sonar"                       
              }
            }
        }
        /**
        stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
          }
        **/
        stage('Build the docker image'){
            steps{
                sh "docker build -t lokeshsdockerhub/mavenwebapp:$BUILD_NUMBER ."
            }
        }

        stage('scan the image: Trivy'){
            steps{
                sh "trivy image lokeshsdockerhub/mavenwebapp:$BUILD_NUMBER > scan.txt"
                sh "cat scan.txt"
            }
        }

        stage('Push the image into Registry'){
            steps{
                sh "docker push lokeshsdockerhub/mavenwebapp:$BUILD_NUMBER"
            }
        }

        stage('Update the image tag: k8sfile'){
            steps{
                sh "sed -i 's/TAG/${BUILD_NUMBER}/g' mavenwebapp.yml"
            }
        }
        
        stage('Deploy the Docker image in a K8s cluster'){
            steps{
                sh "kubectl apply -f mavenwebapp.yml"
            }
        }
        
        
    }//staged closed
}//pipeline closed