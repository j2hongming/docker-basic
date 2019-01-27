#!/bin/bash

cat /sys/fs/cgroup/cpu/docker/cpu.shares

docker container run -d --name nginx-background --cpu-shares 512 --memory 128M -p 8080:80 nginx
docker container stats --no-stream nginx-background

# update memory limit
docker container update --cpu-shares 512 --memory 192M nginx-background
docker container inspect nginx-background
docker container update --cpu-shares 512 --memory 192M --memory-swap 256M nginx-background
docker container stats --no-stream nginx-background

# clean up
docker container stop nginx-background
docker container rm nginx-background
