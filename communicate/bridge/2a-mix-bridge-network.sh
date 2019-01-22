#!/bin/bash

docker network ls
docker network create --driver bridge alpine-net
docker network ls
docker network inspect alpine-net


# you have not specified any --network flags, the containers connect to the default bridge network.
docker run -dit --name alpine1 --network alpine-net alpine ash
docker run -dit --name alpine2 --network alpine-net alpine ash
docker run -dit --name alpine3 alpine ash
docker run -dit --name alpine4 --network alpine-net alpine ash
docker network connect bridge alpine4

docker container ls
docker network inspect bridge
docker network inspect alpine-net

# make sure your containers can all connect to the internet
docker exec alpine1 ping -c 2 google.com
docker exec alpine2 ping -c 2 google.com
docker exec alpine3 ping -c 2 google.com
docker exec alpine4 ping -c 2 google.com

# from alpine1 view
docker exec alpine1 ip addr show
docker exec alpine1 cat /etc/hosts
docker exec alpine1 cat /etc/resolv.conf

## test conmunication
docker exec alpine1 ping -c 2 alpine2
docker exec alpine1 ping -c 2 alpine4
docker exec alpine1 ping -c 2 alpine1
docker exec alpine1 ping -c 2 alpine3
docker exec alpine1 nslookup alpine2
docker exec alpine1 nslookup alpine4
docker exec alpine1 nslookup alpine1
docker exec alpine1 nslookup alpine3
## ping alpine3 by ip
docker exec alpine3 ip addr show


# from alpine4 view
## test conmunication
docker exec alpine4 ping -c 2 alpine2
docker exec alpine4 ping -c 2 alpine4
docker exec alpine4 ping -c 2 alpine1
docker exec alpine4 ping -c 2 alpine3
docker exec alpine4 nslookup alpine2
docker exec alpine4 nslookup alpine4
docker exec alpine4 nslookup alpine1
docker exec alpine4 nslookup alpine3
## ping alpine3 by ip
docker exec alpine3 ip addr show

# clean up containers
docker container stop alpine1 alpine2 alpine3 alpine4
docker container rm alpine1 alpine2 alpine3 alpine4
# clean up network
docker network rm alpine-net
