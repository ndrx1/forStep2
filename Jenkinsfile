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
            docker.image('my-node-app').inside {
                sh 'npm install --include=dev' // Установити залежності повторно
                sh 'npm test'                 // Запустити тести
            }
        }
     }
   }
        stage('Push to Docker Hub') {
    steps {
        script {
            if (currentBuild.result == 'SUCCESS') {
                echo 'Тести пройшли успішно, пушимо на Docker Hub.'
                // Додайте команди для пушу Docker-образу
            } else {
                echo 'Тести не пройшли, пуш не виконується.'
            }
        }
    }
 }

}
}
