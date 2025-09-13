pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/Gokul3031/devops-task.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test || echo "No tests configured"'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t logo-server .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 3000:3000 --name logo-container logo-server'
            }
        }
    }

    post {
        always {
            sh 'docker ps -a'
        }
        cleanup {
            sh 'docker stop logo-container || true'
            sh 'docker rm logo-container || true'
        }
    }
}
