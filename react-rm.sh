#!/bin/sh

docker rm -f `docker ps -a | grep react | awk '{print $1}'`  
docker rmi `docker images | grep react | awk '{print $3}'`  

rm -rf bower_components node_modules ssl/ tmp/ vendor package-lock.json yarn-error.log yarn.lock
