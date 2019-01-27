#!/bin/bash

docker container run -d -e TZ=America/Los_Angeles --name nginx-background -p 8080:80 nginx
docker exec nginx-background date
date


docker container logs -t -f nginx-background
docker container logs --since 2019-01-25T13:00 nginx-background
docker container logs --since 2019-01-25T13:00 -t nginx-background

