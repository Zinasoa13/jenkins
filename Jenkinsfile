pipeline {
    agent any

    environment {
        IMAGE_TAG = "${env.BUILD_ID}"
    }

    stages {
        stage('Pull and Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_PASS'
                )]) {
                    sh 'ansible-playbook playbook.yml'
                }
            }
        }
    }

    post {
        failure { echo 'Pipeline failed — check the logs.' }
        success { cleanWs() }
    }
}
