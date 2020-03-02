#!/bin/env bash

docker="sudo podman"

#$docker run -d -e MONGODB_USER=mongo \

#-v /home/user/database:/var/lib/mongodb/data \

$docker run --rm -it  --name=nmongodb  -e MONGODB_USER=mongodb \
-e MONGODB_PASSWORD=mongodb -e MONGODB_DATABASE=mongodb \
-e MONGODB_ADMIN_PASSWORD=mongo-admin \
rhscl/mongodb-36-rhel7

