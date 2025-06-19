#!/bin/bash


PARENTDIR=/workspaces/automagic-june-2025/labs/cpman-priv
set -euo pipefail

RG=$(cd "$PARENTDIR"; terraform output -raw rg)
CPMAN_NAME=$(cd "$PARENTDIR"; terraform output -raw name)
echo "Connecting with SSH to ${CPMAN_NAME} in RG $RG"

# az serial-console connect --resource-group $RG --name "${CPMAN_NAME}"

# if ssh-pass not installed, install it
if ! command -v sshpass &> /dev/null; then
    echo "sshpass not found, installing..."
    sudo apt-get update
    sudo apt-get install -y sshpass
fi

CPMAN_IP=$(az vm show -d --resource-group "$RG" --name "$CPMAN_NAME" --query "publicIps" -o tsv)
echo "Connecting to ${CPMAN_NAME} at IP $CPMAN_IP"

echo "script arguments: $@"

sshpass -p "$(cd "$PARENTDIR"; terraform output -raw password)" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null admin@"${CPMAN_IP}" "$@"