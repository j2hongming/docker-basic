#!/bin/bash

docker volume ls

# run container without a prepared volume
docker run -d --name nginx1 --mount source=ng-vol,target=/app nginx
docker inspect nginx1

# check the created volume
docker volume ls
docker volume inspect ng-vol

# clean up
docker stop nginx1
docker rm nginx1
docker volume rm ng-vol
