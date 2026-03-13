# --------------------------------------------
# Size of the block storage volume in gigabytes (GB).
#
# This determines the allocated storage capacity.
# Must be a positive number.
# --------------------------------------------
variable "volume_sizes" {
  description = "The size of the block storage volume in gigabytes (GB)."
  type        = list(number)
}
