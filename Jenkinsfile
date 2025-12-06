pipeline {
  agent {
    docker {
      image 'node:20'
      args '-u root:root'
    }
  }
  options {
    timeout(time: 60, unit: 'MINUTES')
    ansiColor('xterm')
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }
  environment {
    NODE_ENV = 'production'
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Install') {
      steps {
        sh 'npm ci --prefer-offline --no-audit --progress=false'
      }
    }
    stage('Lint') {
      steps {
        sh 'npm run lint'
      }
    }
    stage('Build') {
      steps {
        sh 'npm run build'
      }
    }
    stage('Archive') {
      steps {
        archiveArtifacts artifacts: 'dist/**', allowEmptyArchive: true
      }
    }
  }
  post {
    always {
      cleanWs()
    }
    success {
      echo 'Build succeeded'
    }
    failure {
      echo 'Build failed'
    }
  }
}
