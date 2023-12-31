#!/usr/bin/env bash

export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="demo-v3.openlmis.org:2376"
export DOCKER_CERT_PATH="${PWD}/.deployment-config/v3-demo-certs"

if [ "$KEEP_OR_WIPE" == "wipe" ]; then
  echo "Removing pgdata volume"
  docker volume rm pgdata
fi
echo "Creating pgdata volume"
docker volume create pgdata

../shared/init_env_gh.sh

../shared/pull_images.sh $1

../shared/restart.sh $1
