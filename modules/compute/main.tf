# ---------------------------------------
# Compute Instances
# Creates one OpenStack VM per entry in `var.vm_configs`
# Uses for_each keyed by index for stable addressing
# ---------------------------------------
resource "openstack_compute_instance_v2" "vm" {
  for_each = { for idx, vm in var.vm_configs : idx => vm }

  name        = each.value.name   # VM name from config
  image_name  = each.value.image  # Operating system image name
  flavor_name = each.value.flavor # Instance size/flavor

  # Apply cloud-init user_data
  user_data = templatefile("${path.module}/scripts/ssh-access.yml", {
    public_keys  = var.team_public_keys
    default_user = each.value.default_user
  })

  network {
    # Attach this VM to a specific Neutron port
    port = openstack_networking_port_v2.port[each.key].id
  }
}

# ---------------------------------------
# Networking Ports
# Creates one Neutron port per VM for fixed IP and security group attachment
# Separate ports allow fine‑grained control over networking
# ---------------------------------------
resource "openstack_networking_port_v2" "port" {
  for_each = { for idx, vm in var.vm_configs : idx => vm }

  name           = "${each.key}_port" # Port name based on VM name
  network_id     = var.network_id     # Parent network ID
  admin_state_up = true               # Ensure port is administratively UP

  fixed_ip { # Assign fixed IP from specified subnet
    subnet_id = var.subnet_ids[0]
  }

  # Apply security group (SSH) on the port instead of the instance itself
  security_group_ids = [
    openstack_networking_secgroup_v2.ssh.id
  ]
}

# ---------------------------------------
# Floating IP Allocation
# Allocates a floating IP for each created VM instance
# Uses networking floating IPs from the external pool
# ---------------------------------------
resource "openstack_networking_floatingip_v2" "public" {
  for_each = openstack_compute_instance_v2.vm

  pool       = data.openstack_networking_network_v2.external.name   # External network pool
  subnet_ids = data.openstack_networking_subnet_ids_v2.external.ids # External subnets
}

# ---------------------------------------
# Floating IP Association
# Links each floating IP to the corresponding VM port
# Ensures external accessibility to the VM
# ---------------------------------------
resource "openstack_networking_floatingip_associate_v2" "fip_assoc" {
  for_each = openstack_networking_floatingip_v2.public

  floating_ip = each.value.address                             # Allocated floating IP
  port_id     = openstack_networking_port_v2.port[each.key].id # Port to attach the IP to
}

# ---------------------------------------
# SSH Security Group
# Defines an OpenStack security group to allow SSH traffic
# ---------------------------------------
resource "openstack_networking_secgroup_v2" "ssh" {
  name = "ssh_sg" # Simple name for the group
}

# ---------------------------------------
# SSH Security Group Rule
# Opens TCP port 22 on the SSH security group
# Direction, protocol, and prefix come from `var.sg_rule`
# ---------------------------------------
resource "openstack_networking_secgroup_rule_v2" "ssh" {
  security_group_id = openstack_networking_secgroup_v2.ssh.id

  direction        = var.sg_rule.direction # e.g., "ingress"
  ethertype        = var.sg_rule.ethertype # e.g., "IPv4"
  protocol         = var.sg_rule.protocol  # e.g., "tcp"
  remote_ip_prefix = var.sg_rule.remote_ip_prefix
  port_range_min   = 22 # SSH port
  port_range_max   = 22
}
