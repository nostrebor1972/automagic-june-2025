#!/bin/bash

set -euo pipefail

# TF_VAR_management_IP
CPMAN_RG=$(cd management/terraform; terraform output -raw rg)
CPMAN_NAME=$(cd management/terraform; terraform output -raw name)
CPMAN_IP=$(az vm show -d --resource-group "$CPMAN_RG" --name "$CPMAN_NAME" --query "publicIps" -o tsv)
export TF_VAR_management_IP="$CPMAN_IP"

# random password for VMSS sic key
VMSS_SIC_KEY=$(cat ./secrets/vmss-sic.txt 2>/dev/null || true)
if [[ -z "$VMSS_SIC_KEY" ]]; then
    echo "expected secrets/vmss-sic.txt to exist, but did not find it. Exiting."
    exit 1
fi
export TF_VAR_sic_key="$VMSS_SIC_KEY"

(cd vmss/terraform; terraform init)

(cd vmss/terraform; terraform destroy -auto-approve)