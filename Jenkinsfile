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
                    // Use Docker credentials to log in and push the image
                    withDockerRegistry(credentialsId: DOCKER_HUB_CREDENTIALS, url: 'https://registry.hub.docker.com') {
                        // Build the Docker image
                        sh "docker build -t ${DOCKER_HUB_REPO}:latest ."
                        // Push the Docker image to Docker Hub
                        sh "docker push ${DOCKER_HUB_REPO}:latest"
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
