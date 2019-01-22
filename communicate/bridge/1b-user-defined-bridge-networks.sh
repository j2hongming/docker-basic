#!/bin/bash

docker network ls
docker network create --driver bridge alpine-net
docker network create alpine-net2
docker network ls
docker network inspect alpine-net
docker network inspect alpine-net2

# you have not specified any --network flags, the containers connect to the default bridge network.
docker run -dit --name alpine1 --network alpine-net alpine ash
docker run -d --name nginx1 --network alpine-net nginx
docker run -dit --name alpine2 --network alpine-net2 alpine ash
docker run -d --name nginx2 --network alpine-net2 --network-alias nginx1 nginx

docker container ls
docker port nginx1
docker port nginx2
docker network inspect alpine-net
docker network inspect alpine-net2

# make sure your containers can all connect to the internet
docker exec alpine1 ping -c 2 google.com
docker exec alpine2 ping -c 2 google.com

# from alpine1 view
docker exec alpine1 ip addr show
docker exec alpine1 cat /etc/hosts
docker exec alpine1 cat /etc/resolv.conf

## test dns
docker exec alpine1 ping -c 2 nginx1
docker exec alpine1 ping -c 2 nginx2
docker exec alpine1 nslookup nginx1 127.0.0.11
docker exec alpine1 nslookup nginx2 127.0.0.11

## test port
docker exec alpine1 /bin/ash -c "nc -z nginx1 80 && echo 'port 80 is open' || echo 'port 80 is NOT open'"
docker exec alpine1 /bin/ash -c "nc -z nginx1 65535 && echo 'port 65535 is open' || echo 'port 65535 is NOT open'"

## test get html
docker exec alpine1 /bin/ash -c "wget nginx1 -O /tmp/index.html && cat /tmp/index.html"

# from alpine3 view
## test dns
docker exec alpine2 ping -c 2 nginx1
docker exec alpine2 ping -c 2 nginx2
docker exec alpine2 nslookup nginx1 127.0.0.11
docker exec alpine2 nslookup nginx2 127.0.0.11

## test port
docker exec alpine2 /bin/ash -c "nc -z nginx1 80 && echo 'port 80 is open' || echo 'port 80 is NOT open'"
docker exec alpine2 /bin/ash -c "nc -z nginx1 65535 && echo 'port 65535 is open' || echo 'port 65535 is NOT open'"

## test get html
docker exec alpine2 /bin/ash -c "wget nginx1 -O /tmp/index.html && cat /tmp/index.html"

# clean up containers
#docker container stop alpine1 nginx1 alpine2 nginx2
#docker container rm alpine1 nginx1 alpine2 nginx2

# clean up network
#docker network rm alpine-net alpine-net2
