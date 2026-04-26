pipeline {
    agent any

    environment {
        PATH = "C:\\src\\flutter\\bin;C:\\nvm4w\\nodejs;C:\\Windows\\System32;${env.PATH}"
    }



    stages {

        stage('Checkout Code') {
            steps {
                script {
                    def branch = env.BRANCH_NAME ?: "main"
                    echo "Checking out branch: ${branch}"
                    git branch: branch, url: 'https://github.com/sivabharathi269/widgetcicd.git'
                }
            }
        }

        stage('Detect Branch') {
            steps {
                echo "Running on branch: ${env.BRANCH_NAME}"
            }
        }

        // ✅ ONLY run tests for PR (non-main branches)
        stage('Run Tests') {
            when {
                expression {
                    return env.BRANCH_NAME != "main"
                }
            }
            steps {
                bat 'flutter pub get'
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