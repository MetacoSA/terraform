# Locate all the latest images in IBM cloud catalog
data "ibm_is_images" "cloud_catalog_images" {
  visibility = "public"
  status     = "available"
}

# Locate the latest hyper protect image from the list of all available images
data "hpcr_image" "hyper_protect_image" {
  images = jsonencode(data.ibm_is_images.cloud_catalog_images.images)
}

# Fetch the encryption certificate mapping to the hyper protect image
data "hpcr_encryption_certs" "enc_cert" {
  versions = [data.hpcr_image.hyper_protect_image.version]
}

# Need this to be passed to the contract module
locals {
  contract_encryption_cert = data.hpcr_encryption_certs.enc_cert.certs[data.hpcr_image.hyper_protect_image.version]
}
