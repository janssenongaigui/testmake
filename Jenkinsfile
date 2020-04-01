pipeline {
	agent any
	stages {
		stage('Lint') {
			steps {
				sh 'make lint'
			}
		}
		stage('Build Docker Image') {
			steps {
				sh 'make builddockerimage'
			}
		}
		stage('Upload Docker Image') {
			steps {
				sh 'make uploaddockerimage'
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