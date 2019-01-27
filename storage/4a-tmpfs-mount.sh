#!/bin/bash

docker run -d -it --name nginx1 --mount type=tmpfs,destination=/app,tmpfs-size=2097152 nginx

docker container inspect nginx1 | grep -A 8 Mounts
docker exec nginx1 df -h

docker exec nginx1 fallocate -l 2M /app/2Mfile
docker exec nginx1 ls -la /app
docker exec nginx1 du -h /app/2Mfile

docker exec nginx1 fallocate -l 3M /app/3Mfile

docker stop nginx1
docker rm nginx1
