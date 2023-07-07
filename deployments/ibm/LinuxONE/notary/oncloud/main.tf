terraform {
  required_providers {
    tls = {
      # Used for generating ssh key pair.
      source  = "hashicorp/tls"
      version = ">= 4.0.1"
    }
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.50.0"
    }
    hpcr = {
      source  = "ibm-hyper-protect/hpcr"
      version = ">= 0.1.12"
    }
  }
}

# Setup IBM terraform providers
provider "ibm" {
  region           = var.region
  zone             = "${var.region}-${var.zone}"
  ibmcloud_api_key = var.ibmcloud_api_key
}
