pipeline {
    agent { label 'worker' }

    environment {
        IMAGE_NAME = 'my-node-app'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Pull Code') {
            steps {
                git url: 'https://github.com/ndrx1/forStep2.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Будуємо Docker образ з тегом
                    docker.build("${IMAGE_NAME}:${DOCKER_TAG}")
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    try {
                        // Запуск тестів всередині Docker контейнера
                        docker.image("${IMAGE_NAME}:${DOCKER_TAG}").inside {
                            sh 'npm test'  // Тести будуть запускатись в середовищі контейнера
                        }
                        testPassed = true
                    } catch (Exception e) {
                        testPassed = false
                        currentBuild.result = 'FAILURE'
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    if (testPassed) {
                        echo 'Тести пройшли успішно, пушимо на Docker Hub.'
                        // Команди для пушу Docker образу на Docker Hub
                        docker.withRegistry('https://docker.io', 'docker-hub-credentials') {
                            docker.image("${IMAGE_NAME}:${DOCKER_TAG}").push()
                        }
                    } else {
                        echo 'Тести не пройшли, пуш не виконується.'
                    }
                }
            }
        }
    }
}
