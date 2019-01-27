#!/bin/bash

# run a container
docker container run -d --name nginx-background -p 8080:80 nginx
docker container ls

docker container attach --sig-proxy=false nginx-background
# use ctrl-c
