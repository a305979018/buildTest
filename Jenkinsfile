pipeline {
    agent any
    options {
        timestamps()   // 控制台显示时间戳
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
        // 如果你想使用本地 Gradle 的完整路径，也可以加：
        GRADLE_HOME = "D:\\Gradle\\gradle-8.4"
    }
    stages {
        stage('Checkout') {
            steps {
                // 拉取指定分支
                checkout([$class: 'GitSCM',
                    branches: [[name: "${params.BRANCH_NAME}"]],
                    userRemoteConfigs: [[url: "${params.REPO_URL}"]]
                ])
            }
        }

        stage('Build') {
            steps {
                script {
                    // Windows 下调用你本地的 build-ci.bat
                    bat ".\\build-ci.bat %MODULE% %BUILD_TYPE%"
                    
                    // 如果你想直接调用 Gradle 而不通过 bat 文件：
                    // bat "%GRADLE_HOME%\\bin\\gradle.bat ${params.MODULE}:${params.BUILD_TYPE}"
                }
            }
        }

        stage('Archive') {
            steps {
                // 打包产物归档
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