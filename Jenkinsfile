pipeline {
    agent any

    environment {
        PATH = "C:\\src\\flutter\\bin;C:\\nvm4w\\nodejs;C:\\Windows\\System32;${env.PATH}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                script {
                    echo "Branch: ${env.BRANCH_NAME}"
                    echo "PR ID: ${env.CHANGE_ID}"

                    // Checkout automatically based on PR/branch
                    checkout scm
                }
            }
        }

        stage('Install Dependencies') {
            when {
                changeRequest()
            }
            steps {
                bat 'flutter pub get'
            }
        }

        stage('Run Tests') {
            when {
                changeRequest()
            }
            steps {
                bat 'flutter test'
            }
        }
    }

    post {
        success {
            echo "✅ PR Tests Passed"
        }
        failure {
            echo "❌ PR Tests Failed"
        }
    }
}