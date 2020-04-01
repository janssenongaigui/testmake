setupenv:
	sudo mkdir ~/myenv
	cd ~/

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
