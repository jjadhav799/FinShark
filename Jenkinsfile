pipeline {
    agent any

    environment {
        NUGET_PACKAGES = "${WORKSPACE}/.nuget/packages"
        DOTNET_CLI_HOME = "${WORKSPACE}/.dotnet"
        HOME = "${WORKSPACE}"
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
                    args '-u root'
                }
            }
            steps {
                sh '''
                    mkdir -p $WORKSPACE/.nuget/packages
                    mkdir -p $WORKSPACE/.dotnet
                    chmod -R 777 $WORKSPACE
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
                sh 'dotnet build --configuration Release'
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
                sh 'dotnet test --no-build --verbosity normal'
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
                sh 'dotnet publish -c Release -o out'
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deployment step goes here!'
            }
        }
    }
}
