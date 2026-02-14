# ---------------------------------------
# Volume Creation
# Creates block storage volumes for VMs
# Only runs if volume support is enabled and vms_with_volumes_ids is not empty
# ---------------------------------------
resource "openstack_blockstorage_volume_v3" "volume" {
  for_each = length(var.vms_with_volumes_ids) > 0 ? {
    for idx, vm_id in var.vms_with_volumes_ids :
    idx => vm_id
  } : {}

  name = "volume_${each.key}"
  size = var.volume_size
}

# ---------------------------------------
# Volume Attachment
# Attaches created volumes to respective VMs
# Only runs if volume support is enabled and vms_with_volumes_ids is not empty
# ---------------------------------------
resource "openstack_compute_volume_attach_v2" "volume_attachment" {
  for_each = length(var.vms_with_volumes_ids) > 0 ? {
    for idx, vm_id in var.vms_with_volumes_ids :
    idx => vm_id
  } : {}

  instance_id = var.vms_with_volumes_ids[each.key] # Use the key from for_each
  volume_id   = openstack_blockstorage_volume_v3.volume[each.key].id
}
