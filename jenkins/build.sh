#!/bin/bash
#usage: ansible-galaxy install -r requirements.yml --force

#Extensible Choice Parameter plugin
#apt-add-repository ppa:ansible/ansible
#apt-get install -y ansible

/usr/bin/docker build -t="registry.dkhs.com/jenkins-ansible" .

