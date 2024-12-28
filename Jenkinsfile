pipeline {
    agent any

    environment {
        IMAGE_NAME = "2106_soft_landing_alpine"  // Docker image name
        CONTAINER_NAME = "2106_soft_landing_alpine_container" // Docker container name
        REPO_URL = "https://github.com/AkshitGupta2002/application-pipeline.git" // Replace with your repo URL
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Checkout the code from GitHub
                git branch: 'main', url: "${REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build a new Docker image
                    sh """
                    docker build -t ${IMAGE_NAME} .
                    """
                }
            }
        }

        stage('Remove Old Container') {
            steps {
                script {
                    // Stop and remove the old container if it exists
                    sh """
                    docker ps -q --filter name=${CONTAINER_NAME} | xargs -r docker stop
                    docker ps -aq --filter name=${CONTAINER_NAME} | xargs -r docker rm
                    """
                }
            }
        }

        stage('Run New Container') {
            steps {
                script {
                    // Run the new Docker container with port mapping
                    sh """
                    docker run -d --name ${CONTAINER_NAME} -p 8070:80 ${IMAGE_NAME}
                    """
                }
            }
        }
    }

    post {
        always {
            // Cleanup dangling images to save space
            sh """
            docker image prune -f
            """
        }
    }
}

