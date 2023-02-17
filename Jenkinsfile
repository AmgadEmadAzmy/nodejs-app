pipeline {
    agent any

    stages {

        stage('CI'){
            steps {

                withCredentials([usernamePassword(credentialsId: 'DockerHub-Cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')])            {

                sh """
                    docker build . -f dockerfile -t amgademad/apps:v1
                    docker login -u ${USERNAME} -p ${PASSWORD}
                    docker push amgademad/app:v$BUILD_NUMBER
                """
                }
              }
        }

        stage('CD'){
            steps {

                withCredentials([file(credentialsId: 'Service-Account-Cred', variable: 'GCLOUD_CREDS')]){
                    sh """
                        gcloud auth activate-service-account --key-file=${GCLOUD_CREDS}
                        gcloud container clusters get-credentials private-cluster --zone us-central1-a --project ace-tracker-375011
                        kubectl apply -n app -f /var/jenkins_home/workspace/ci-cd/deployment.yaml
                    """
                }
            }
 
        }
    }
}
