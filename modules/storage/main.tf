# ---------------------------------------
# Volume Attachment
# Attaches block storage volumes to their respective VMs
# Only runs if volume support is enabled and volume_ids is not empty
# ---------------------------------------
resource "openstack_blockstorage_volume_v3" "volume" {
  for_each = { for idx, vol in var.volume_name : idx => vol }

  name = each.value
  size = var.volume_size
}
