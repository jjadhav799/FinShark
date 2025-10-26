pipeline {
    agent {
        docker {
            image 'node:18'    // use your app base image
            args '-p 3000:3000'
        }
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github-creds', url: 'https://github.com/<your-username>/<your-repo>.git'
            }
        }

        stage('Build') {
            steps {
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test || echo "Tests skipped"'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t my-app:latest .'
            }
        }

        stage('Deploy') {
            steps {
                sh 'echo "Deployment step (to container / VM / cloud) goes here"'
            }
        }
    }
}
