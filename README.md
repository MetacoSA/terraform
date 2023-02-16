# harmonize-terraform

This repository contains the automation required to easily deploy&update and initialise a Harmonize environment with Terraform.

It is WIP so not hardened for production yet. The main objective is to easily deploy/destroy instances in any Kubernetes of your choice.

## Prereqs

- Terraform installed in your Laptop (or in a VM)
- At least 16 GB of memory on the host machine
- Kubernetes cluster with admin credentials installed to your laptop at `$HOME/.kube/config` (default for `kubectl`)
- this repository checked out to your Laptop
- Exprimental Helm chart(Please ask Metaco to provide as ZIP) checked out to your laptop - same parent folder as the Terraform checkout.
- credentials for the Metaco Harmonize Container registry at `metaco.azurecr.io`.

If you do not know how to get access the above, please contact Metaco.

## Instructions

1. Open a terminal in this repository checkout
2. `terraform init`
3. Copy  `mysettings.template.tfvars` to `mysettings.auto.tfvars`
4. Edit `mysettings.auto.tfvars`
5. `terraform apply`

This deploys Harmonize including its Postgres Database. Checks bellow for limitations and next steps

**Note**: Once everything is deployed, `genesis` needs to be done. For a standard genesis, please run the terraform in `genesis/` folder before the Harmonize can be used

## To Be Implemented

- [ ] Harmonize Genesis - create TLS certificates - until then, you need to ensure your cluster has a default ingress certificate - Harmonize will use it
- [ ] HPVS support - currently Vault and Notary are deployed as regular containers
- [ ] HPCS support
- [ ] Other HSMs
- [ ] Automated testcases
- [ ] Use official Helm charts - until the exprimental changes are merged in prod.

## Bugs

As this is WIP please do not hesitate to open issues. Pull requests are welcomed as well.
