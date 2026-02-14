# --------------------------------------------
# List of VM configurations to deploy.
# Each VM is defined as an object with:
#
# - name:          Instance name
# - image:         OpenStack image name or ID
# - flavor:        Compute flavor (CPU/RAM sizing)
# - volume:        Whether to boot from a volume (true/false)
# - default_user:  Default SSH user for the image
#
# Example:
# vm_configs = [
#   {
#     name         = "vm-1"
#     image        = "ubuntu-22.04"
#     flavor       = "m1.small"
#     volume       = true
#     default_user = "ubuntu"
#   }
# ]
# --------------------------------------------
variable "vm_configs" {
  description = "List of VM configurations."
  type = list(object({
    name         = string
    image        = string
    flavor       = string
    volume       = bool
    default_user = string
  }))
}

# --------------------------------------------
# Name of the external network used to allocate
# floating IP addresses.
#
# This network must provide external connectivity
# (e.g., internet access) for the instances.
# --------------------------------------------
variable "ext_network_name" {
  description = "Name of the external network for floating IPs"
  type        = string
}

# --------------------------------------------
# List of SSH public keys for team access.
#
# These keys will be injected into all deployed VMs,
# allowing multiple team members to authenticate
# via SSH without sharing a single private key.
#
# Each entry must be a valid SSH public key string
# (e.g., starting with "ssh-rsa", "ssh-ed25519", etc.).
#
# Default is an empty list, meaning no additional
# keys are added unless provided via tfvars,
# CLI input, or environment variables.
# --------------------------------------------
variable "team_public_keys" {
  description = "List of SSH public keys for the team to access all VMs"
  type        = list(string)
  default     = [] # optional: can leave empty and provide via tfvars or environment
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
