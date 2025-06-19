#!/bin/bash

PARENTDIR=/workspaces/automagic-june-2025/labs/cpman-priv

set -euo pipefail

RG=$(cd "$PARENTDIR"; terraform output -raw rg)
CPMAN_NAME=$(cd "$PARENTDIR"; terraform output -raw name)
echo "Connecting to serial console of ${CPMAN_NAME} in RG $RG"

az serial-console connect --resource-group $RG --name "${CPMAN_NAME}"