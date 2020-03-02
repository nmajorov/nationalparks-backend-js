#!/bin/sh

export DB_HOST="$($PWD/get_podman_mongo_db_ip.sh)" &&  echo $DB_HOST

