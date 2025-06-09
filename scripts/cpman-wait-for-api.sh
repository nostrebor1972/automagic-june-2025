#!/bin/bash

set -euo pipefail

RG=$(cd management/terraform; terraform output -raw rg)
CPMAN_NAME=$(cd management/terraform; terraform output -raw name)

# az serial-console connect --resource-group $RG --name "${CPMAN_NAME}"
echo "${RG} ${CPMAN_NAME}"

CPMAN_IP=$(az vm show -d --resource-group "$RG" --name "$CPMAN_NAME" --query "publicIps" -o tsv)
CPMAN_PASS=$(cd management/terraform; terraform output -raw password)

echo "Waiting for API to be available at Security Management ${CPMAN_IP}"

PAYLOAD=$(jq -n --arg user "admin" --arg pass "$CPMAN_PASS" '{"user": $user, "password": $pass}')

while true; do
    RESP=$(curl -s -m 5 -k "https://${CPMAN_IP}/web_api/login" -H 'Content-Type: application/json' --data "$PAYLOAD")
    # echo "$RESP" | jq .
    SID=$((echo "$RESP" | jq -r .sid 2>/dev/null) || echo 'null')
    # echo "SID: $SID"

    if [[ "$SID" != "null" ]]; then
        echo "API is available" #, SID: $SID"
        echo -n "Logging out from API... "
        curl -m 5 -s -k "https://${CPMAN_IP}/web_api/logout" \
            -H 'Content-Type: application/json' \
            -H "x-chkp-sid: $SID" \
            --data '{}' | jq -c .
        echo "Done."
        break
    else
        echo "API not available yet, retrying in 5 seconds..."
        sleep 5
    fi
done