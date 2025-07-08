pipeline {
    agent any
    stages {
        stage('Verify shell environment') {
            steps {
                script {
                    def jobName = env.JOB_NAME ?: 'Unknown Job'
                    def buildNumber = env.BUILD_NUMBER ?: 'Unknown Build Number'
                    def buildUrl = env.BUILD_URL ?: 'Unknown Build URL'
                    echo "Job Name: $jobName"
                    echo "Build Number: $buildNumber"
                    echo "Build URL: $buildUrl"
                    sh 'docker --version'
                    sh 'node --version'
                }
            }
        }
       
        stage('Checkout git repository') {
            steps {
                script {
                    def gitUrl = 'https://github.com/keshav4u/nest-app-jenkiens-build.git'
                    checkout([$class: 'GitSCM', 
                        branches: [[name: '*/main']],
                        userRemoteConfigs: [[url: gitUrl]],
                        extensions: [[$class: 'CleanBeforeCheckout'], 
                                      [$class: 'CloneOption', noTags: false, shallow: true, depth: 1]]
                    ])
                    echo "Checked out repository: $gitUrl"
                }
            }
        }
        stage('Build application') {
            steps {
                sh 'chmod +x ./ci/build.sh && ./ci/build.sh'
            }
        }

        stage('Publish Docker image') {
            steps {
                script {
                     def jobName = env.JOB_NAME ?: 'Unknown Job'
                    def buildNumber = env.BUILD_NUMBER ?: 'Unknown Build Number'
                    
                    echo "Publishing Docker image for job: $jobName, build number: $buildNumber"
                    withCredentials([usernamePassword(credentialsId: 'e5afe58c-7da8-40a1-ac2f-b011849e83b3', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USER')]) {
                        sh 'chmod +x ./ci/publish.sh && ./ci/publish.sh'
                        sh './ci/publish.sh $buildNumber'
                        
                    }
                    echo "Docker image published successfully for job: $jobName, build number: $buildNumber"
                }
            }
        }
    }
}