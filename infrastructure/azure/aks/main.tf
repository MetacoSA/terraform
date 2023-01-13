terraform {
  required_providers {
  azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.38.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.16.1"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.8.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

# Configure Azure providers
provider "azurerm" {
  features {}
}
