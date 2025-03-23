pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'jaesukdo/web-weather' 
        GIT_REPO_NAME = 'assessment'
        GIT_USER_NAME = 'dungl57'
    }

    stages {
        stage('clean workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout from Git') {
            steps {
                git branch: 'dev', credentialsId: 'github', url: 'https://github.com/dungl57/assessment.git'
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    // Use withCredentials for Docker Hub credentials
                    withDockerRegistry([credentialsId: 'docker', url: 'https://index.docker.io/v1/']) {
                        sh "docker build -t ${DOCKER_HUB_REPO} ."
                        sh "docker tag ${DOCKER_HUB_REPO} ${DOCKER_HUB_REPO}:${BUILD_NUMBER}"
                        sh "docker push ${DOCKER_HUB_REPO}:${BUILD_NUMBER}"
                    }
                }
            }
        }

        stage('Update Deployment File') {
            steps { // Correct placement of steps
                script {
                    // Use withCredentials for GitHub credentials
                    withCredentials([usernamePassword(credentialsId: 'github', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASSWORD')]) {
                        // Use the full image name with tag
                        def NEW_IMAGE_NAME = "${DOCKER_HUB_REPO}:${BUILD_NUMBER}"

                        sh "git checkout dev"

                        sh "git pull origin dev"

                        sh "sed -i 's|image: .*|image: ${NEW_IMAGE_NAME}|' ./k8s-manifest/deployment.yaml"

                        if (sh(returnStatus: true, script: "git diff --quiet --exit-code ./k8s-manifest/deployment.yaml") != 0) {
                                sh 'git config --global user.email "jenkins@example.com"'
                                sh 'git config --global user.name "Jenkins CI"'
                                sh 'git add ./k8s-manifest/deployment.yaml'
                                sh "git commit -m 'Update deployment image to ${NEW_IMAGE_NAME}'"
                                sh "git push https://${GIT_USER}:${GIT_PASSWORD}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME}.git HEAD:dev"
                        } else {
                            echo "No changes to deployment.yaml, skipping commit and push."
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
        failure {
            echo 'Pipeline execution failed. Please check the logs.'
        }
    }
}
