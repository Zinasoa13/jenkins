pipeline {
    agent any

    environment {
        IMAGE_TAG = "${env.BUILD_ID}"
    }

    stages {
        stage('Pull and Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-id',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_PASS'
                )]) {
                    sh 'ansible-playbook playbook.yml'
                }
            }
        }
		stage('Verify Python') {
            steps {
                sh 'python3 --version || echo "Python n\'est pas installé"'
            }
        }
    }

    post {
        failure { echo 'Pipeline failed — check the logs.' }
        success { cleanWs() }
    }
}
