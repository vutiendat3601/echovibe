#!/bin/bash

BUILD_NUMBER=$(date -u +"%Y%m%d.%H%M%S")
PYTHON_VERSION="3.11.4"

pack build vutiendat3601/echovibe-product -t "vutiendat3601/echovibe-product:${BUILD_NUMBER}" -t "vutiendat3601/echovibe-product:latest" \
  --builder paketobuildpacks/builder:base \
  --env "BP_CPYTHON_VERSION=${PYTHON_VERSION}" \
  --env "BP_SYSTEM_PACKAGES=libpq libpq-dev python3-dev" \
  --platform arm64
