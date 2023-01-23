# Creates worker node pool
resource "aws_eks_node_group" "worker_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.aws_eks_node_group_name
  node_role_arn   = aws_iam_role.worker_nodes_iam_role.arn
  subnet_ids      = [ data.aws_subnets.eks_subnet.ids["0"],
                      data.aws_subnets.eks_subnet.ids["1"],
                      data.aws_subnets.eks_subnet.ids["2"] ]

  # Based on the experiments, the below configuration works
  instance_types = ["t3.xlarge"]
 
  scaling_config {
   desired_size = 1
   max_size     = 2
   min_size     = 1
  }
  depends_on = [
   aws_eks_cluster.eks_cluster,
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
   aws_iam_role_policy_attachment.AmazonEBSCSIDriverPolicy
  ]
}
