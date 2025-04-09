#!/bin/sh

ng_source_path_adminweb="../../adminweb/"

pushd $ng_source_path_adminweb &&
ng build &&
popd &&
docker compose up -d
