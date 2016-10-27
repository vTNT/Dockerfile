#!/bin/bash

docker rm $(docker ps -a | awk '/Exited.*/ { print $1}')
docker rmi $(docker images | awk '/<none>/ { print $3 }')
