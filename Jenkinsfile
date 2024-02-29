pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "spore2/swe645a2:${env.BUILD_ID}"
        KUBECONFIG_CREDENTIALS_ID = 'myKubeconfigID'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("$DOCKER_IMAGE")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: '3102e9fa-f1b8-4bf1-82f8-99a0682f75b2', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                        sh "docker push $DOCKER_IMAGE"
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: "$KUBECONFIG_CREDENTIALS_ID", variable: 'KUBECONFIG')]) {
                    sh '''
                        kubectl config use-context ass2
                        kubectl set image deployment/ass2 swe645-2=$DOCKER_IMAGE
                    '''
                }
            }
        }
    }
}
