#!/bin/bash

# run a container
docker container run -d --name nginx-background -p 8080:80 nginx

# show last 5 lines
docker container logs --tail 5 nginx-background

# follow the stream
docker container logs -f nginx-background

