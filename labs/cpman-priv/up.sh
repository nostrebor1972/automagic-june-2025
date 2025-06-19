#!/bin/bash

set -euo pipefail

(cd /workspaces/automagic-june-2025/labs/cpman-priv; terraform init)

(cd /workspaces/automagic-june-2025/labs/cpman-priv; terraform apply -target azurerm_network_security_group.gw_nsg -auto-approve)
(cd /workspaces/automagic-june-2025/labs/cpman-priv; terraform apply -auto-approve)