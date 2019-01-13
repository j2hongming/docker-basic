#!/bin/bash

# run a container
docker container run -d --name nginx-background -p 8080:80 nginx

# show current folder in container
docker container exec nginx-background pwd

# multiple commands
# docker container exec nginx-background pwd && ls -la
docker container exec nginx-background /bin/bash -c "pwd && ls -la“
