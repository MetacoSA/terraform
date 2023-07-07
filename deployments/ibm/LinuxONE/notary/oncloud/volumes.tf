# Create a data volume to be used by the Notary.
# For now, this code only supports tiered profile.
resource "ibm_is_volume" "notary_data_volume" {
  count           = (var.data_volume_profile == "tiered") ? 1 : 0
  name            = format("%s-volume", var.prefix)
  zone            = "${var.region}-${var.zone}"
  profile         = var.data_volume_iops_tiered
  resource_group  = data.ibm_resource_group.resource_group.id
}

# Attach the created volume to the instance
resource "ibm_is_instance_volume_attachment" "notary_data_volume_attachment" {
  name            = format("%s-vol-attachment", var.prefix)
  volume          = ibm_is_volume.notary_data_volume[0].id
  instance        = ibm_is_instance.notary_hpvs_for_vpc.id

  # Don't delete the attachment after deleting the attachment
  delete_volume_on_attachment_delete = false
 
  # Delete the associated volume when the HPVS instance is deleted
  delete_volume_on_instance_delete   = true
}
