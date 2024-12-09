pipeline {
    agent none
    triggers {
        githubPush()
    }
    stages {
        stage('Клонування репозиторію') {
            agent { label 'worker' }
            steps {
                git branch: 'main', url: 'https://github.com/ndrx1/forstep2.git'
            }
        }
        stage('Збірка Docker-образу') {
            agent { label 'worker' }
            steps {
                sh 'docker build -t forstep2 .'
            }
        }
        stage('Запуск тестів') {
            agent { label 'worker' }
            steps {
                sh 'docker run --rm forstep2 npm test'
            }
        }
        stage('Відправка в Docker Hub') {
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            agent { label 'worker' }
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker tag forStep2:latest $DOCKER_USER/forstep2:latest
                        docker push $DOCKER_USER/forstep2:latest
                    '''
                }
            }
        }
    }
    post {
        failure {
            echo 'Тести не пройшли'
        }
    }
}
