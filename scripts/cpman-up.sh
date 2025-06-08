#!/bin/bash

set -euo pipefail

(cd management/terraform; terraform init)

(cd management/terraform; terraform apply -auto-approve)