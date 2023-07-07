# Used to retrieve the resource ID from resource group name
data "ibm_resource_group" "resource_group" {
  name = var.resource_group
}
