#!/bin/bash

set -e
DATA=/var/lib/jenkins

mkdir -p $DATA/plugins

exec java -jar /opt/jenkins.war
