pipeline {
    agent any

    environment {
        PLAYBOOK   = 'playbook.yml'
        GIT_BRANCH = 'main'
        DOCKERHUB_USER = credentials('dockerhub-username') // Jenkins credentials ID
        DOCKERHUB_PASS = credentials('dockerhub-password')
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
