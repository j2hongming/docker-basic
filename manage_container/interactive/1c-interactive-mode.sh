#!/bin/bash

# run a container
docker container run -d --name nginx-background -p 8080:80 nginx

# we are forking a bash process and using the -i and -t flags to keep open console access to our container
## without tty
docker container exec -i nginx-background /bin/bash

## with tty
docker container exec -it nginx-background /bin/bash
