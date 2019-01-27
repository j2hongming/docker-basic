#!/bin/bash

docker container create --name nginx-background -p 8080:80 nginx
docker ps -a --filter name=nginx-background

docker container start nginx-background
sleep 3
docker ps --filter name=nginx-background

docker stop nginx-background
docker rm nginx-background

