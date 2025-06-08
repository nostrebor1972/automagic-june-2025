---
---
# Azure Service Principal creation

```shell
# Create a service principal with a specific role and scope
az ad sp create-for-rbac --name "myApp" \
    --role contributor 
    --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group-name}
```

In our lab we will use the `Owner` role for the service principal, which grants full access to all resources in the specified scope of our lab subscription.

One can start in Azure's Cloud Shell at https://shell.azure.com, which is pre-configured with the Azure CLI and has access to the necessary permissions. 

```shell
# Get subscription ID
SUBSCRIPTION=$(az account show --query id --output tsv)
# create SP called 'lab-sp' with Owner role
az ad sp create-for-rbac --name "lab-sp" \
    --role Owner \
    --scopes /subscriptions/$SUBSCRIPTION
```

---
layout: two-cols
---
# Azure Service Principal creation response

Notice: `az ad sp create-for-rbac` response with `appId`, `password`, and `tenant` values, which are needed later to configure automation tools like Terraform Azure provider.

```json
{
  "appId": "xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "displayName": "lab-sp",
  "password": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "tenant": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
```
::right::
# Terminology

| Term      | Also Known As      | Description            |
|-----------|-------------------|------------------------|
| `appId`   | Application ID, Client ID | Identifies the application (service principal) in Azure AD. |
| `password`| Client Secret      | Secret string used as the application's credential. |
| `tenant`  | Directory ID       | Identifies the Azure AD (Entra ID) tenant (directory). |


---
---
# Azure Service Principal audit and removal

It is best practice to audit and remove unused service principals regularly.

```shell
# List all own service principals
az ad sp list --show-mine --output table
# Remove a specific service principal by id based on name
az ad sp delete --id $(az ad sp list --display-name lab-sp --query "[0].id" --output tsv)

# recheck
az ad sp list --show-mine --output table
```

---
---
# Devops friendly implementation

Lets assume admin behind https://shell.azure.com providing encrypted Azure Service Princual credentials to the lab participants behind unauthenticated lab Codespace.

```shell
# admin creates string (env var) with credentials

# check what will be done
curl -sL https://run.klaud.online/make-sp.sh

# get export SP=encoded-credentials
source <(curl -sL https://run.klaud.online/make-sp.sh)
```

Resulting environment variable `SP` will contain encrypted JSON with credentials, which can be used in the Codespace to configure automation tools like Terraform Azure provider.

```bash
# provided encrypted credentials
export SP="U2FsdG...Y+hQ="

# To decrypt the service principal details, run the following command:
echo "$SP" |  openssl enc -aes-256-cbc -d -salt -pbkdf2 -base64 -A | jq -r .
```

---
---
# Back in Codespace with encrypted credentials

```bash
# cut&paste from Azure Cloud Shell make-sp.sh session:
export SP="U2FsdG...Y+hQ="

# To decrypt and STORE the service principal details, run the following command:
echo "$SP" |  openssl enc -aes-256-cbc -d -salt -pbkdf2 -base64 -A | jq -r . > ./secrets/sp.json

# check result
cat ./secrets/sp.json | jq .
```

Summary: Azure admin provided ecrypted service principal credentials, which can be decrypted in the Codespace to configure automation tools like Terraform Azure provider.

```json
{
  "appId": "xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "password": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "tenant": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "subscription": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "envId": "abcdabcd"
}
```

We have added `subscription` and `envId` to the service principal credentials for convenience and to enable sharing single Azre subscription with multiple lab participants.

---
---
# Login with Azure Service Principal in ./secrets/sp.json

```shell
# fetch the values
AZ_APPID=$(jq -r .appId ./secrets/sp.json)
AZ_PASSWORD=$(jq -r .password ./secrets/sp.json)
AZ_TENANT=$(jq -r .tenant ./secrets/sp.json)
AZ_ENVID=$(jq -r .envId ./secrets/sp.json)
AZ_SUBSCRIPTION=$(jq -r .subscriptionId ./secrets/sp.json)

az login --service-principal \
    --username $AZ_APPID \
    --password $AZ_PASSWORD \
    --tenant $AZ_TENANT
az account set --subscription $AZ_SUBSCRIPTION -o table

# check result
az account show -o table
```

Summary: We have logged in to Azure with the service principal credentials stored in `./secrets/sp.json`.

---
---
# READER Azure Service Principal

Many components line CloudGuard Controller or CME do not need full access to the Azure subscription, but only read access. In this case, we can create a service principal with the `Reader` role.

```shell
# in Azure Shell
AZ_SUBSCRIPTION=$(az account show --query id --output tsv)
READER=$(az ad sp create-for-rbac --name "lab-sp-reader" \
    --role Reader \
    --scopes /subscriptions/$AZ_SUBSCRIPTION)

echo $READER | jq -r .
```

Copy resulting JSON to `secrets/reader.json` in your Codespace.

```json
{
  "appId": "xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "password": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "tenant": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
```

Summary: we are providing READER role service principal credentials for components like CloudGuard Controller or CME, which do not need full access to the Azure subscription.

---
---
# Final checks in Codespace

Is reader SP ready and usable?

```shell
make check-reader
```

Is admin SP ready and usable?

```shell
make login-sp

# check result
az account show -o table
ENVID=$(jq -r .envId ./secrets/sp.json)
az group create -n lab-test-rg-$ENVID --location westeurope
az group delete -n lab-test-rg-$ENVID --yes --no-wait
```
