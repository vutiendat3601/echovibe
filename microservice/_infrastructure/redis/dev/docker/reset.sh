#!/bin/bash

docker compose down &&
rm -fr ./redis/ &&
mkdir ./redis/ &&
chmod 777 -R ./redis/ &&
docker compose up -d
