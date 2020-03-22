#!/bin/zsh

project_path=${1-$PWD}
project_name=$(basename $project_path);

if [ ! -f $project_path/.gitlab-ci.yml ]; then \
    >&2 echo "No .gitlab-ci.yml file found at $project_path"
fi

# Script fixes `gitlab-runner exec` bug:
# Unmount project folder and rename it
# Replace it with re-mounted project folder (copy instead of rename to unlink from the r/w mounted folder)
gitlab_ci_pre_clone_script="'
    umount /$project_name; \
    mv $project_name "$project_name"_copy; \
    cp -r "$project_name"_tmp $project_name; \
    cd $project_name; \
    git clean -xdf; \
    git init; \
    git config --global user.email \"julianferry94@gmail.com\";' "

# Run tests with gitlab-runner docker image
if docker run --rm -d \
  --name $project_name-gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $project_path:/$project_name \
  gitlab/gitlab-runner; then \
    docker exec $project_name-gitlab-runner /bin/bash -c " \
    cd $project_name; \
    gitlab-runner exec docker \
      --pre-clone-script $gitlab_ci_pre_clone_script \
      --docker-privileged \
      --docker-pull-policy 'if-not-present' \
      --docker-volumes $project_path:/"$project_name"_tmp \
      --docker-volumes /var/run/docker.sock:/var/run/docker.sock \
      test;";

  docker stop $project_name-gitlab-runner
fi

