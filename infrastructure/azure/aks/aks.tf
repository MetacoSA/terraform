data "azurerm_resource_group" "rg" {
  name     = var.resource_group
}

# Create a Kubernetes cluster
resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.cluster_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = var.aks_dns_suffix

  default_node_pool {
    name       = "default"
    node_count = var.cluster_num_nodes
    min_count  = var.cluster_min_nodes
    max_count  = var.cluster_max_nodes
    vm_size    = var.aks_profile
    enable_auto_scaling = "true"
  }

  identity {
    type = "SystemAssigned"
  }

  # This is what has been seen to be working
  kubernetes_version  =  var.kubernetes_version

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }

  # NOTE: This needs an ingress controller. The cost effective way is to have nginx ingress controller.
  # Please deploy that into this cluster prior to workload deployment
}

# Save the kubeconfig file
resource "local_file" "kubeconfig" {
  depends_on   = [azurerm_kubernetes_cluster.cluster]
  filename     = "kubeconfig"
  content      = azurerm_kubernetes_cluster.cluster.kube_config_raw
}
