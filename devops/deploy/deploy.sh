#!/bin/bash

if [ "$DEPLOY_CLOUD" == "AZ"  ]; then
    az storage blob upload-batch --account-name danielpaduablogdev -s ../../_site -d '$web'
    echo "infra provisioned in azure"
fi

if [ "$DEPLOY_CLOUD" == "AWS"  ]; then
    echo "aws not implemented yet"
fi
