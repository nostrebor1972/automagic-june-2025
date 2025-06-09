#!/bin/bash

#!/bin/bash

set -euo pipefail

(cd ./linux/terraform; terraform apply -auto-approve -var route_through_firewall=true -var nexthop=10.108.2.4)