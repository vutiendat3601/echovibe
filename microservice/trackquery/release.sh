#!/bin/bash

BUILD_NUMBER=$(date -u +"%Y%m%d.%H%M%S")

docker build -t "vutiendat3601/echovibe-trackquery:${BUILD_NUMBER}" -t "vutiendat3601/echovibe-trackquery:latest" \
--build-arg BUILD_NUMBER=${BUILD_NUMBER} . &&
docker push "vutiendat3601/echovibe-trackquery:${BUILD_NUMBER}" &&
docker push "vutiendat3601/echovibe-trackquery:latest"
