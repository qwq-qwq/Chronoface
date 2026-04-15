pipeline {
    agent any

    environment {
        APP_NAME   = "chronoface"
        APP_DOMAIN = "chronoface.perek.rest"
        SITES_ROOT = "/opt/static-sites"
        TARGET_DIR = "/opt/static-sites/chronoface.perek.rest"
        SRC_DIR    = "web/html"
        GIT_COMMIT_SHORT = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
    }

    options {
        timeout(time: 5, unit: 'MINUTES')
        disableConcurrentBuilds()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    set -eu
                    mkdir -p "${SITES_ROOT}"
                    STAGING="${SITES_ROOT}/.${APP_NAME}.staging.$$"
                    rsync -a --delete "${SRC_DIR}/" "${STAGING}/"
                    rm -rf "${TARGET_DIR}.old" || true
                    if [ -d "${TARGET_DIR}" ]; then mv "${TARGET_DIR}" "${TARGET_DIR}.old"; fi
                    mv "${STAGING}" "${TARGET_DIR}"
                    rm -rf "${TARGET_DIR}.old" || true
                    echo "${GIT_COMMIT_SHORT}" > "${TARGET_DIR}/.version"
                '''
            }
        }

        stage('Verify') {
            steps {
                sh '''
                    set -eu
                    curl -sSf -H "Host: ${APP_DOMAIN}" http://static-hub/ -o /dev/null
                '''
            }
        }
    }

    post {
        success { echo "Deployed ${APP_DOMAIN} (${GIT_COMMIT_SHORT})" }
        failure { echo "Deploy of ${APP_DOMAIN} failed" }
        always  { cleanWs() }
    }
}