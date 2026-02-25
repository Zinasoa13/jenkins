pipeline {
    agent any

    environment {
        PLAYBOOK   = 'playbook.yml'
        GIT_BRANCH = 'main'
    }

    triggers {
        cron('H 0 * * *')  // Optional
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
	stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_PASS'
                )]) {
                    sh 'echo Logging into Docker Hub'
                    sh 'docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASS'
                }
            }
        }

        stage('Run Playbook') {
            steps {
                sh 'ansible-playbook ${PLAYBOOK}'
            }
        }
    }

    post {
        success {
            echo "SUCCESS: Playbook executed successfully."
        }
        failure {
            echo "ERROR:  Pipeline failed — check the logs."
        }
        always {
            cleanWs()
        }
    }
}
