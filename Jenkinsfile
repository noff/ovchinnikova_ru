import groovy.json.JsonOutput
SUCCESS_STAGE = 'Build'
STEPS = 'Build Testing Deploy'
def stepPublisher(step, style) {
  rabbitMQPublisher(rabbitName: 'rabbit', exchange: '', routingKey: 'notification', conversion: false,
    data: JsonOutput.toJson([type: "deploy", project: JOB_NAME, style: style, step: step, message: GIT_COMMIT_MSG, commit: GIT_COMMIT, url: COMMIT_URL, author: GIT_COMMIT_AUTHOR, console: "${BUILD_URL}console", steps: STEPS, channel: 'channel:name:apps']))
}

pipeline {
  agent any

  stages {

    stage('Build') {
      steps {
        script {
          env.GIT_COMMIT_MSG = sh (script: 'git log -1 --pretty=%B ${GIT_COMMIT}', returnStdout: true).trim()
          env.GIT_COMMIT_AUTHOR = sh (script: 'git log -1 --pretty=%an ${GIT_COMMIT}', returnStdout: true).trim()
          env.COMMIT_URL = "https://github.com/noff/ovchinnikova_ru/commits/${GIT_COMMIT}"
        }
    
        sh 'bin/prepare_for_jenkins'
      }
    }

    stage('Testing') {
      steps {
        script {
          SUCCESS_STAGE = 'Testing'
        }
        stepPublisher(SUCCESS_STAGE, 'SECONDARY')

        sh 'bin/testing'
      }
    }

    stage('Deploy') {
      steps {
        script {
          SUCCESS_STAGE = 'Deploy'
        }
        stepPublisher(SUCCESS_STAGE, 'SECONDARY')

        sh "bin/deploy ${env.GIT_BRANCH}"
      }
    }
  }

  post {
    failure {
      stepPublisher(SUCCESS_STAGE, 'ERROR')
    }

    aborted {
      stepPublisher(SUCCESS_STAGE, 'WARNING')
    }

    success {
      stepPublisher(SUCCESS_STAGE, 'SUCCESS')
    }
  }
}
