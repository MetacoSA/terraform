# Targeting the default VPC and the subnet
data "aws_vpc" "eks_vpc" {
  default = true
}

# Get subnet info associated with default VPC
data "aws_subnets" "eks_subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.eks_vpc.id]
  }
}
