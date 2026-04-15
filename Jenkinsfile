pipeline {
    agent any

    environment {
        APP_NAME    = "chronoface"
        BUCKET      = "chronoface"
        SRC_DIR     = "web/html"
        S3_ENDPOINT = "https://s3.perek.rest"
        S3_REGION   = "garage"
        // Garage принимает только path-style (bucket в пути, не в поддомене Host),
        // иначе AWS SDK шлёт запрос на <bucket>.s3.perek.rest, которого нет в DNS/TLS.
        AWS_FORCE_PATH_STYLE_ACCESS = "true"
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
                withAWS(credentials: 'garage-s3',
                        endpointUrl: env.S3_ENDPOINT,
                        region: env.S3_REGION) {
                    s3Delete(bucket: env.BUCKET, path: '')
                    s3Upload(bucket: env.BUCKET,
                             workingDir: env.SRC_DIR,
                             includePathPattern: '**/*')
                    writeFile file: '.version', text: env.GIT_COMMIT_SHORT
                    s3Upload(bucket: env.BUCKET, file: '.version')
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