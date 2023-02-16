pipeline {
    agent any

    stages {

        stage('CI'){
            steps {

                withCredentials([usernamePassword(credentialsId: 'DockerHub-Cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')])            {

                sh """
                    cd backend-app
                    docker build . -t amgademad/app:v$BUILD_NUMBER
                    docker login -u ${USERNAME} -p ${PASSWORD}
                    docker push amgademad/app:v$BUILD_NUMBER
                    cd ..
                """
                }
              }
        }

        stage('CD'){
            steps {

                withCredentials([file(credentialsId: 'Service-Account-Cred', variable: 'GCLOUD_CREDS')]){
                    sh """
                        gcloud auth activate-service-account --key-file=${GCLOUD_CREDS}
                        apt-get install google-cloud-sdk-app-engine-java kubectl -y
                        gcloud container clusters get-credentials private-cluster --zone us-central1-a --project ace-tracker-375011
                        sed -i 's/tag/${BUILD_NUMBER}/g' deployment.yaml
                        kubectl apply -f ./deployment.yaml
                    """
                }
            }
 
        }
    }
}
