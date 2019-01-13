#!/bin/bash

# run a container
docker container run -d --name nginx-background -p 8080:80 nginx

# useful if you need to connect to the process your container is running
docker container attach nginx-background

# 
docker container attach --sig-proxy=false nginx-background

