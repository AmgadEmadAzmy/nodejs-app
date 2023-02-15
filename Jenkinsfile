pipeline {
    agent any

    stages {
        stage('ci') {
            steps {
                // Get some code from a GitHub repository
                
                withCredentials([usernamePassword(credentialsId: 'DockerHub-Cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                
                sh "docker build . -f dockerfile -t ${USERNAME}/amgad-app:v1"
                sh "docker login -u ${USERNAME} -p ${PASSWORD}"
                sh "docker push ${USERNAME}/amgad-app:v1"
                }
                
            }
        }
        
        
    }
}
