# ---------------------------------------
# Terraform Required Providers
#
# Declares which provider(s) this module requires,
# including where to download them from and
# what versions are acceptable.
#
# This ensures Terraform knows how to locate and
# install the correct OpenStack provider plugin
# before initialization and planning.
# ---------------------------------------
terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.40.0"
    }
  }
}
