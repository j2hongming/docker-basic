#!/bin/bash

docker volume ls

# prepare a volume
docker volume create ng-vol
docker volume ls
docker volume inspect ng-vol

# run container with prepared volume
docker run -d --name nginx1 --mount source=ng-vol,target=/app nginx
docker inspect nginx1

# clean up
docker stop nginx1
docker rm nginx1
docker volume rm ng-vol
