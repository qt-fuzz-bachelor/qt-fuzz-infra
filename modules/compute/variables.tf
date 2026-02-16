# --------------------------------------------
# Configuration object for a security group rule.
# Defines traffic rules applied to the VM instances.
#
# Fields:
# - direction: ingress or egress
# - ethertype: IPv4 or IPv6
# - protocol: tcp, udp, icmp, etc.
# - remote_ip_prefix: CIDR allowed for the rule
#
# Default allows inbound TCP traffic from 10.0.0.0/8.
# Adjust according to your security requirements.
# --------------------------------------------
variable "sg_rule" {
  description = "Configuration for a security group rule"
  type = object({
    direction        = string
    ethertype        = string
    protocol         = string
    remote_ip_prefix = string
  })
  default = {
    direction        = "ingress"
    ethertype        = "IPv4"
    protocol         = "tcp"
    remote_ip_prefix = "10.0.0.0/8"
  }
}

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
# List of subnet IDs where compute instances
# will be deployed.
#
# Instances may be distributed across multiple
# subnets for redundancy or segmentation.
#
# Must reference existing subnet UUIDs.
# --------------------------------------------
variable "subnet_ids" {
  type        = list(string)
  description = "List fo subnet IDs where the compute instances will be deployed."
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
# ID of the internal network to which the VM
# instances will be attached.
#
# This is typically the private network created
# for the environment.
# --------------------------------------------
variable "network_id" {
  description = "ID of network to associate with the VM instance"
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
