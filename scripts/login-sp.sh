#!/bin/bash

# logout first
az logout

# fetch the values
AZ_APPID=$(jq -r .appId ./secrets/sp.json)
AZ_PASSWORD=$(jq -r .password ./secrets/sp.json)
AZ_TENANT=$(jq -r .tenant ./secrets/sp.json)
AZ_ENVID=$(jq -r .envId ./secrets/sp.json)
AZ_SUBSCRIPTION=$(jq -r .subscriptionId ./secrets/sp.json)

az login --service-principal \
    --username $AZ_APPID \
    --password $AZ_PASSWORD \
    --tenant $AZ_TENANT
az account set --subscription $AZ_SUBSCRIPTION -o table

# check result
az account show -o table