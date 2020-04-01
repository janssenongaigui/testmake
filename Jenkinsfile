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
							dockerImage = docker.build registry
                        }
                }
                stage('Upload Docker Image') {
                        steps {
                                docker.withRegistry('', registryCredential ) {
									dockerImage.push()
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
                                sh '''
                                        make createreplicationcontroller
                                        make createservice
                                        make obtainurl
                                '''
                        }
                }
        }
}