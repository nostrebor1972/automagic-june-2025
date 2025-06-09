---
layout: cover
---
# `make policy`
## Check Point policy as code with Terraform
---
layout: image
image: clickops_devops_cpman.svg
---

---
---
# `make policy` using Check Point Management Terraform Provider

```shell
# back in Codespace terminal

# API has to be enabled and reacheable on Security Management VM
./scripts/cpman-wait-for-api.sh

# quick action
code ./policy/terraform/hosts.tf
make policy

# or in detail...
```

---
---
# Check Point Management Terraform Provider

Check Point Management API Terraform provider [docs](https://registry.terraform.io/providers/CheckPointSW/checkpoint/latest/docs#environment-variables)

```shell
# provider declared
cat ./policy/terraform/provider.tf

# connection using environment variables
PARENTDIR=/workspaces/automagic-june-2025
# Management VM location in Azure
CPMANRG=$(cd "$PARENTDIR/management/terraform" && terraform output -raw rg)
CPMANNAME=$(cd "$PARENTDIR/management/terraform" && terraform output -raw name)
# query IP and password (+ known user admin)
CPMANIP=$(az vm show -d --resource-group "$CPMANRG" --name "$CPMANNAME" --query "publicIps" -o tsv)
CPMANPASS=$(cd "$PARENTDIR/management/terraform"; terraform output -raw password)

echo "Management IP: $CPMANIP   Password: $CPMANPASS"

# provider exects following CHECKPOINT_ environment variables:
export CHECKPOINT_SERVER="$CPMANIP"
export CHECKPOINT_USERNAME="admin"
export CHECKPOINT_PASSWORD="$CPMANPASS"
export CHECKPOINT_API_KEY=""
```

---
---
# Terraform policy as code

```shell
# download dependencies - providers, modules etc. that are not in the repo
(cd "$PARENTDIR/policy/terraform"; terraform init)

# make configuration change
code ./policy/terraform/hosts.tf

# detect configuration drift
(cd "$PARENTDIR/policy/terraform"; terraform plan -out plan.tfplan)
# print the plan
(cd "$PARENTDIR/policy/terraform"; terraform show plan.tfplan)

# apply the plan - to fix configuration drift
(cd "$PARENTDIR/policy/terraform"; terraform apply -auto-approve plan.tfplan)
```

