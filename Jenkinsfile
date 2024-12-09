pipeline {
    agent { label 'worker' }

    environment {
        IMAGE_NAME = 'my-node-app'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Pull Code') {
            steps {
                // Відключено використання облікових даних
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
                        // Перевірка доступності npm і запуск тестів
                        sh 'npm -v'
                        sh 'npx jest --version'  // Перевірка доступності jest
                        sh 'npm test'  // Запуск тестів
                        testPassed = true
                    } catch (Exception e) {
                        // Якщо тест не пройшов
                        testPassed = false
                        currentBuild.result = 'FAILURE'
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Якщо тести пройшли, пушимо образ
                    if (testPassed) {
                        echo 'Тести пройшли успішно, пушимо на Docker Hub.'
                        // Команди для пушу Docker образу на Docker Hub
                        docker.withRegistry('https://hub.docker.com', 'docker-hub-credentials') {
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
