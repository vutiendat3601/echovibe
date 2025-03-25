#!/bin/sh

docker compose down &&
rm -fr ./kafka/ &&
mkdir ./kafka/ &&
chmod 777 -R ./kafka/ &&
docker compose up -d
