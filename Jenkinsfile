pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'jaesukdo/web-weather' // Replace with your Docker Hub repo
        GIT_REPO_NAME = 'assessment'       // Replace with your GitHub repo name
        GIT_USER_NAME = 'dungl57' // Replace with your GitHub username
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

                        // 1. Checkout the 'dev' branch again (important for making changes)
                        sh "git checkout dev"

                        // 2.  Make sure we're on the dev branch, and pull any remote changes
                        sh "git pull origin dev"

                        // 3. Modify the deployment file
                        sh "sed -i 's|image: .*|image: ${NEW_IMAGE_NAME}|' ./k8s-manifest/deployment.yaml"

                        // 4. Check if there were any changes
                        if (sh(returnStatus: true, script: "git diff --quiet --exit-code ./k8s-manifest/deployment.yaml") != 0) {
                            // 5. Only commit and push IF there were changes
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
