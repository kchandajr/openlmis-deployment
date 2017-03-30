#!/usr/bin/env bash

export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="v3-demo-env-elb-2037688312.us-east-1.elb.amazonaws.com:2376"
export DOCKER_CERT_PATH="${PWD}/credentials"

../shared/init_env.sh

../shared/pull_images.sh $1

../shared/restart.sh $1