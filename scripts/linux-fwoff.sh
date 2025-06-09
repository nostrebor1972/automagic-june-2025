#!/bin/bash

#!/bin/bash

set -euo pipefail

(cd ./linux/terraform; terraform apply -auto-approve -var route_through_firewall=false)