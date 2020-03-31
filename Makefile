installdocker:
	sudo apt-get update
	sudo apt-get install \
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
	sudo apt-get install docker-ce docker-ce-cli containerd.io


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
