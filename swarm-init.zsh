#!/bin/zsh

# Init docker swarm if it doesn't exist
if [ "$(docker info | grep Swarm | sed 's/Swarm: //g')" "==" "inactive" ]; then\
    docker swarm init;
fi
