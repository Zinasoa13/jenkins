pipeline {
    agent any

    environment {
        IMAGE_TAG = "${env.BUILD_ID}"
    }

    stages {
        stage('Ansible : Build, Push and Scan') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-id',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_PASS'
                )]) {
                    // On ne passe plus de variables via ${} pour éviter le warning de sécurité
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
        failure { echo 'Pipeline failed — Check Trivy scan or Ansible logs.' }
        success { cleanWs() }
    }
}