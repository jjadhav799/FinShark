pipeline {
    agent any

    environment {
        WORK_DIR = "${WORKSPACE}"
        DOTNET_CLI_HOME = "${WORKSPACE}/.dotnet"
        NUGET_PACKAGES = "${WORKSPACE}/.nuget/packages"
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
                    dotnet restore --configfile /etc/nuget.config --packages $WORKSPACE/.nuget/packages
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
                    dotnet build --configuration Release \
                        --packages $WORKSPACE/.nuget/packages \
                        --source "https://api.nuget.org/v3/index.json"
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
