pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "gokul3031/logo-server:latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main','https://github.com/Gokul3031/devops-task.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-key']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ec2-user@<EC2_PUBLIC_IP> \
                    "docker pull $DOCKER_IMAGE && docker stop logo-container || true && docker rm logo-container || true && docker run -d -p 3000:3000 --name logo-container $DOCKER_IMAGE"
                    '''
                }
            }
        }
    }
}
