#!/bin/bash

set -euo pipefail

# TF_VAR_management_IP
CPMAN_RG=$(cd management/terraform; terraform output -raw rg)
CPMAN_NAME=$(cd management/terraform; terraform output -raw name)
CPMAN_IP=$(az vm show -d --resource-group "$CPMAN_RG" --name "$CPMAN_NAME" --query "publicIps" -o tsv)
export TF_VAR_management_IP="$CPMAN_IP"

# random password for VMSS sic key
VMSS_SIC_KEY=$(cat ./secrets/vmss-sic.txt 2>/dev/null)
if [[ -z "$VMSS_SIC_KEY" ]]; then
    echo "Generating random VMSS SIC key..."
    VMSS_SIC_KEY=$(openssl rand -base64 16 | tr -d '=/+')
    echo -n "$VMSS_SIC_KEY" > ./secrets/vmss-sic.txt
fi
export TF_VAR_sic_key="$VMSS_SIC_KEY"

(cd vmss/terraform; terraform init)

(cd vmss/terraform; terraform apply -auto-approve)