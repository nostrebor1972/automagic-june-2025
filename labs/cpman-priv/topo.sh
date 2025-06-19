#!/bin/bash

set -euo pipefail

ENVID=$(cat ../../secrets/sp.json | jq -r '.envId')
echo "Environment ID: $ENVID"

PARENTDIR=/workspaces/automagic-june-2025/labs/cpman-priv

RG=$(cd "$PARENTDIR"; terraform output -raw rg)
CPMAN_NAME=$(cd "$PARENTDIR"; terraform output -raw name)
echo "Management ${CPMAN_NAME} in RG $RG"

# get public and private IPs of cpman VM
CPMAN_IP=$(az vm show -d --resource-group "$RG" --name "$CPMAN_NAME" --query "publicIps" -o tsv)
CPMAN_PRIVATE_IP=$(az vm show -d --resource-group "$RG" --name "$CPMAN_NAME" --query "privateIps" -o tsv)
echo "Public IP: $CPMAN_IP"
echo "Private IP: $CPMAN_PRIVATE_IP"
echo

# get GW eth0 IP
GW_RG=$(cd "$PARENTDIR"; terraform output -raw gw_rg)
GW_NAME=$(cd "$PARENTDIR"; terraform output -raw gw_name)
echo "GW ${GW_NAME} in RG $GW_RG"
GW_IP=$(az vm show -d --resource-group "$GW_RG" --name "$GW_NAME" --query "privateIps" -o tsv)
echo "GW IP: $GW_IP"
echo
