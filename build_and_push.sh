#!/bin/bash
echo
source ./set_env.sh
echo
docker-compose -f docker-compose.yml build --parallel
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker-compose -f docker-compose.yml push