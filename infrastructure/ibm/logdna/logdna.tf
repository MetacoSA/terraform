# Used to retrieve the resource ID from resource group name
data "ibm_resource_group" "rg" {
  name = var.logdna_resource_group
}

# Creates LogDNA instance
resource "ibm_resource_instance" "logdna" {
  name              = var.logdna_instance_name
  resource_group_id = data.ibm_resource_group.rg.id

  # Refer: http://servicedata.mybluemix.net
  service           = "logdna"

  # Refer: https://mycatalog.mybluemix.net
  plan              = var.logdna_log_plan
  location          = var.ibm_cloud_region
}

# Puts ingestion key into the instance. Ingestion key uniquely identifies a LogDNA instance
resource "ibm_resource_key" "ingestion_key" {
  name                 = "ingestion_key"
  resource_instance_id = ibm_resource_instance.logdna.id
}

provider "logdna" {
   servicekey = ibm_resource_key.ingestion_key.credentials["service_key"]
}

output "ingestion_key" {
   value = ibm_resource_key.ingestion_key.credentials["ingestion_key"]
   sensitive = true  
}

output "service_value" {
   value = ibm_resource_key.ingestion_key.credentials["service_key"]
   sensitive = true  
}
