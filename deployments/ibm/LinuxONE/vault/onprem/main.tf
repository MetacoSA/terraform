terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
    hpcr = {
      source  = "ibm-hyper-protect/hpcr"
      version = ">= 0.1.9"
    }
  }
}

# terraform libvirt provider works over ssh session
provider "libvirt" {
  uri = format("qemu+ssh://%s@%s/system?keyfile=%s&sshauth=privkey", var.libvirt_user, var.libvirt_host, urlencode(pathexpand(var.ssh_private_key_path)))
}
