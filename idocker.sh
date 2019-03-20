#!/bin/bash
#
# Automatic Install Docker & Docker-compose [Ubuntu or CentOs] 
# 
# Tested on Ubuntu 16.04 & CentOs 7
# @Author : Rafsanzani Suhada
# @Github : github.com/suhada99 

UbuntuIdocker(){
	# Add Repository
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add > /dev/null
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	# Update 
	apt-get update
	# Install docker-ce
	apt-get install docker-ce
	# Install PIP
	apt install python-pip
	# Install docker-compose 
	pip install docker-compose
	echo ""
	echo "[ ! ] Docker Version [ ! ]"
	docker -v
	echo ""
	echo "[ + ] Add your username to the docker group [ + ]"
	echo "$ sudo usermod -aG docker ${USER}"
}

CentOsIdocker(){
	# Install needed packages
	yum install -y yum-utils device-mapper-persistent-data lvm2
	# Configure the docker-ce repo:
	yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
	# Install docker-ce
	yum install docker-ce
	# Set start Automatic 
	systemctl enable docker.service
	# Start docker service
	systemctl start docker.service
	# Install needed packages
	yum install epel-release
	# Install PIP
	yum install -y python-pip
	# Install docker-compose
	pip install docker-compose
	echo ""
	echo "[ ! ] Docker Version [ ! ]"
	docker -v
	echo ""
	echo "[ + ] Add your username to the docker group [ + ]"
	echo "$ sudo usermod -aG docker ${USER}"

}

Validasi(){
	# Validasi Operasi Sistem
	ceKOs=$(cat /etc/*release)
	if [[ $ceKOs =~ 'ubuntu' ]]; then
		# Jika OS Ubuntu
		echo " [ ! ] Your system operation Ubuntu [ ! ]"
		UbuntuIdocker
	elif [[ $ceKOs =~ 'centos' ]]; then
		# Jika OS CentOs 
		echo " [ ! ] Your system operation CentOs [ ! ]"
		CentOsIdocker
	fi
}

# Membutuhkan akses root
ceKRoot=$(whoami)
if [[ $ceKRoot =~ 'root' ]]; then
	Validasi
else
	echo "[ X ] Requires root for running tools [ X ]"
fi
