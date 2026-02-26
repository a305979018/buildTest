pipeline {
    agent any
    options {
        timestamps()
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
        GRADLE_USER_HOME = "D:\\Jenkins_GradleCache"  // 指定 Gradle 缓存目录
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
                script {
                    bat ".\\build-ci.bat %MODULE% %BUILD_TYPE%"
                    // 或者直接调用 Gradle：
                    // bat "%GRADLE_USER_HOME%\\..\\gradle-8.4\\bin\\gradle.bat ${params.MODULE}:${params.BUILD_TYPE}"
                }
            }
        }
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: '**/build/outputs/**/*.apk, **/build/outputs/**/*.aab, **/outputs/mapping/**', fingerprint: true
            }
        }
    }
    post {
        always {
            echo "Build finished for ${params.MODULE} ${params.BUILD_TYPE}"
        }
        success {
            echo "✅ Build succeeded!"
        }
        failure {
            echo "❌ Build failed!"
        }
    }
}