#!/bin/bash

BUILD_NUMBER=$(date -u +"%Y%m%d.%H%M%S")
PYTHON_VERSION="3.11.4"

docker build -t "vutiendat3601/echovibe-artistquery:${BUILD_NUMBER}" -t "vutiendat3601/echovibe-artistquery:latest" \
--build-arg BUILD_NUMBER=${BUILD_NUMBER} .
