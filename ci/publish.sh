#!/bin/bash
docker build -t keshav4u/nest-app-jenkiens-build:$1 -f ../Dockerfile .

if [ -z ${DOCKER_HUB_USER+x} ]
 then
    echo "Skipping docker push as DOCKER_HUB_USER is not set"
 else
    echo "Pushing image to Docker Hub"
    docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_PASSWORD
fi 
docker push keshav4u/nest-app-jenkiens-build:$1