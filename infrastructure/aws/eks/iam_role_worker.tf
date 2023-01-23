# Create IAM roles for worker nodes
resource "aws_iam_role" "worker_nodes_iam_role" {
  name = var.aws_eks_worker_node_iam_role_name
 
  assume_role_policy = jsonencode(
  {
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
   })
}
 
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.worker_nodes_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
 
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.worker_nodes_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
 
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.worker_nodes_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# This is needed for creating Persistent Volumes
resource "aws_iam_role_policy_attachment" "AmazonEBSCSIDriverPolicy" {
 role       = aws_iam_role.worker_nodes_iam_role.name
 policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}
