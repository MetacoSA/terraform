# Role that will have policies attached to it, together they enable access to EKS
resource "aws_iam_role" "eks_iam_role" {
  name = var.aws_eks_iam_role_name
  path = "/"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement":
    [
      {
        "Effect": "Allow",
        "Principal":
         {
           "Service": "eks.amazonaws.com"
         },
         "Action": "sts:AssumeRole"
      }
   ]
  }
EOF
}

# These are aws managed policies that are needed to be associated with the cluster
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
 role       = aws_iam_role.eks_iam_role.name
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
 role       = aws_iam_role.eks_iam_role.name
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}
