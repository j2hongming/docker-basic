#!/bin/bash

# run in detach mode
docker container run -d --name nginx-background -p 8080:80 nginx

docker ps
docker container pause nginx-background
docker ps

# try with other commands
## interactive
docker container attach nginx-background

docker container exec nginx-background pwd

## information
docker container logs --tail 5 nginx-background

docker container top nginx-background

docker container stats nginx-background

## resource limit
docker container update --cpu-shares 512 --memory 128M nginx-background
docker container update --cpu-shares 512 nginx-background
docker container update --memory 128M nginx-background

## life cycle
docker container stop nginx-background
docker container kill nginx-background
docker container restart nginx-background
docker container rm nginx-background


docker container unpause nginx-background
