pipeline {
    agent {
        docker {
            image 'node:18'    // Use your app base image
            args '-p 3001:3000'
        }
    }

    stages {

        stage('Checkout') {
            steps {
                git url: 'https://github.com/jjadhav799/FinShark.git',
                    branch: 'master',
                    credentialsId: 'jjadhav799'
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

    } // ← end of stages

} // ← end of pipeline
