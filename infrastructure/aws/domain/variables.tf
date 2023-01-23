variable "aws_region" {
  type        = string
  description = "AWS region onto which the resources are to be deployed"
}

variable "aws_iam_access_key_id" {
  type        = string
  description = "AWS IAM Access Key ID used for login"
}

variable "aws_iam_secret_access_key" {
  type        = string
  description = "AWS IAM Secret Access Key used for login"
}

variable "aws_dns_root_domain" {
  type        = string
  description = "DNS domain that will be used to create Harmonize domains"
}

variable "harmonize_domain_prefix" {
  type        = string
  description = <<DESC
                  Harmonize root domain under dns_root_domain. So give only the prefix and not the FQDN
                  Example: harmonize . It will then create harmonize.$value_of_dns_root_domain
                DESC
}

variable "ingress_ctrl_ip_address" {
  type        = list(string)
  default     = []
  description = <<DESC
                  List of IP addresses to be used in creating DNS_A record in harmonize domain
                  When you have Ingress controller, it will be the external IP of that service
                DESC
}

variable "ingress_ctrl_hostname" {
  type        = list(string)
  default     = []
  description = <<DESC
                  List of hostnames to be used in creating DNS_CNAME record in harmonize domain
                  When you have Ingress controller, it will be from the service
                DESC
}
