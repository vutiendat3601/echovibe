#!/bin/bash

BUILD_NUMBER=$(date -u +"%Y%m%d.%H%M%S")
PYTHON_VERSION="3.11.4"

docker build -t "vutiendat3601/echovibe-product:${BUILD_NUMBER}" \
-t "vutiendat3601/echovibe-product:latest" --platform arm64 . &&
docker push "vutiendat3601/echovibe-product:${BUILD_NUMBER}" &&
docker push "vutiendat3601/echovibe-product:latest"
