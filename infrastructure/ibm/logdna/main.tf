terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "~> 1.39.0"
    }
    logdna = {
      source = "logdna/logdna"
      version = "~> 1.7.0"
    }
  }
}

# Configure the IBM Provider
provider "ibm" {
  region           = var.ibm_cloud_region
  ibmcloud_api_key = var.ibm_cloud_api_key
}
