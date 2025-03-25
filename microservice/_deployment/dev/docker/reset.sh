#!/bin/sh

docker compose down &&
rm -fr ./artistquery-pg/ ./product-pg/ ./log/ &&
docker compose up -d
