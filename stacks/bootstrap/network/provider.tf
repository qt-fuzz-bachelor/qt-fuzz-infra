# ---------------------------------------
# Terraform Required Providers
#
# Configures remote state storage in GitLab (HTTP backend)
# with state locking enabled, and  which provider(s) this
# module requires. This Includes where to download them from
# and what versions are acceptable.
#
# This ensures Terraform knows how to locate and
# install the correct OpenStack provider plugin
# before initialization and planning.
# ---------------------------------------
terraform {
  backend "http" {
    address        = "https://gitlab.stud.idi.ntnu.no/api/v4/projects/31272/terraform/state/runner-network"
    lock_address   = "https://gitlab.stud.idi.ntnu.no/api/v4/projects/31272/terraform/state/runner-network/lock"
    unlock_address = "https://gitlab.stud.idi.ntnu.no/api/v4/projects/31272/terraform/state/runner-network/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = 5
  }
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.40.0"
    }
  }
}
