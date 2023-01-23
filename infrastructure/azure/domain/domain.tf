# The domain is created inside the resource group
data "azurerm_resource_group" "rg" {
  name     = var.azure_resource_group
}

# Refer to an existing root domain
data "azurerm_dns_zone" "root_domain" {
  name                = var.azure_dns_root_domain
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Create DNS_A record under the root domain. This serves as root domain for the Harmonize
# Only create if there is a non default value
resource "azurerm_dns_a_record" "dns_a_harmonize_root_domain" {
  count               = (length(var.ingress_ctrl_ip_address) == 0) ? 0 : 1
  name                = var.harmonize_domain_prefix
  zone_name           = data.azurerm_dns_zone.root_domain.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 3600
  records             = var.ingress_ctrl_ip_address
}

# This is used for sub domains like api,ui, oauth
# Only create if there is a non default value
resource "azurerm_dns_a_record" "dns_a_harmonize_sub_domain" {
  count               = (length(var.ingress_ctrl_ip_address) == 0) ? 0 : 1
  name                = format("*.%s", var.harmonize_domain_prefix)
  zone_name           = data.azurerm_dns_zone.root_domain.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 3600
  records             = var.ingress_ctrl_ip_address
}

# Create DNS_CNAME record under the root domain. This serves as root domain for the Harmonize
# Only create if there is a non default value
resource "azurerm_dns_cname_record" "dns_cname_harmonize_root_domain" {
  count               = (var.ingress_ctrl_hostname == "") ? 0 : 1
  name                = var.harmonize_domain_prefix
  zone_name           = data.azurerm_dns_zone.root_domain.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 3600
  record              = var.ingress_ctrl_hostname
}

# This is used for sub domains like api,ui, oauth
# Only create if there is a non default value
resource "azurerm_dns_cname_record" "dns_cname_harmonize_sub_domain" {
  count               = (var.ingress_ctrl_hostname == "") ? 0 : 1
  name                = format("*.%s", var.harmonize_domain_prefix)
  zone_name           = data.azurerm_dns_zone.root_domain.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 3600
  record              = var.ingress_ctrl_hostname
}
