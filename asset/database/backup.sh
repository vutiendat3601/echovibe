#!/bin/bash

docker exec echovibe-pg-i1 bash -c "pg_dumpall -U echovibe --inserts -f echovibe.sql" &&
docker cp echovibe-pg-i1:/echovibe.sql ./initdb.d/
