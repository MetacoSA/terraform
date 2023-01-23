# This terraform module does the following :
# Creates AWS EKS cluster and updates kube/config
# Creates a namespace
# Deploys nginx ingress controller
# Creates CNAME or A records depending on the external IP/hostname of ingress controller service

# Pre-Requisites:
# This module expects the values for the mandatory variables that are in variables.tf
#
# o aws cli available on the machine as it's needed to update kube config
# o  AWS region and credentials for logging in
# o  namespace value
# o  DNS root domain that will be used to create harmonize domains
# o      Example: "auto-terraform.com"
# o  Harmonize domain prefix that will be used to populate other sub domains
# o      Example: "test", will result in following records being created
# o                test.auto-terraform.com, *.test.auto-terraform.com

# *NOTE* : Since value of ingress controller external IP/hostname will not be known until after applied,
#          terraform can't handle that since terraform expects the values to be known during plan.
#          Recommended workaround is to execute below commands for applying the full config
#          terraform apply --target module.nginx_ingress_controller ( This will deploy most )
#          terraform apply ( This will apply the route53 module )

#--------------------------------
# Step_1: Create AWS EKS cluster. 
#--------------------------------
# This would create the cluster, and then update the kube config file
module "aws_eks" {
  source = "./eks"
  aws_region                        = var.aws_region
  aws_iam_access_key_id             = var.aws_iam_access_key_id
  aws_iam_secret_access_key         = var.aws_iam_secret_access_key
  aws_eks_cluster_name              = var.aws_eks_cluster_name
  aws_eks_node_group_name           = var.aws_eks_node_group_name
  aws_eks_iam_role_name             = var.aws_eks_iam_role_name
  aws_eks_worker_node_iam_role_name = var.aws_eks_worker_node_iam_role_name
}

#--------------------------
# Step_2: Create namespace
#--------------------------
resource "kubernetes_namespace_v1" "nginx_namespace" {
 depends_on = [module.aws_eks]
  metadata {
    name = var.namespace
  }
}

#----------------------------------------
# Step_3: Deploy nginx ingress controller
#---------------------------------------
module "nginx_ingress_controller" {
  depends_on       = [kubernetes_namespace_v1.nginx_namespace]
  source           = "../ingress/nginx"
  namespace        = var.namespace
  kube_config_file = "~/.kube/config"
}

# Get the below data from the info exported by nginx ingress controller
locals {
  length_ip_addr  = length(module.nginx_ingress_controller.ingress_ctrl_ip_address)
  length_hostname = length(module.nginx_ingress_controller.ingress_ctrl_hostname)

  ingress_ctrl_ip_address = (local.length_ip_addr == 0)  ? [] : tolist([module.nginx_ingress_controller.ingress_ctrl_ip_address])
  ingress_ctrl_hostname   = (local.length_hostname == 0) ? [] : tolist([module.nginx_ingress_controller.ingress_ctrl_hostname])
}

#--------------------------------------------------------
# Step_4: Create Route_53 DNS_A and/or DNS_CNAME records
#--------------------------------------------------------
module "aws_dns_route53_records" {
  depends_on                = [module.nginx_ingress_controller]
  source                    = "./domain"
  aws_region                = var.aws_region
  aws_iam_access_key_id     = var.aws_iam_access_key_id
  aws_iam_secret_access_key = var.aws_iam_secret_access_key
  aws_dns_root_domain       = var.aws_dns_root_domain
  harmonize_domain_prefix   = var.harmonize_domain_prefix
  ingress_ctrl_ip_address   = local.ingress_ctrl_ip_address
  ingress_ctrl_hostname     = local.ingress_ctrl_hostname
}

# At this poing, AWS is all ready to have Harmonize deployed
