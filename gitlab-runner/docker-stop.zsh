#!/bin/zsh

# Unregister runner
docker exec gitlab-runner \
    gitlab-runner unregister --all-runners;
rm -r ~/docker-servers/gitlab-runner/config

# Stop container
docker stop gitlab-runner;
