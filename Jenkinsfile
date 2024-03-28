pipeline {
    agent any

    stages {
        stage('usernamePassword') {
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
                    writeFile file: 'secrets.json', text: groovy.json.JsonOutput.toJson(secretJson)
                }

                def currentDir = pwd()
                echo "Secret file created in: ${currentDir}"
            }
        }

        stage('JenkinsSecretFile') {
            script {
                withCredentials([
                    file(credentialsId: 'secret_file_jenkins',
                        variable: 'secretFile')
                ]) {
                    def secretContent = readFile "${secretFile}"
                    def fileSecret = [
                        secret_content: secretContent
                    ]
                    writeFile file: "${env.WORKSPACE}/Jenkinssecrets.json", text: groovy.json.JsonOutput.toJson(fileSecret)
                }
            }
        }

        stage('BuildAndDeploy') {
            script {
                sh "bash abc.sh"
            }
        }
    }
}

