#!/bin/bash

# run a container which creates a new volume
docker volume rm ng-vol
docker run -d --name nginx1 --mount source=ng-vol,target=/usr/share/nginx/html nginx
docker exec nginx1 ls -la /usr/share/nginx/html
docker exec nginx1 ls -la /app
docker exec nginx1 touch /usr/share/nginx/html/abc.html

# /app not exist
docker run -d --name nginx2 --mount source=ng-vol,target=/app nginx
docker exec nginx2 ls -la /app

# mount a non-empty volume into a directory in the container in which some files or directories exist, 
# these files or directories are obscured by the mount
docker run -d --name nginx3 --mount source=ng-vol,target=/usr/share/nginx/html nginx
docker exec nginx3 ls -la /usr/share/nginx/html

# A given volume can be mounted into multiple containers simultaneously

docker stop nginx1 nginx2 nginx3
docker rm nginx1 nginx2 nginx3
docker volume rm ng-vol
