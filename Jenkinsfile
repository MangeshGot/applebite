pipeline {
    agent any

    tools {
        nodejs 'NodeJS_25.2.1'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scmGit(
                    branches: [[name: 'main']], // Or your target branch, e.g., 'feature/my-branch'
                    userRemoteConfigs: [[url: 'https://github.com/MangeshGot/applebite', credentialsId: 'github-credentials']] // Replace with your repo URL and credentials
                )
            }
        }
        stage('Build app') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = "applebite"
                    sh "docker build -t mangeshgot/${imageName}:${env.BUILD_NUMBER} ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    def imageName = "applebite"
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
                        sh "echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin"
                        // sh " docker tag "${imageName}:${env.BUILD_NUMBER}" "mangeshgot/${imageName}:${env.BUILD_NUMBER}" "
                        sh "docker push mangeshgot/${imageName}:${env.BUILD_NUMBER}"
                    }
                }
            }
        }
    }
}