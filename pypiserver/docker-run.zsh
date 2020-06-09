#!/bin/zsh

# Create pypi network if it doesn't exist
docker network inspect pypinet  >/dev/null 2>&1 || docker network create --driver overlay --attachable pypinet

# Run container
echo "Running container pypiserver on port 8080"
docker run -d \
  --publish 8080:8080 \
  --volume ~/docker-servers/pypiserver/packages:/data/packages \
  --network pypinet \
  --name pypiserver \
  pypiserver/pypiserver:latest \
    -P . -a . packages           # pypi-server command options
