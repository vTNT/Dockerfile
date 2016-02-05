#!/bin/bash
#usage: ansible-galaxy install -r requirements.yml --force

/usr/bin/docker build -t="registry.dkhs.com/jenkins-ansible" .

