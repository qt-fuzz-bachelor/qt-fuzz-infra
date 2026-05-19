# ---------------------------------------
# Volume-Enabled VM IDs Output
# Exposes the list of VM IDs that require
# persistent block storage attachment
# ---------------------------------------
output "vms_with_volumes_ids" {
  description = "List of VM IDs that have volumes enabled"
  value       = module.vm.vms_with_volumes_ids
}
