#!/bin/bash

# run a container
docker container run -d --name nginx-background -p 8080:80 nginx

watch docker container top nginx-background

# try it
# docker container exec nginx-background /bin/bash -c "sleep 5 && pwd && ls -la"
