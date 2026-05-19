# ---------------------------------------
# Storage Module
# Creates and attaches persistent block storage volumes
# to the deployed VM instances
# ---------------------------------------
module "volume" {
  source = "../../../modules/storage"

  volume_sizes         = var.volume_sizes
  vms_with_volumes_ids = data.terraform_remote_state.vm.outputs.vms_with_volumes_ids
}
