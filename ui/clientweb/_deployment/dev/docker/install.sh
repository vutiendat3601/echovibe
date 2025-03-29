#!/bin/bash

ng_source_path="../../../"

pushd $ng_source_path &&
ng build &&
popd &&
docker compose up -d
