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
                sh '. venv/bin/activate && pytest test_app.py'
            }
        }

        stage('Deploy') {
            steps {
                script {
                    def image = "kiyeon24/myapp:${env.BUILD_NUMBER}"
                    sh """
                        docker build -t ${image} .
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker push ${image}
                    """
                }
            }
        }
    }
}
