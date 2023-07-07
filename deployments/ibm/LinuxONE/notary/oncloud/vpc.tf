# Create the VPC
resource "ibm_is_vpc" "notary_vpc" {
  name                 = format("%s-vpc", var.prefix)
  tags                 = local.tags
  resource_group       = data.ibm_resource_group.resource_group.id
}

# Create the security group
resource "ibm_is_security_group" "notary_security_group" {
  name                 = format("%s-security-group", var.prefix)
  tags                 = local.tags
  vpc                  = ibm_is_vpc.notary_vpc.id
  resource_group       = data.ibm_resource_group.resource_group.id
}

# Rule that allows the VSI to make outbound connections. This is required
# to connect to the logging instance and the image repository to pull the image
resource "ibm_is_security_group_rule" "notary_outbound_rule" {
  group     = ibm_is_security_group.notary_security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

# Create the subnet within the VPC
resource "ibm_is_subnet" "notary_subnet" {
  name                     = format("%s-subnet", var.prefix)
  tags                     = local.tags
  vpc                      = ibm_is_vpc.notary_vpc.id
  zone                     = "${var.region}-${var.zone}"
  total_ipv4_address_count = 256
  resource_group           = data.ibm_resource_group.resource_group.id
}
