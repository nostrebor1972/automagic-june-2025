#!/bin/bash

set -euo pipefail

# TF_VAR_management_IP
CPMAN_RG=$(cd management/terraform; terraform output -raw rg)
CPMAN_NAME=$(cd management/terraform; terraform output -raw name)
CPMAN_IP=$(az vm show -d --resource-group "$CPMAN_RG" --name "$CPMAN_NAME" --query "publicIps" -o tsv)
export TF_VAR_management_IP="$CPMAN_IP"

(cd vmss/terraform; terraform init)

(cd vmss/terraform; terraform destroy -auto-approve)