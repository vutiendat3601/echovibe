#!/bin/sh
buid_version=$(date -u +"%Y%m%d.%H%M%S")
docker build -t "vutiendat3601/echovibe-apigateway-nginx-dev:$buid_version" -t vutiendat3601/echovibe-apigateway-nginx-dev:latest .
