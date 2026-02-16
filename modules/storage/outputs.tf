# --------------------------------------------
# List of IDs for all persistent block storage volumes.
#
# This output collects the IDs of every volume created
# by the `openstack_blockstorage_volume_v3.volume` resource.
# These IDs can be used for attaching volumes to VMs,
# referencing in other modules, or for bookkeeping.
# --------------------------------------------
output "volume_ids" {
  description = "List of IDs for all persistent block storage volumes"
  value       = [for v in openstack_blockstorage_volume_v3.volume : v.id]
}
