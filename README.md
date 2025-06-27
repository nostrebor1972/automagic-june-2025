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
# create SP called 'automagic-reader-xxyyzzaa' with Reader role
az ad sp create-for-rbac --name "automagic-reader-$(openssl rand -hex 4)" --role Reader --scopes "/subscriptions/$(az account show --query id --output tsv)"
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
  "displayName": "automagic-reader-aabbccdd",
  "password": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",             
  "tenant": "00000000-0000-0000-0000-000000000000",
}
```
Then you can use and verify credentials in Codespace:
```bash
### IN CODESPACE ###
# full SP credentials
make login-sp
# verify credentials
make check-reader
# and finally full admin credentials to login AGAIN
make login-sp
```

Once credentials are set, Azure admin account active, you can start Security Management deployment and push policy as code into it with Terraform at one single step:
```bash
# deploy Security Management and push policy
make start
# this takes approx. 20 minutes
```

### Reference

Makefile driven actions summmary:
| Action | Description |
|--------|-------------|
| `make login-sp` | Login to Azure with full SP credentials |
| `make check-reader` | Verify Reader credentials |
| `make start` | Deploy Security Management and push policy |
| `make cpman-serial` | Monitor Security Management deployment on serial console of VM |
| `make cpman-ssh` | SSH into Security Management server VM |
| `make cpman-wait` | Wait for Security Management server VM to be ready to connect from SmartConsole and automation |
| `make cpman-pass` | Get IP and password for Security Management server VM |
| `make policy` | Push policy as code to Security Management server |
| `make policy-down` | Remove policy from Security Management server (`terraform destroy` ) |
| `make vmss` | Deploy CGNS in VMSS to provide access control, threat prevention and visibility |
| `make cme` | Instruction to enable auto provisioning of VMSS instances to Management |
| `make linux` | Make test Linux VM that can be used to test connectivity via firewall |
| `make linux-ssh` | SSH into test Linux VM |
| `make fwon` | Route linux through CGNS VMSS |
| `make fwoff` | Remove routing of linux through CGNS VMSS, Linux goes directly to Internet |
| `make linux-down` | Remove test Linux VM |
| `make vmss-down` | Remove CGNS VMSS |

## Remove lab resources

```shell
# remove Linux machine; repeast if necessary because of resoucer operations timing
make linux-down
# remove CGNS VMSS; repeat if necessary 
make vmss-down
# remove Security Management server; repeat if necessary
make cpman-down

# double check - state should be empty
(cd linux/terraform && terraform state list)
(cd vmss/terraform && terraform state list)
(cd management/terraform && terraform state list)
```