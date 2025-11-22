
pipeline{
    agent any
    stages{
        stage('code'){
            steps{
                git branch: 'flm', url: 'https://github.com/ashok898/digital_marketing.git'
            }
        }
        stage('build'){
            steps{
                sh 'docker build -t $acrloginservername/$repo:$tag 2128_tween_agency'
            }
        }
        stage('push'){
            steps{
                script {
                   // This step should not normally be used in your script. Consult the inline help for details.
                    withDockerRegistry(credentialsId: 'acr-credentials', url: 'https://mydockerregistary.azurecr.io') {
                        sh 'docker push $acrloginservername/$repo:$tag '
                   // some block
                          }
                }
            }
        }
            stage('deploy'){
                steps{
                sh 'docker run -itd --name $contname -p $contport:80 $acrloginservername/$repo:$tag'
                }
            }
    }
    
}
