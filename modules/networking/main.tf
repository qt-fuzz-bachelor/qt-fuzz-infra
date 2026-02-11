# ---------------------------------------
# OpenStack Network
# Creates a single private network for all fuzzing resources
# ---------------------------------------
resource "openstack_networking_network_v2" "network" {
  name           = var.network_name # Name of the network from input variable
  admin_state_up = true             # Enables the network
}

# ---------------------------------------
# Subnets
# Create one subnet per entry in the subnets map
# Uses for_each keyed by subnet name for stable addressing
# Allows multiple subnets if needed (e.g., for segregation)
# ---------------------------------------
resource "openstack_networking_subnet_v2" "subnet" {
  for_each = { for s in var.subnets : s.name => s }

  name            = each.value.name
  network_id      = openstack_networking_network_v2.network.id
  cidr            = each.value.cidr
  dns_nameservers = var.dns_nameservers
}

# ---------------------------------------
# Router
# Connects the private network to an external gateway
# Useful for SSH access or external connectivity
# ---------------------------------------
resource "openstack_networking_router_v2" "router" {
  name                = var.router_name
  external_network_id = var.external_network_id
}

# ---------------------------------------
# Router Interfaces
# Attaches all created subnets to the router above
# Each subnet gets an interface for connectivity
# ---------------------------------------
resource "openstack_networking_router_interface_v2" "router_interface" {
  for_each  = openstack_networking_subnet_v2.subnet
  router_id = openstack_networking_router_v2.router.id # Use defined router
  subnet_id = each.value.id                            # Attach this subnet
}
