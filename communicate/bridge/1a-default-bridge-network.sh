#!/bin/bash

docker network ls

# you have not specified any --network flags, the containers connect to the default bridge network.
docker run -dit --name alpine1 alpine ash
docker run -dit --name alpine2 --hostname host-alpine2 alpine ash


docker ps -af "name=alpine"
docker network inspect bridge

# test dns
docker exec alpine1 ip addr show
docker exec alpine1 ping -c 2 google.com
docker exec alpine1 cat /etc/hosts

docker exec alpine2 ip addr show
docker exec alpine2 ping -c 2 google.com
docker exec alpine2 cat /etc/hosts

docker exec alpine1 ping -c 2 172.17.0.3
docker exec alpine1 ping -c 2 alpine2

# test port
docker exec alpine1 /bin/ash -c "nc -z 172.17.0.3 80 && echo \"$?=>port is open\" || echo \"$?=>port is NOT open\""
docker exec alpine2 /bin/ash -c "nc -z 172.17.0.2 80 && echo \"$?=>port is open\" || echo \"$?=>port is NOT open\""

# clean up containers
docker container stop alpine1 alpine2
docker container rm alpine1 alpine2
