# --------------------------------------------
# Lookup of the external OpenStack network by name.
#
# This data source retrieves details (such as ID)
# of the external network used for floating IPs
# and outbound connectivity.
#
# The network name must match an existing external
# network in the OpenStack environment.
# --------------------------------------------
data "openstack_networking_network_v2" "external" {
  name = var.ext_network_name
}

# --------------------------------------------
# Retrieve all subnet IDs associated with the
# external network.
#
# This is useful when attaching routers or allocating
# floating IPs, as some resources require a subnet ID
# instead of just the network ID.
#
# The network_id is obtained dynamically from the
# external network data source above.
# --------------------------------------------
data "openstack_networking_subnet_ids_v2" "external" {
  network_id = data.openstack_networking_network_v2.external.id
}

# --------------------------------------------
# Name of the master key used for SSH and to retrieve windows admin account password
# --------------------------------------------
variable "master_key_name" {
  description = "Public key accessible in SkyHiGh to bootstrap VM with"
  type        = string
}

# --------------------------------------------
# Retrieve RSA master key from openstack
# --------------------------------------------
data "openstack_compute_keypair_v2" "master_key" {
  name = var.master_key_name
}
