pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'git@github.com:jjadhav799/your-dotnet-repo.git'
            }
        }

        stage('Restore dependencies') {
            steps {
                sh 'dotnet restore'
            }
        }

        stage('Build') {
            steps {
                sh 'dotnet build --configuration Release'
            }
        }

        stage('Test') {
            steps {
                sh 'dotnet test --no-build --verbosity normal'
            }
        }

        stage('Publish') {
            steps {
                sh 'dotnet publish -c Release -o out'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploy your .NET app (e.g., copy files, run docker build, etc.)'
            }
        }
    }
}
