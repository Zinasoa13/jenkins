pipeline {
    agent any

    environment {
      IMAGE_TAG = "24.04-${env.BUILD_I}"
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
		always {
            // Cette commande permet de récupérer les fichiers CSV dans l'interface Jenkins
            archiveArtifacts artifacts: '*.csv', fingerprint: true
        }
        failure { echo 'Pipeline failed — Check Trivy scan or Ansible logs.' }
        success { cleanWs() }
    }
}