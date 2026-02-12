# --------------------------------------------
# List of names for persistent block storage volumes.
#
# Each entry in the list represents one volume that
# will be created. Names should be unique within
# the project to avoid conflicts.
#
# Example:
# volume_name = ["volume_1", "volume_2"]
# --------------------------------------------
variable "volume_name" {
  description = "The names assigned to the persistent block storage volumes."
  type        = list(string)
  default = [
    "volume_1",
    "volume_2"
  ]
}

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
