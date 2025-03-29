#!/bin/bash

ng_source_path="../../../"

pushd $ng_source_path &&
rm -fr dist &&
popd &&
docker compose down
