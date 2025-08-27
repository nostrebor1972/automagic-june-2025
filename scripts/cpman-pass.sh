#!/bin/bash

set -euo pipefail

RG=$(cd management/terraform; terraform output -raw rg)
CPMAN_NAME=$(cd management/terraform; terraform output -raw name)
echo "Checking ${CPMAN_NAME} in RG $RG"

# az serial-console connect --resource-group $RG --name "${CPMAN_NAME}"

# if ssh-pass not installed, install it
if ! command -v sshpass &> /dev/null; then
    echo "sshpass not found, installing..."
    sudo apt-get update
    sudo apt-get install -y sshpass
fi

CPMAN_IP=$(az vm show -d --resource-group "$RG" --name "$CPMAN_NAME" --query "publicIps" -o tsv)
CPPASS="$(cd management/terraform; terraform output -raw password)"

echo "Connect to ${CPMAN_NAME} at IP $CPMAN_IP with password ${CPPASS}"
echo "  CLI access with: make cpman-ssh"

