# --------------------------------------------
# Name of the OpenStack network to create.
# This will be the private network that hosts
# all fuzzing-related VMs and interfaces.
# --------------------------------------------
variable "network_name" {
  description = "The name of the OpenStack network."
  type        = string
  default     = "network_1"
}

# --------------------------------------------
# List of private subnets for the OpenStack network.
# Each subnet is an object with a 'name' and a 'cidr'.
#
# Usually, a single subnet is sufficient for internal traffic,
# but multiple subnets can be used for segregation or other purposes.
#
# Example:
# subnets = [
#   { name = "private-a", cidr = "192.168.80.0/25" },
#   { name = "private-b", cidr = "192.168.80.128/25" }
# ]
# --------------------------------------------
variable "subnets" {
  description = "List of private subnets for the network."
  type = list(object({
    name = string
    cidr = string
  }))
}

# --------------------------------------------
# Name for the OpenStack router resource.
# This router connects the internal network to an external network.
# --------------------------------------------
variable "router_name" {
  description = "The name of the OpenStack router."
  type        = string
  default     = "main_router"
}

# --------------------------------------------
# External network ID (UUID) used by the router to reach the outside.
# This must be provided by the caller (no default) because it’s
# environment-specific (unique per OpenStack deployment).
# --------------------------------------------
variable "ext_network_id" {
  description = "The external network UUID for router connectivity."
  type        = string
}
