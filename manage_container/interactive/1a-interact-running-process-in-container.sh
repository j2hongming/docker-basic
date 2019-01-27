#!/bin/bash

# run a container
docker container run -d --name nginx-background -p 8080:80 nginx
docker container ls

# useful if you need to connect to the process your container is running
docker container attach nginx-background

# ctrl-p, ctrl-q vs ctrl-c
