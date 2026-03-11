pipeline {
    agent any

    environment {
		DOCKERHUB_USER = credentials('dockerhub-id')
        IMAGE_TAG = "${env.BUILD_ID}"
		FULL_IMAGE_NAME = "${DOCKERHUB_USER}/ubuntu:${IMAGE_TAG}"
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
		stage('Security Scan (Trivy)') {
            steps {
                script {
                    // On scanne l'image qui a été créée par le playbook
                    // --exit-code 1 signifie : si tu trouves des vulnérabilités CRITICAL, échoue le build
                    sh """
                    docker run --rm \
                        -v /var/run/docker.sock:/var/run/docker.sock \
                        -v $HOME/trivy-cache:/root/.cache/ \
                        aquasec/trivy image --severity HIGH,CRITICAL --exit-code 1 ${FULL_IMAGE_NAME}
                    """
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
