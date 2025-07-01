pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/jkyand24/myJenkinsNew.git'
            }
        }

        stage('Install') {
            steps {
                sh 'python3 -m venv venv && . venv/bin/activate && pip install -r requirements.txt'
            }
        }

        stage('Test') {
            steps {
                sh """
                    docker build -t test-image --target=test .
                    docker run --rm test-image
                """
            }
        }

        stage('Build & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh """
                        docker build -t ${DOCKER_IMAGE} .
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker push ${DOCKER_IMAGE}
                    """
                }
            }
        }
    }
}
