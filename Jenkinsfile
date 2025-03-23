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
        stage('Update Deployment File for new image if applicable') {
            steps {
                script {
                    withCredentials([gitUsernamePassword(credentialsId: 'github', gitToolName: 'Default')]){
                       NEW_IMAGE_NAME = "jaesukdo/web-weather:latest"
                       sh "sed -i 's|image: .*|image: $NEW_IMAGE_NAME|' ./k8s-manifest/deployment.yaml"
                       sh 'git add ./k8s-manifest/deployment.yaml'
                       sh "git commit -m 'Update deployment image to $NEW_IMAGE_NAME'"
                       sh "git push https://${GIT_USER}:${GIT_PASSWORD}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME}.git HEAD:dev"
                    }
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
