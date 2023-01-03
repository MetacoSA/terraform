# harmonize-terraform

This repository contains the automation required to easily deploy&update and initialise a Harmonize environment with Terraform.

It is WIP so not hardened for production yet. The main objective is to easily deploy/destroy instances in any Kubernetes of your choice.

## Prereqs

- Terraform installed in your Laptop (or in a VM)
- Kubernetes cluster with admin credentials installed to your laptop at `$HOME/.kube/config` (default for `kubectl`)
- this repository checked out to your Laptop
- [Exprimental Helm chart](https://gitlab.com/MetacoSA/customers/experimental/harmonize-helm) checked out to your laptop - same parent folder as the Terraform checkout.
- credentials for the [Metaco Harmonize Container registry](metaco.azurecr.io).

If you do not know how to get access the above, please check the see [getting started](https://metacocloud.sharepoint.com/:u:/r/sites/CustomerSuccess/SitePages/Getting%20started%20at%20Metaco.aspx).

## Instructions

1. Open a terminal in this repository checkout
2. `terraform init`
3. Copy  `mysettings.template.tfvars` to `mysettings.auto.tfvars`
4. Edit `mysettings.auto.tfvars`
5. `terraform apply`

This deploys Harmonize including its Postgres Database. Checks bellow for limitations and next steps

## To Be Implemented

- [ ] Harmonize Genesis - you need to follow customer documentation for this
- [ ] Harmonize Genesis - create TLS certificates - until then, you need to ensure your cluster has a default ingress certificate - Harmonize will use it
- [ ] HPVS support - currently Vault and Notary are deployed as regular containers
- [ ] HPCS support
- [ ] Other HSMs
- [ ] Automated testcases
- [ ] Use official Helm charts - until the [exprimental changes](https://gitlab.com/MetacoSA/customers/experimental/harmonize-helm) are merged in prod.

## Bugs

As this is WIP please do not hesitate to open issues. Pull requests are welcomed as well.
