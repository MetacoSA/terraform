# This creates AWS EKS cluster
resource "aws_eks_cluster" "eks_cluster" {
 name     = var.aws_eks_cluster_name
 role_arn = aws_iam_role.eks_iam_role.arn

 vpc_config {
  subnet_ids = [ data.aws_subnets.eks_subnet.ids["0"],
                 data.aws_subnets.eks_subnet.ids["1"],
                 data.aws_subnets.eks_subnet.ids["2"] ]
 }
 depends_on = [ aws_iam_role_policy_attachment.AmazonEKSClusterPolicy ]
}
