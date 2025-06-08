#!/bin/bash

set -euo pipefail

RG=$(cd management/terraform; terraform output -raw rg)
CPMAN_NAME=$(cd management/terraform; terraform output -raw name)
echo "Connecting to serial console of ${CPMAN_NAME} in RG $RG"

az serial-console connect --resource-group $RG --name "${CPMAN_NAME}"