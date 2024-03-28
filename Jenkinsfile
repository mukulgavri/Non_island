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
                        writeFile file: 'secrets.json', text: groovy.json.JsonOutput.toJson(secretJson)
                    }

                    def currentDir = pwd()
                    echo "Secret file created in: ${currentDir}"
                }
            }
        }

        stage('JenkinsSecretFile') {
            steps {
                script {
                    withCredentials([
                        file(credentialsId: 'sceret_file_jenkins',
                            variable: 'secretFile')
                    ]) {
                        def secretContent = readFile "${secretFile}"
                        writeFile file: "${env.WORKSPACE}/Jenkinssecrets.json", text: secretContent
                    }
                }
            }
        }

        stage('BuildAndDeploy') {
            steps {
                script {
                    // Read secrets.json
                    def secretsJson = readJSON file: "${env.WORKSPACE}/secrets.json"
                    echo "Username from secrets.json: ${secretsJson.superuser_username}"
                    echo "Password from secrets.json: ${secretsJson.superuser_password}"

                    // Read Jenkinssecrets.json
                    def jenkinsSecretsJson = readJSON file: "${env.WORKSPACE}/Jenkinssecrets.json"
                    echo "Secret content from Jenkinssecrets.json: ${jenkinsSecretsJson.secret_content}"

                    sh "bash abc.sh"
                }
            }
        }
    }
}
