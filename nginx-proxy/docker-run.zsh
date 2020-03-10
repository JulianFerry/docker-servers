#!/bin/zsh

# Remove any existing nginx-proxy containers
if docker ps -aq --filter "name=nginx-proxy" | grep -q .; then \
    docker rm nginx-proxy --force
fi

# Run the nginx-proxy container
docker run -d \
  -p 80:80 \
  --name nginx-proxy \
  -v ~/nginx-proxy/nginx.conf:/etc/nginx/nginx.conf \
  nginx

docker logs -f nginx-proxy
