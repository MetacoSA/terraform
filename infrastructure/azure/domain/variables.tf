variable "resource_group" {
  type        = string
  description = "Resource group under which the instances will be created"
}

variable "dns_root_domain" {
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

variable "public_ip_address" {
  type  = list
  description = <<DESC
                  List of IP addresses to be used in creating DNS A record in harmonize domain
                  When you have Ingress controller, it will be the external IP of that service
                DESC
}
