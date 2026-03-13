# ---------------------------------------
# Volume Creation
# Creates block storage volumes for VMs
# Only runs if volume support is enabled and vms_with_volumes_ids is not empty
# ---------------------------------------
resource "openstack_blockstorage_volume_v3" "volume" {
  for_each = length(var.volume_sizes) > 0 ? {
    for idx, vol in var.volume_sizes : idx => vol
  } : {}

  name = "volume_${each.key}"
  size = each.value

  lifecycle {
    prevent_destroy = true
  }
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

  instance_id = each.value
  volume_id   = openstack_blockstorage_volume_v3.volume[each.key].id

  lifecycle {
    create_before_destroy = true
  }
}
