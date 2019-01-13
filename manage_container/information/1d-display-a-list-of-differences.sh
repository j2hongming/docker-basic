#!/bin/bash

# run a container
docker container run -d --name nginx-background -p 8080:80 nginx

docker container diff nginx-background

