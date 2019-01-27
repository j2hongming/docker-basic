#!/bin/bash

# run a container
docker container run -d --name nginx-background -p 8080:80 nginx

docker exec nginx-background touch test.txt

docker container diff nginx-background

docker stop nginx-background
docker rm nginx-background
