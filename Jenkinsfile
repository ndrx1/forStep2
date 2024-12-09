pipeline {
    agent { label 'worker' }

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
                    docker.build('my-node-app')
                }
            }
        }

    

stage('Run Tests') {
    steps {
        script {
            try {
                sh 'npm test'
                testPassed = true
            } catch (Exception e) {
                testPassed = false
            }
        }
    }
}

stage('Push to Docker Hub') {
    steps {
        script {
            if (testPassed) {
                echo 'Тести пройшли успішно, пушимо на Docker Hub.'
                // Команди для пушу Docker образу
            } else {
                echo 'Тести не пройшли, пуш не виконується.'
            }
        }
    }
}
}
}
