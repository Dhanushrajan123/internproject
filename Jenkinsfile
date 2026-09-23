pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Dhanushrajan123/internproject.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t dhanush-devops-app:latest .
                '''
            }
        }

        stage('Deploy to Target Server') {
            steps {
                sshagent(['Target-server-ssh']) {

                    sh '''
                        echo "Removing old container..."

                        ssh -o StrictHostKeyChecking=no ubuntu@172.31.1.55 \
                        "docker rm -f dhanush-app || true"

                        echo "Transferring Docker image..."

                        docker save dhanush-devops-app:latest | gzip | \
                        ssh -o StrictHostKeyChecking=no ubuntu@172.31.1.55 \
                        "gunzip | docker load"

                        echo "Starting new container..."

                        ssh -o StrictHostKeyChecking=no ubuntu@172.31.1.55 \
                        "docker run -d \
                        --name dhanush-app \
                        -p 80:80 \
                        dhanush-devops-app:latest"

                        echo "Deployment completed!"
                    '''
                }
            }
        }
    }
}
