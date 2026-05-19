# ---------------------------------------
# Volume-Enabled VM Detection (Locals)
# Builds a filtered list of VM instance IDs
# where the 'volume' flag is set to true
# ---------------------------------------
locals {
  vms_with_volumes_ids = [
    for key, vm in local.all_vm_configs :
    startswith(key, "linux-") ?
    openstack_compute_instance_v2.linux[key].id :
    openstack_compute_instance_v2.windows[key].id
    if try(vm.volume, false)
  ]
}


# ---------------------------------------
# Volume-Enabled VM IDs Output
# Exposes the list of VM IDs that require
# persistent block storage attachment
# ---------------------------------------
output "vms_with_volumes_ids" {
  description = "List of VM IDs that have volumes enabled"
  value       = local.vms_with_volumes_ids
}
