# The domain is created inside the resource group
data "azurerm_resource_group" "rg" {
  name     = var.resource_group
}

# Refer to an existing root domain
data "azurerm_dns_zone" "root_domain" {
  name                = var.dns_root_domain
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Create DNS_A record under the root domain. This serves as root domain for the Harmonize
resource "azurerm_dns_a_record" "dns_a_harmonize_root_domain" {
  name                = var.harmonize_domain_prefix
  zone_name           = data.azurerm_dns_zone.root_domain.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 3600
  
  # This comes from the public end point of Ingress controller
  # TODO: This will be done later. Most likely, it will be the public_ip resource
  records             = var.public_ip_address
}

# This is used for sub domains like api,ui, oauth
resource "azurerm_dns_a_record" "dns_a_harmonize_sub_domain" {
  name                = format("*.%s", var.harmonize_domain_prefix)
  zone_name           = data.azurerm_dns_zone.root_domain.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 3600

  # This comes from the public end point of Ingress controller
  records             = var.public_ip_address
}
