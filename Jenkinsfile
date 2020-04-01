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
				stage('AWS Setup') {
                        steps {
                                withAWS(region:'us-west-2',credentials:'aws-cred') {
									sh 'aws eks --region us-west-2 update-kubeconfig --name capstonecluster'
									sh 'kubectl config use-context arn:aws:eks:us-west-2:180552701451:cluster/capstonecluster'
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
										make setkubectlcontext
										make createreplicationcontroller
										make createservice
									'''
								}
                        }
                }
        }
}