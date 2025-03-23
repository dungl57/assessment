pipeline{
    agent any
    environment {
        DOCKER_HUB_REPO = 'jaesukdo/web-weather' // Replace with your Docker Hub repo
        DOCKER_HUB_CREDENTIALS = 'jaesukdo'      // Jenkins credentials ID for Docker Hub
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
        stage('Docker Build & Push') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'docker', url: 'https://index.docker.io/v1/']) {
                        def app = docker.build('jaesukdo/web-weather')
                        app.push('latest')
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution completed.'
        }
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline execution failed. Please check the logs.'
        }
    }
}
