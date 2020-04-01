pipeline {
		environment {
			registry = "janssenongaigui/capstone:blue"
			registryCredential = 'dockerhub'
			dockerImage = ''
		}
		agent any
        stages {
				stage('Setup') {
                        steps {
                                sh 'make install'
                        }
                }
                stage('Lint') {
                        steps {
                                sh 'make lint'
                        }
                }
                stage('Build Docker Image') {
                        steps {
							script {
								dockerImage = docker.build(registry)
							}
                        }
                }
                stage('Upload Docker Image') {
						steps {
							script {
									docker.withRegistry('', registryCredential ) {
										dockerImage.push()
									}
							}
						}
                }
                stage('Set Cluster Context') {
                        steps {
                                sh 'make setkubectlcontext'
                        }
                }
                stage('Deploy Container') {
                        steps {
                                withAWS(region:'us-west-2',credentials:'aws-cred') {
									sh '''
										sh 'aws --version'
									'''
								}
                        }
                }
        }
}