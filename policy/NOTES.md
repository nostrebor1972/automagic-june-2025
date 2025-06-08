```shell
PARENTDIR=/workspaces/automagic-june-2025
CPMANRG=$(cd "$PARENTDIR/management/terraform" && terraform output -raw rg)
CPMANNAME=$(cd "$PARENTDIR/management/terraform" && terraform output -raw name)
CPMANIP=$(az vm show -d --resource-group "$CPMANRG" --name "$CPMANNAME" --query "publicIps" -o tsv)
CPMANPASS=$(cd "$PARENTDIR/management/terraform"; terraform output -raw password)
# echo "Management IP: $CPMANIP   Password: $CPMANPASS"

export CHECKPOINT_SERVER="$CPMANIP"
export CHECKPOINT_USERNAME="admin"
export CHECKPOINT_PASSWORD="$CPMANPASS"
export CHECKPOINT_API_KEY=""

cd "$PARENTDIR/policy/terraform"
rm sid.json
CHECKPOINT_SESSION_NAME="automagic-june-2025 $(date +%Y-%m-%dT%H:%M:%S)"
terraform init -upgrade
terraform apply -auto-approve

SID=$(cat "$PARENTDIR/policy/terraform/sid.json" | jq -r '.sid')
echo "SID: $SID"

$PARENTDIR/scripts/publish.sh "$SID"

# destroy
cd "$PARENTDIR/policy/terraform"
rm sid.json
CHECKPOINT_SESSION_NAME="DESTROY automagic-june-2025 $(date +%Y-%m-%dT%H:%M:%S)"
terraform destroy -auto-approve

SID=$(cat "$PARENTDIR/policy/terraform/sid.json" | jq -r '.sid')
echo "SID: $SID"

$PARENTDIR/scripts/publish.sh "$SID"

