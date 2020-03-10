#!/bin/zsh

# Run portainer container
docker run -d \
  -p 9000:9000 \
  -p 8000:8000 \
  --name portainer \
  --restart always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ~/docker-servers/portainer/portainer_data:/data \
  portainer/portainer
