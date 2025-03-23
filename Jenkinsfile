pipeline{
    agent any
    environment {
        SCANNER_HOME=tool 'sonar-scanner'
    }
    stages {
        stage('clean workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Checkout from Git'){
            steps{
                git branch: 'dev', url: 'https://github.com/dungl57/assessment.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh "npm install"
            }
        }
        stage("Docker Build & Push"){
            steps{
                script{
                   withDockerRegistry(credentialsId: 'docker', toolName: 'docker'){   
                       sh "docker build -t web-weather ."
                       sh "docker tag web-weather jaesukdo/web-weather:latest "
                       sh "docker push jaesukdo/web-weather:latest "
                    }
                }
            }
        }
    }
