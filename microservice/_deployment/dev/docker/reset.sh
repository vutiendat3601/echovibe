#!/bin/sh

docker compose down &&
rm -fr ./artistcommand-mongo/ ./artistquery-pg/ ./trackcommand-mongo/ ./trackquery-pg/ ./product-pg/ ./log/ &&
docker compose up -d
