# This updates the kube config file. It is required that the machine is having aws cli installed
resource "null_resource" "update_kube_config" {
  depends_on = [ aws_eks_addon.aws_ebs_csi_driver ]
  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${var.aws_eks_cluster_name}"
  }
}
