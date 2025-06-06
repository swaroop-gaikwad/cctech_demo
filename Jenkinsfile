pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"  
        AWS_ECR_URL = "12345Demo_CCTech.ecr.ap-south-1.amazonaws.com"
        REPO_NAME = "CCTech-app"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/swaroop-gaikwad/cctech_demo.git'
            }
        }

        stage('Login to AWS ECR') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-ecr-credentials']]) {
                    sh 'aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ECR_URL'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $AWS_ECR_URL/$REPO_NAME:$IMAGE_TAG .'
            }
        }

        stage('Push to ECR') {
            steps {
                sh 'docker push $AWS_ECR_URL/$REPO_NAME:$IMAGE_TAG'
            }
        }

    }
}
