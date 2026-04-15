pipeline {
    agent any

    environment {
        APP_NAME    = "chronoface"
        BUCKET      = "chronoface"
        SRC_DIR     = "web/html"
        S3_ENDPOINT = "https://s3.perek.rest"
        AWS_DEFAULT_REGION = "garage"
        GIT_COMMIT_SHORT = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
    }

    options {
        timeout(time: 5, unit: 'MINUTES')
        disableConcurrentBuilds()
    }

    stages {
        stage('Checkout') {
            steps { checkout scm }
        }

        stage('Deploy') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'garage-s3',
                                                  usernameVariable: 'AWS_ACCESS_KEY_ID',
                                                  passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh '''
                        echo "$GIT_COMMIT_SHORT" > "$SRC_DIR/.version"
                        aws --endpoint-url "$S3_ENDPOINT" s3 sync "$SRC_DIR/" "s3://$BUCKET/" --delete
                    '''
                }
            }
        }

        stage('Verify') {
            steps {
                sh 'curl -sSf "https://${APP_NAME}.perek.rest/" -o /dev/null'
            }
        }
    }

    post {
        success { echo "Deployed ${APP_NAME}.perek.rest (${GIT_COMMIT_SHORT})" }
        failure { echo "Deploy of ${APP_NAME}.perek.rest failed" }
        always  { cleanWs() }
    }
}