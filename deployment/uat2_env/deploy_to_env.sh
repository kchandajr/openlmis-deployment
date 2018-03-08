#!/usr/bin/env bash

export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://uat2-env-elb-1962148125.us-east-1.elb.amazonaws.com:2376"
export DOCKER_CERT_PATH="${PWD}/credentials"

../shared/init_env_gh.sh

if [ ! -z "$ENV_RESTORE_SNAPSHOT" ]; then
  export KEEP_OR_WIPE="use_env"
  cp .deployment-config/$ENV_RESTORE_SNAPSHOT .env
  docker pull openlmis/restore-snapshot
  docker pull openlmis/obscure-data
  /usr/bin/docker run --rm --env-file .env openlmis/restore-snapshot
  sleep 300
  /usr/bin/docker run --rm --env-file .env openlmis/obscure-data
else
  cp .deployment-config/perftest.env .env
fi

../shared/pull_images.sh $1

../shared/restart.sh $1
