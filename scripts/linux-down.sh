#!/bin/bash

set -euo pipefail

(cd linux/terraform; terraform init)

(cd linux/terraform; terraform destroy -auto-approve)