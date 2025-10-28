pipeline {
    agent any

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
                    args '-u root -v $WORKSPACE/tmp:/tmp -v $WORKSPACE/.nuget:/root/.nuget'
                }
            }
            steps {
                sh '''
                    mkdir -p $WORKSPACE/tmp $WORKSPACE/.nuget
                    chmod -R 777 $WORKSPACE
                    export HOME=$WORKSPACE
                    export DOTNET_CLI_HOME=$WORKSPACE/.dotnet
                    export NUGET_PACKAGES=$WORKSPACE/.nuget/packages
                    echo "✅ Custom environment ready for restore"
                    dotnet build --configuration Release --packages $NUGET_PACKAGES
                    dotnet restore --configfile /var/jenkins_home/NuGet.Config --packages /var/jenkins_home/.nuget/packages



                '''
            }
        }

        stage('Build') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:8.0'
                    args '-u root -v $WORKSPACE/tmp:/tmp -v $WORKSPACE/.nuget:/root/.nuget'
                }
            }
            steps {
                sh '''
                export NUGET_PACKAGES=/var/jenkins_home/.nuget/packages
                    mkdir -p $WORKSPACE/tmp $WORKSPACE/.nuget
                    chmod -R 777 $WORKSPACE
                    export HOME=$WORKSPACE
                    export DOTNET_CLI_HOME=$WORKSPACE/.dotnet
                    export NUGET_PACKAGES=$WORKSPACE/.nuget/packages
                    echo "🏗️  Building project safely..."
                   
                '''
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:8.0'
                }
            }
            steps {
                sh '''mkdir -p /var/jenkins_home/workspace/My-Docker-CI-CD@2/tmp /var/jenkins_home/workspace/My-Docker-CI-CD@2/.dotnet
chmod -R 777 /var/jenkins_home/workspace/My-Docker-CI-CD@2

export HOME=/var/jenkins_home/workspace/My-Docker-CI-CD@2
export DOTNET_CLI_HOME=/var/jenkins_home/workspace/My-Docker-CI-CD@2/.dotnet
export NUGET_PACKAGES=/var/jenkins_home/workspace/My-Docker-CI-CD@2/.nuget/packages

dotnet restore
dotnet build --configuration Release
dotnet test --no-build --verbosity normal
'''
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
