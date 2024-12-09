pipeline {
    agent { label 'jenkins-worker' }

    environment {
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials-id' // замініть на реальний ID облікових даних
    }

    stages {
        stage('Pull Code') {
            steps {
                git 'https://github.com/yourusername/forStep2.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('my-node-app')
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    def dockerImage = docker.image('my-node-app')
                    dockerImage.inside {
                        sh 'npm test'
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    if (currentBuild.result == 'SUCCESS') {
                        docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                            docker.image('my-node-app').push()
                        }
                    } else {
                        echo 'Тести не пройшли'
                    }
                }
            }
        }
    }
}
