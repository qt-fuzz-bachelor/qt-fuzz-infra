# ---------------------------------------
# Compute Module (VM)
# Deploys virtual machine instances
# using network outputs from remote state
# ---------------------------------------
module "vm" {
  source = "../../../modules/compute"

  network_id       = data.terraform_remote_state.network.outputs.network_id
  subnet_ids       = data.terraform_remote_state.network.outputs.subnet_ids
  ext_network_name = var.ext_network_name
  vm_configs       = var.vm_configs
  team_public_keys = var.team_public_keys
}
