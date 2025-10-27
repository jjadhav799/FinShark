pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'git@github.com:jjadhav799/FinShark.git'
            }
        }

        stage('Restore dependencies') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:8.0'
                }
            }
            steps {
                sh 'dotnet restore'
            }
        }

        stage('Build') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:8.0'
                }
            }
            steps {
                sh 'dotnet build --configuration Release'
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:8.0'
                }
            }
            steps {
                sh 'dotnet test --no-build --verbosity normal'
            }
        }

        stage('Publish') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:8.0'
                }
            }
            steps {
                sh 'dotnet publish -c Release -o out'
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deploy your .NET app here (e.g., docker build & push, copy files, etc.)'
            }
        }
    }
}
