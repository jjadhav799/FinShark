pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/jjadhav799/FinShark.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("finshark-app:latest")
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    dockerImage.run('-d -p 3000:3000')
                }
            }
        }
    }

    post {
        always {
            echo "Build and container run stage completed!"
        }
    }
}
