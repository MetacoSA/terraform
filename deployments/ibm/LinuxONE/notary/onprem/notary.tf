# Make a call to the module to get the contract generated
module "notary_contract" {
  source = "../contract_generator"
  logdna_ingestion_key                   = var.logdna_ingestion_key
  logdna_log_endpoint                    = var.logdna_log_endpoint  
  hpvs_contract_encryption_key           = var.hpvs_contract_encryption_key
  container_registry                     = var.container_registry
  container_registry_user_id             = var.container_registry_user_id
  container_registry_password            = var.container_registry_password
  container_image_repository             = var.container_image_repository
  container_image_sha256                 = var.container_image_sha256
  harmonize_notary_bridge_endpoint       = var.harmonize_notary_bridge_endpoint
  crypto_server_ep11_host                = var.crypto_server_ep11_host
  crypto_server_ep11_port                = var.crypto_server_ep11_port
  crypto_server_type                     = var.crypto_server_type
  volume_encryption_seed_phrase_workload = var.volume_encryption_seed_phrase_workload
  volume_encryption_seed_phrase_user     = var.volume_encryption_seed_phrase_user

  # Below ones are applicable only while using HPCS from ibm cloud
  crypto_server_instance_id    = ""
  crypto_server_access_api_key = ""
}

resource "local_file" "meta_data" {
  content  = yamlencode({
    "local-hostname": var.vsi_hostname
  })
  filename = "./build/cloud-init/meta-data"
}

resource "local_file" "vendor_data" {
  content  =  <<EOF
#cloud-config
users:
  - default
  EOF
  filename = "./build/cloud-init/vendor-data"
}

# Stores the encrypted contract
resource "local_file" "user_data" {
  content  = module.notary_contract.user_data
  filename = "./build/cloud-init/user-data"
}

# Check whether we are running on Windows or a POSIX machine
locals {
  is_posix = substr(abspath(path.cwd), 0, 1) == "/"
}

resource "null_resource" "cloudinit_windows" {
  count = local.is_posix ? 0 : 1
  
  provisioner "local-exec" {
    command     = "mkisofs.exe -output cloudinit.iso -volid cidata -joliet -rock user-data meta-data vendor-data"
    working_dir = "./build/cloud-init"
  }

  depends_on = [
    local_file.meta_data,
    local_file.vendor_data,
    local_file.user_data
  ]
}

# If this terraform script is being run on POSIX machine
resource "null_resource" "cloudinit_posix" {
  count = local.is_posix ? 1 : 0
  
  provisioner "local-exec" {
    command     = <<EOF
      if [ `uname` == "Darwin" ]
      then
         echo "Running on Mac"
         mkisofs -output cloudinit.iso -volid cidata -joliet -rock user-data meta-data vendor-data
      else
         echo "Running on Linux"
         genisoimage -output cloudinit.iso -volid cidata -joliet -rock user-data meta-data vendor-data
      fi
    EOF
    working_dir = "./build/cloud-init"
    interpreter = ["bash", "-c"]
  }

  depends_on = [
    local_file.meta_data,
    local_file.vendor_data,
    local_file.user_data
  ]
}

# This volume contains IBM hyper protect container runtime qcow2 image
resource "libvirt_volume" "boot_volume_vda" {
  name = format("%s-vda", var.prefix)
  pool = var.storage_pool_name
  source = var.hpvs_qcow2_image
  format = "qcow2"
}

# This is the data volume to be attached to the instance
resource "libvirt_volume" "data_volume_vdb" {
  name = format("%s-vdb", var.prefix)
  pool = var.storage_pool_name
  size = var.data_volume_size
  format = "raw"

  xml {
    xslt = file("volume_update.xsl")
  }
}

# This volume is the cidata iso image
resource "libvirt_volume" "cidata_volume_vdc" {
  name = format("%s-vdc", var.prefix)
  pool = var.storage_pool_name
  source = "./build/cloud-init/cloudinit.iso"
  format = "iso"

  depends_on = [
    null_resource.cloudinit_windows,
    null_resource.cloudinit_posix
  ]
}

# This creates a virtual machine
resource "libvirt_domain" "notary_domain" {
  name = format("%s-domain", var.prefix)
  memory = var.memory_in_mbs
  vcpu = var.num_vcpu

  machine = "s390-ccw-virtio"
  xml {
    xslt = file("domain_update.xsl")
  }

  # Attach the boot volume
  disk {
    volume_id = libvirt_volume.boot_volume_vda.id
  }

  # Attach the data volume
  disk {
    volume_id = libvirt_volume.data_volume_vdb.id
  }

  # Attach the cidata volume
  disk {
    volume_id = libvirt_volume.cidata_volume_vdc.id
  }

  # Obtain DHCP IP address on the virtual network
  network_interface {
    network_name = "default"
    wait_for_lease = true
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "sclp"
  }
}
