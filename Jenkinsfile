pipeline {
    agent any

    environment {
        APP_NAME = "chronoface"
        APP_DIR = "/opt/projects/${APP_NAME}"

        DOCKER_HOST = "unix:///var/run/docker.sock"

        GIT_COMMIT_SHORT = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
        BUILD_TIMESTAMP = sh(script: "date +%Y%m%d_%H%M%S", returnStdout: true).trim()
    }

    options {
        timeout(time: 10, unit: 'MINUTES')
        disableConcurrentBuilds()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh 'echo "Building commit: ${GIT_COMMIT_SHORT} at ${BUILD_TIMESTAMP}"'
            }
        }

        stage('Build Static Files') {
            steps {
                sh 'echo "Building static files..."'
            }
        }

        stage('Prepare Deployment') {
            steps {
                sh "mkdir -p ${env.APP_DIR}/html ${env.APP_DIR}/nginx/conf.d"

                sh "cp -r web/html/* ${env.APP_DIR}/html/"
                sh "cp -r web/nginx/conf.d/* ${env.APP_DIR}/nginx/conf.d/"
                sh "cp web/docker-compose.yml ${env.APP_DIR}/"

                sh "echo 'BUILD_ID=${env.BUILD_ID}\nBUILD_NUMBER=${env.BUILD_NUMBER}\nGIT_COMMIT=${env.GIT_COMMIT_SHORT}\nBUILD_TIMESTAMP=${env.BUILD_TIMESTAMP}' > ${env.APP_DIR}/version.txt"
            }
        }

        stage('Deploy') {
            steps {
                dir("${env.APP_DIR}") {
                    sh 'docker-compose down || true'
                    sh 'docker-compose up -d'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh "docker ps | grep ${env.APP_NAME}-nginx"
                sh 'sleep 5'
                sh 'curl -s --head --fail http://localhost || true'
            }
        }

        stage('Cleanup') {
            steps {
                sh '''
                docker image prune -a -f --filter "until=24h"
                '''
            }
        }
    }

    post {
        success {
            echo 'Deployment completed successfully!'
        }
        failure {
            echo 'Deployment failed! Check the logs for details.'
        }
        always {
            cleanWs()
        }
    }
}