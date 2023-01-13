variable "resource_group" {
  type        = string
  description = "Resource group under which the instances will be created"
}

variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "cluster_num_nodes" {
  type        = number
  default     = 1
  description = "Number of worker nodes to be present in the cluster"
}

variable "cluster_min_nodes" {
  type        = number
  default     = 1
  description = "Minimum number of worker nodes to be present in the cluster"
}

variable "cluster_max_nodes" {
  type        = number
  default     = 1
  description = "Maximum number of worker nodes that can be present in the cluster"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.23.12"
  description = "Version of the Kubernetes to be deployed in AKS cluster"
}

variable "aks_profile" {
  type        = string
  default     = "standard_d4s_v3"
  description = "Profile to be used in creating the cluster"
}

variable "aks_dns_suffix" {
  type        = string
  default     = "aks-kubernetes-cluster"
  description = "DNS suffix to be used in addressing the cluster"
}
