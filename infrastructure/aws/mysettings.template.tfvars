aws_region="AWS region. Example: ap-south-1"
aws_iam_access_key_id="Value of Access key ID"
aws_iam_secret_access_key="Value of secret access key"

aws_dns_root_domain="Pre registered Route53 domain"
harmonize_domain_prefix="Prefix that will be used to create harmonize domains. Example: harmonize"
# It will then create these domains; "harmonize.$aws_dns_root_domain" "*.harmonize.$aws_dns_root_domain"

namespace= "Name to be given for a namespace to be created"

# If you choose to, you may override the value for below variables. Else, they will use the default ones
#aws_eks_cluster_name=
#aws_eks_node_group_name=
#aws_eks_iam_role_name=
#aws_eks_worker_node_iam_role_name=
