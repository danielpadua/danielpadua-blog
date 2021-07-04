#!/bin/bash

RESOURCE_GROUP_NAME=danielpadua-dev-rg
STORAGE_ACCOUNT_NAME=blogterraform
CONTAINER_NAME=blogterraform
LOCATION=eastus2
AZ_SUBSCRIPTION=b91bd06c-ddb4-4366-853a-162c571a2e70

# Set account
az account set --subscription $AZ_SUBSCRIPTION

# Create resource group
if [ $(az group exists --name $RESOURCE_GROUP_NAME) = false ]; then
    az group create --name $RESOURCE_GROUP_NAME --location $LOCATION
fi

# Create storage account
if [[ $(az storage account list --query "[?name=='$STORAGE_ACCOUNT_NAME'"]) == "[]" ]]; then
    az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob
fi

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)

# Create blob container
if [ $(az storage container exists --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY --name $CONTAINER_NAME -o tsv | tr '[:upper:]' '[:lower:]') = false ]; then
    az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY
fi

echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY"
