# Check Point Automagic, June 2025

Workshop environment to discover automation options for Check Point products, both infrastructure and policy.

## Building blocks

* [Github Codespaces](https://docs.github.com/en/codespaces)
    * reproducible devops environment
    * based on [Dev Containers](https://containers.dev/) Specification (see [devcontainer.json](.devcontainer/devcontainer.json))

* [Slidev](https://sli.dev/)
    * presentation framework
    * based on markdown
    * see [slides/slides.md](slides/slides.md)

* [Terraform](https://www.terraform.io/)
* Check Point [Management API](https://sc1.checkpoint.com/documents/latest/APIs/index.html#)
    
## Usage

Start in Azure Cloud Shell at https://shell.azure.com and create necessary credentials for use in Codespace:

```bash
### IN AZURE SHELL ###
# check the script before running
curl -sL https://run.klaud.online/make-sp.sh
# create credentials
source <(curl -sL https://run.klaud.online/make-sp.sh)
# and Reader for CloudGuard Controller and CME
SUBSCRIPTION=$(az account show --query id --output tsv)
# create SP called 'lab-sp' with Owner role
az ad sp create-for-rbac --name "automagic-reader" --role Reader --scopes /subscriptions/$SUBSCRIPTION
```

Then store credentials in Codespace secrets under `secrets` folder as `secrets/sp.json` and `secrets/reader.json`. Examples:
```shell
### IN CODESPACE ###
# full credentials for management and some metatadata from make-sp.sh
cat secrets/sp.json | jq .
{
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "sp-devops-2c3662bc",
  "password": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "tenant": "00000000-0000-0000-0000-000000000000",
  "envId": "2c3662bc",
  "subscriptionId": "00000000-0000-0000-0000-000000000000",
  "name": "sp-cpman-2c3662bc"
}
# reader.json
cat secrets/reader.json | jq .
{
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "automagic-reader",
  "password": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",             
  "tenant": "00000000-0000-0000-0000-000000000000",
}
```
Then you can use and verify credentials in Codespace:
```bash
### IN CODESPACE ###
# full SP credentials
./scripts/login-sp.sh
# verify credentials
./scripts/check-reader.sh
# and finally full admin credentials to login AGAIN
./scripts/login-sp.sh
```

Once credentials are set, Azure admin account active, you can start Security Management deployment and push policy as code into it with Terraform at one single step:
```bash
# deploy Security Management and push policy
make start
```