#!/bin/zsh

# Init swarm
if [ "$(docker info | grep Swarm | sed 's/Swarm: //g')" "==" "inactive" ]; then\
    docker swarm init;
fi

# Create network if it doesn't exist
docker network inspect pypinet  >/dev/null 2>&1 || docker network create --driver overlay --attachable pypinet

# Run container 
docker run -d \
  --publish 8080:8080 \
  --volume ~/docker-servers/pypi/packages:/data/packages \
  --net pypinet \
  --name pypi-server \
  pypiserver/pypiserver:latest \
    -P . -a . packages           # pypi-server command options
