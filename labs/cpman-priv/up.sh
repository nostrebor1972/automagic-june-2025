#!/bin/bash

set -euo pipefail

(cd /workspaces/automagic-june-2025/labs/cpman-priv; terraform init)

(cd /workspaces/automagic-june-2025/labs/cpman-priv; terraform apply -auto-approve)