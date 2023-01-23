variable "aws_region" {
  type        = string
  description = "AWS region onto which the resources are to be deployed"
}

variable "aws_iam_access_key_id" {
  type        = string
  description = "AWS IAM Access Key ID used for login"
}

variable "aws_iam_secret_access_key" {
  type        = string
  description = "AWS IAM Secret Access Key used for login"
}
variable "aws_eks_cluster_name" {
  type        = string
  default     = "harmonize_eks_cluster"
  description = "Name of the EKS cluster"
}

variable "aws_eks_node_group_name" {
  type        = string
  default     = "harmonize_eks_node_groups"
  description = "Name of the EKS cluster worker nodes"
}

variable "aws_eks_iam_role_name" {
  type        = string
  default     = "harmonize_eks_cluster_iam_role"
  description = "Name of the IAM role that is to be attached to the cluster"
}

variable "aws_eks_worker_node_iam_role_name" {
  type        = string
  default     = "harmonize_eks_worker_node_iam_role"
  description = "Name of the IAM role that is to be attached to the worker nodes"
}
