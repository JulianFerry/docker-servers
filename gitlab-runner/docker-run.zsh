#!/bin/zsh

# Run gitlab-runner container connected to gitlab network
if docker run -d \
  --name gitlab-runner \
  --net gitlabnet \
  --restart always \
  -v ~/docker-servers/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest; then

    read "token?Enter Gitlab shared Runner registration token: ";

    docker exec gitlab-runner \
      gitlab-runner register -n \
        --url http://gitlab.local \
        --registration-token $token \
        --description "shared docker runner" \
        --executor docker \
        --docker-image "python:3.7-slim-buster" \
        --docker-pull-policy "if-not-present" \
        --docker-volumes /var/run/docker.sock:/var/run/docker.sock \
        --docker-network-mode gitlabnet;
fi
