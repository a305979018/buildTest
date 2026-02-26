pipeline {
    agent any
    options {
        timestamps()
        ansiColor('xterm')
    }
    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'main', description: 'Git branch to build')
        choice(name: 'BUILD_TYPE', choices: ['Debug','Release'], description: 'Select build type')
        string(name: 'MODULE', defaultValue: 'GP_maong', description: 'Gradle module to build')
        string(name: 'REPO_URL', defaultValue: 'https://github.com/a305979018/buildTest.git', description: 'Git repository URL')
    }
    environment {
        ANDROID_HOME = "E:\\AndroidSDK"
        JAVA_HOME = "D:\\JDK17"
        PATH = "${JAVA_HOME}\\bin;${ANDROID_HOME}\\platform-tools;${env.PATH}"
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: "${params.BRANCH_NAME}"]],
                    userRemoteConfigs: [[url: "${params.REPO_URL}"]]
                ])
            }
        }
        stage('Build') {
            steps {
                bat ".\\gradlew.bat :%MODULE%:clean :%MODULE%:assemble%BUILD_TYPE% -x test"
            }
        }
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'app/build/outputs/**/*.apk, app/build/outputs/**/*.aab, **/outputs/mapping/**', fingerprint: true
            }
        }
    }
    post {
        always {
            echo "Build finished for %MODULE% %BUILD_TYPE%"
        }
    }
}
