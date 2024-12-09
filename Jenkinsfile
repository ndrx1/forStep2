pipeline {
    agent { label 'worker' }
    stages {
        stage('Pull Code') {
            steps {
                git url: 'https://github.com/ndrx1/forStep2.git', branch: 'main'
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
