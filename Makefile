###################
## GREEN VERSION ##
###################

setupproj:
	sudo mkdir ~/myproj
	cd ~/myproj

getdocker:
	sudo apt-get update
	sudo apt-get install -y \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository \
		"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
		bionic \
		stable"
	sudo apt-get update
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io

getjenkins:
	sudo apt-get update
	sudo apt install -y default-jdk
	wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
	sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
		/etc/apt/sources.list.d/jenkins.list'
	sudo apt-get update
	sudo apt-get install -y jenkins # 	plugins to install: blue ocean, pipeline aws

getpip:
	sudo apt-get update
	sudo apt install -y python-pip

getawscli:
	sudo apt-get update
	sudo apt install -y unzip
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install

geteksctl:
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/0.16.0-rc.1/eksctl_Linux_amd64.tar.gz" | tar xz -C .
	sudo mv eksctl /usr/local/bin

getkubectl:
	curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/kubectl
	sudo chmod 755 kubectl
	sudo mv kubectl /usr/local/bin

getawsiamauthenticator:
	curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator
	sudo chmod 755 aws-iam-authenticator
	sudo mv aws-iam-authenticator /usr/local/bin

createcluster:
	eksctl create cluster \
		--name capstonecluster \
		--region us-west-2 \
		--nodegroup-name standard-workers \
		--node-type t3.medium \
		--nodes 3 \
		--nodes-min 1 \
		--nodes-max 4 \
		--managed

updatekubeconfig:
	aws eks --region us-west-2 update-kubeconfig --name capstonecluster

getlint:
	sudo apt-get update
	sudo apt install -y pylint
	wget -O hadolint "https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64"
	sudo chmod 755 hadolint
	sudo mv hadolint /usr/local/bin
	sudo apt install -y tidy

install:
	pip install -r requirements.txt

lint:
	pylint --disable=R,C,W1203 app.py
	hadolint Dockerfile
	tidy -q -e static/index.html

builddockerimage:
	# 	Green version
	sudo docker build --tag=app:green .

uploaddockerimage:
	# 	Green version
	sudo docker tag app:green janssenongaigui/capstone:green
	sudo docker push janssenongaigui/capstone:green

setkubectlcontext:
	kubectl config use-context arn:aws:eks:us-west-2:180552701451:cluster/capstonecluster

createreplicationcontroller:
	kubectl apply -f ./green-controller.json

createservice:
	kubectl apply -f ./green-service.json


# install:
# 	pip install --upgrade pip &&\
# 		pip install -r requirements.txt

# test:
# 	#python -m pytest -vv --cov=myrepolib tests/*.py
# 	#python -m pytest --nbval notebook.ipynb

# validate-circleci:
# 	# See https://circleci.com/docs/2.0/local-cli/#processing-a-config
# 	circleci config process .circleci/config.yml

# run-circleci-local:
# 	# See https://circleci.com/docs/2.0/local-cli/#running-a-job
# 	circleci local execute

# lint:
# 	hadolint demos/flask-sklearn/Dockerfile
# 	pylint --disable=R,C,W1203 demos/**/**.py

# all: install lint test
