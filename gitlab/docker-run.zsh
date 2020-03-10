#!/bin/zsh

# Start gitlab network if it doesn't exist
docker network inspect gitlabnet  >/dev/null 2>&1 || docker network create --driver overlay --attachable gitlabnet

# Run gitlab container connected to network
if sudo docker run -d \
  --hostname gitlab.local \
  --publish 8929:80 --publish 22:22 \
  --name gitlab \
  --restart always \
  --volume ~/docker-servers/gitlab/config:/etc/gitlab \
  --volume ~/docker-servers/gitlab/logs:/var/log/gitlab \
  --volume ~/docker-servers/gitlab/data:/var/opt/gitlab \
  --net gitlabnet \
  --net-alias=gitlab.local \
  gitlab/gitlab-ce:latest; then 

    docker logs -f gitlab;
fi
