#!/bin/bash

BUILD_NUMBER=$(date -u +"%Y%m%d.%H%M%S")

docker build -t "vutiendat3601/echovibe-artistquery:${BUILD_NUMBER}" -t "vutiendat3601/echovibe-artistquery:latest" \
--build-arg BUILD_NUMBER=${BUILD_NUMBER} . &&
docker push "vutiendat3601/echovibe-artistquery:${BUILD_NUMBER}" &&
docker push "vutiendat3601/echovibe-artistquery:latest"
