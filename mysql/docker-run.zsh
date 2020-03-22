#!/bin/zsh

db_dir=${1:-$PWD}/db
echo $db_dir

# Run mysql container mounted at the /db folder in the current directory
docker run \
    -d \
    --name mysql \
    -e MYSQL_ROOT_PASSWORD=root \
    -v $db_dir:/var/lib/mysql \
    -p 3306:3306 \
    mysql
