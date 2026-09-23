pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'YOUR_GITHUB_REPOSITORY_URL'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t dhanush-devops-app:latest .
                '''
            }
        }

        stage('Deploy to App Server') {
            steps {
                sshagent(['app-server-ssh']) {

                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@APP_SERVER_PRIVATE_IP "
                            docker rm -f dhanush-app || true
                        "

                        docker save dhanush-devops-app:latest | \
                        gzip | \
                        ssh -o StrictHostKeyChecking=no ubuntu@APP_SERVER_PRIVATE_IP \
                        'gunzip | docker load'

                        ssh -o StrictHostKeyChecking=no ubuntu@APP_SERVER_PRIVATE_IP "
                            docker run -d \
                            --name dhanush-app \
                            -p 80:80 \
                            dhanush-devops-app:latest
                        "
                    '''
                }
            }
        }
    }
}
