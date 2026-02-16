# ---------------------------------------
# Networking Module
# Provisions the private network, subnets,
# and router connectivity to the external network
# ---------------------------------------
module "network" {
  source = "../../../modules/networking"

  network_name   = var.network_name
  router_name    = var.router_name
  subnets        = var.subnets
  ext_network_id = var.ext_network_id
}
