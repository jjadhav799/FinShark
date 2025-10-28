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
                    args '-u root -v $WORKSPACE/tmp:/tmp -v $WORKSPACE/.nuget:/root/.nuget'
                }
            }
    steps {
        sh '''
            export HOME=$WORKSPACE
            export DOTNET_CLI_HOME=$WORKSPACE/.dotnet
            export NUGET_PACKAGES=$WORKSPACE/.nuget/packages
            mkdir -p $DOTNET_CLI_HOME $NUGET_PACKAGES
            chmod -R 777 $WORKSPACE
            echo "✅ Environment paths configured:"
            echo "HOME=$HOME"
            echo "DOTNET_CLI_HOME=$DOTNET_CLI_HOME"
            echo "NUGET_PACKAGES=$NUGET_PACKAGES"
            dotnet restore --packages $NUGET_PACKAGES
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
                    mkdir -p $WORKSPACE/tmp $WORKSPACE/.nuget
                    chmod -R 777 $WORKSPACE
                    export HOME=$WORKSPACE
                    export DOTNET_CLI_HOME=$WORKSPACE/.dotnet
                    export NUGET_PACKAGES=$WORKSPACE/.nuget/packages
                    echo "🏗️  Building project safely..."
                    dotnet build --configuration Release --packages $NUGET_PACKAGES
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
