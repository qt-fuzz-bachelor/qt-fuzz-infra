# ---------------------------------------
# Network Output
# Provides the ID of the OpenStack network created
# Other modules or resources can reference this ID
# ---------------------------------------
output "network_id" {
  description = "The ID of the network created in OpenStack."
  value       = openstack_networking_network_v2.network.id
}

# ---------------------------------------
# Subnets Output
# Returns a map of subnet names to their corresponding subnet IDs
# Enables easy lookup of subnets managed by this module
# ---------------------------------------
output "subnet_ids" {
  description = "The IDs of the subnets created in OpenStack, keyed by subnet name."
  value       = { for key, subnet in openstack_networking_subnet_v2.subnet : key => subnet.id }
}
