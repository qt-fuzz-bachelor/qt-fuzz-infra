# ---------------------------------------
# Network ID Output
# Exposes the ID of the created OpenStack network
# ---------------------------------------
output "network_id" {
  description = "The ID of the network created in OpenStack."
  value       = module.network.network_id
}

# ---------------------------------------
# Subnet IDs Output
# Exposes the IDs of the created OpenStack subnets
# ---------------------------------------
output "subnet_ids" {
  description = "The IDs of the subnets created in OpenStack."
  value       = module.network.subnet_ids
}
