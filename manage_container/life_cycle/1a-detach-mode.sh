#!/bin/bash

# run in detach mode
docker container run -d --name nginx-background -p 8080:80 nginx

# run in forward
docker container run --name nginx-foreground -p 9090:80 nginx

