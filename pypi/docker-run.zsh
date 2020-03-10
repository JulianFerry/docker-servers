#!/bin/zsh

# Create pypi network if it doesn't exist
docker network inspect pypinet  >/dev/null 2>&1 || docker network create --driver overlay --attachable pypinet

# Run container 
docker run -d \
  --publish 8080:8080 \
  --volume ~/docker-servers/pypi/packages:/data/packages \
  --net pypinet \
  --name pypi-server \
  pypiserver/pypiserver:latest \
    -P . -a . packages           # pypi-server command options
