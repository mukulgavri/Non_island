pipeline {
    agent any

    stages {
        stage('usernamePassword') {
            steps {
                script {
                    withCredentials([
                        usernamePassword(credentialsId: 'es_dry_run_cluster_creds',
                            usernameVariable: 'username',
                            passwordVariable: 'password')
                    ]) {
                        def secretJson = [
                            superuser_username: username,
                            superuser_password: password
                        ]
                        
                        echo "Workspace Path: ${env.WORKSPACE}"
                        writeFile file: "${env.WORKSPACE}/secrets.json", text: groovy.json.JsonOutput.toJson(secretJson)
                        sh "chmod 777 ${env.WORKSPACE}/secrets.json"
                    }
                }
            }
        }
        stage('BuildAndDeploy') {
            steps {
                sh "bash abc.sh -f ${env.WORKSPACE}/secrets.json"
            }
        }
    }
}

