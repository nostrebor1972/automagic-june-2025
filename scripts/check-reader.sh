#!/bin/bash

set -e  # Exit on error
set -u  # Treat unset variables as an error
set -o pipefail  # Fail on any command in a pipeline that fails


# does ./secrets/reader.json exist?
if [ ! -f ./secrets/reader.json ]; then
    echo "Error: ./secrets/reader.json does not exist."
    exit 1
fi

# does ./secrets/sp.json exist?
if [ ! -f ./secrets/sp.json ]; then
    echo "Error: ./secrets/sp.json does not exist."
    exit 1
fi

# vars
AZ_SUBSCRIPTION=$(jq -r .subscriptionId ./secrets/sp.json)
READER_APPID=$(jq -r .appId ./secrets/reader.json)
READER_PASSWORD=$(jq -r .password ./secrets/reader.json)
READER_TENANT=$(jq -r .tenant ./secrets/reader.json)

# logout first
az logout

# login as reader
az login --service-principal \
    --username $READER_APPID \
    --password $READER_PASSWORD \
    --tenant $READER_TENANT

az account set --subscription $AZ_SUBSCRIPTION -o table

# check if we can list resource groups
az group list -o table
