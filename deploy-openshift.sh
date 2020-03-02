#!/bin/sh

# tested with ose 4

# step 1 get service name of mongo databse
echo "deploy $PWD in project: $(oc project)"

NAME="nationalparks-backend-js"

export DB_HOST="$(oc get svc | grep mongo | awk '{print $1}')"


if [[ -n “$DB_HOST” && “$DB_HOST” != ‘’ ]]
then
    echo "find mongodb deployment"
    echo "database host: $DB_HOST"
    echo "deploy from source"



else

    echo "can't find mongo database service ! deploy mongodb first. aborting.."
    exit 1
fi

echo "deploy $NAME from local directory"
oc new-app --image-stream=openshift/nodejs:latest \
           --code="$PWD" \
           --env=DB_HOST=$DB_HOST \
           --name="$NAME"

oc cancel-build bc/$NAME


oc start-build $NAME --from-repo="$PWD"

sleep 10

oc expose svc $NAME

oc label svc/$NAME type=parksmap-backend component=nationalparks role=backend

# add if needed
# --overwrite
