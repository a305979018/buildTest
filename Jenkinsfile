pipeline {
    agent any
    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'main', description: 'Git branch to build')
        choice(name: 'BUILD_TYPE', choices: ['Debug','Release'], description: 'Select build type')
    }
    environment {
        ANDROID_HOME = "E:\\AndroidSDK"
        JAVA_HOME = "D:\\JDK17"
        PATH = "${JAVA_HOME}\\bin;${ANDROID_HOME}\\platform-tools;${env.PATH}"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: "${params.BRANCH_NAME}",
                    url: 'git@github.com:你的用户名/你的仓库.git',
                    credentialsId: 'jenkins-github-ssh'
            }
        }
        stage('Build APK') {
            steps {
                bat "gradlew assemble${params.BUILD_TYPE}"
            }
        }
        stage('Archive APK') {
            steps {
                archiveArtifacts artifacts: '**/build/outputs/**/*.apk', fingerprint: true
            }
        }
    }
}