# This adds EBS CSI addon to the cluster
resource "aws_eks_addon" "aws_ebs_csi_driver" {
  depends_on   = [aws_eks_node_group.worker_node_group]
  cluster_name = var.aws_eks_cluster_name
  addon_name   = "aws-ebs-csi-driver"
}
