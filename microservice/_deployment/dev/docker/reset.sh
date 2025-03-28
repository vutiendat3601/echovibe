#!/bin/sh

docker compose down &&
rm -fr ./artistcommand-mongo/ ./artistquery-pg/ ./product-pg/ ./log/ &&
docker compose up -d
