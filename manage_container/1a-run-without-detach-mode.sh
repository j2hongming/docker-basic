#!/bin/bash

# Terminal 1
## run a container
docker container run --name nginx-foreground -p 9090:80 nginx

## load the index.html in nginx
## Ctrl + C to terminate the running process in container

# Terminal 2
docker container ls
docker exec -it nginx-foreground /bin/bash

# Terminal 3
docker container top nginx-foreground
