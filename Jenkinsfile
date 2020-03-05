pipeline {

    agent { label 'docker-in-docker-worker' }

    stages {

        stage("Build Docker Image") {
            steps {
                script {
                    docker.build("python-docker-worker:local")
                    sh 'docker ps'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}