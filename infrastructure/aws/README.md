# aws module

This repository contains the automation required to deploy the AWS Elastic Kubernetes Service. The module does the following: 
- Creates AWS EKS cluster and updates kube/config
- Creates a namespace
- Deploys nginx ingress controller
- Creates CNAME or A records depending on the external IP/hostname of  ingress controller service

## Pre-Requisites: 
  1. [aws cli](https://aws.amazon.com/cli/) installed and configured on the machine for updating kube config

      -- Run `aws configure` and make sure to give the right values for `AWS Access Key ID`, `AWS Secret Access Key`, and `Default region name` and make sure the values are same for these terraform variables`aws_iam_access_key_id`, `aws_iam_secret_access_key`, and `aws_region`
  3. [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed on the machine and the PATH env is set appropriately
  4. A pre-registered AWS [Route53 domain](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-register.html)
      - It will be used as root domain to create further domains for Harmonize

**NOTE** : Since the value of ingress controller external IP/hostname will not be known until after applied, terraform can't handle that since it expects the values to be known during plan.
 Recommended workaround is to execute below commands for applying the full config
- `terraform apply --target module.nginx_ingress_controller` ( This will deploy most )
- `terraform apply` ( This will deploy the route53 module )


## Instructions

1. Open a terminal
2. Run `terraform init`
3. Copy  `mysettings.template.tfvars` to `mysettings.auto.tfvars`
4. Edit `mysettings.auto.tfvars` and save it
5. Run  `terraform apply --target module.nginx_ingress_controller`
6.  Run `terraform apply`

At this time, the environment is fully up, and is ready to deploy the workload.

## Bugs
Please report the bugs by opening an issue. Thank you.
