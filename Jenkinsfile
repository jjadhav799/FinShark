pipeline {
    agent any

    environment {
        DOTNET_CLI_HOME = '/tmp'
        HOME = '/tmp'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/jjadhav799/FinShark.git'
            }
        }

        stage('Restore dependencies') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:8.0'
                    args '-u root' // run as root to avoid permission denied
                }
            }
            steps {
                sh '''
                    mkdir -p /tmp/.nuget
                    chmod -R 777 /tmp
                    dotnet restore
                '''
            }
        }

        stage('Build') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:8.0'
                    args '-u root'
                }
            }
            steps {
                sh '''
                    chmod -R 777 /tmp
                    dotnet build --configuration Release
                '''
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:8.0'
                    args '-u root'
                }
            }
            steps {
                sh '''
                    chmod -R 777 /tmp
                    dotnet test --no-build --verbosity normal
                '''
            }
        }

        stage('Publish') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:8.0'
                    args '-u root'
                }
            }
            steps {
                sh '''
                    chmod -R 777 /tmp
                    dotnet publish -c Release -o out
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deploy your .NET app here (e.g., docker build & push, copy files, etc.)'
            }
        }
    }
}
