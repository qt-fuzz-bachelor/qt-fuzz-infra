# --------------------------------------------
# Size of the block storage volume in gigabytes (GB).
#
# This determines the allocated storage capacity.
# Must be a positive number.
#
# Example:
# volume_size = 50  # 50 GB
# --------------------------------------------
variable "volume_size" {
  description = "The size of the block storage volume in gigabytes (GB)."
  type        = number
}

# --------------------------------------------
# List of IDs of VMs that should have volumes attached.
#
# Each entry in the list corresponds to a VM instance ID
# (usually obtained from an `openstack_compute_instance_v2` resource)
# that will receive one of the persistent block storage volumes.
#
# Example:
# vms_with_volumes_ids = [
#   "12345678-90ab-cdef-1234-567890abcdef",
#   "abcdef12-3456-7890-abcd-ef1234567890"
# ]
# --------------------------------------------
variable "vms_with_volumes_ids" {
  description = ""
  type        = list(string)
}
