#!/bin/bash

if [ "$DEPLOY_CLOUD" == "AZ"  ]; then
    chmod +x ./azure/backend.sh
    ./azure/backend.sh
    terraform -chdir=./azure init
    terraform -chdir=./azure plan
    terraform -chdir=./azure apply
    echo "infra provisioned in azure"
fi

if [ "$DEPLOY_CLOUD" == "AWS"  ]; then
    echo "aws not implemented yet"
fi
