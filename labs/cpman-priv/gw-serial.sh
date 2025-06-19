#!/bin/bash

PARENTDIR=/workspaces/automagic-june-2025/labs/cpman-priv

set -euo pipefail

RG=$(cd "$PARENTDIR"; terraform output -raw gw_rg)
GW_NAME=$(cd "$PARENTDIR"; terraform output -raw gw_name)
echo "Connecting to serial console of ${GW_NAME} in RG $RG"

az serial-console connect --resource-group $RG --name "${GW_NAME}"