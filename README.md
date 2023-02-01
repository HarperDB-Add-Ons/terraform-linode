# harperdb-linode

## Prerequisites
- [A Linode account](https://www.linode.com/)
- [Terraform v1.3.7+](https://developer.hashicorp.com/terraform/downloads)

## Linode Setup
To give Terraform access, you need a personal access token from Linode. 

Navigate to your [API tokens page](https://cloud.linode.com/profile/tokens) in the Linode console. 

Select "Create a Personal Access Token."

Copy the token and paste it into `terraform.tfvars` file. 

## Terraform Setup
- Clone this repository
- Set the root password in the `terraform.tfvars` file
- Create the plan: `terraform plan -out plan.out`
- Create the infra: `terraform apply "plan.out"`

This will create a VM, set the firewall to allow ssh access and open ports 9925-9926

## Installing Docker

Follow the instructions to download [docker](https://docs.docker.com/engine/install/debian/#prerequisites).

Then run the container:

```
$ mkdir harperdb

$ chmod 777 harperdb

$ sudo docker run -d \
  -v $(pwd)/harperdb:/home/harperdb/hdb \
  -e HDB_ADMIN_USERNAME=HDB_ADMIN \
  -e HDB_ADMIN_PASSWORD=password \
  -p 9925:9925 \
  -p 9926:9926 \
  harperdb/harperdb
```

## Interacting with Harper DB

Send curl commands to create schemas:

```bash
curl --location --request POST <do-public-ip>:9925 \                                                              
  --header 'Content-Type: application/json' \
  --header 'Authorization: Basic SERCX0FETUlOOnBhc3N3b3Jk' \
--data-raw '{
    "operation": "create_schema",
    "schema": "dev"
}'
```
