variable "network_name" {
  description = "The name of the OpenStack network."
  type        = string
  default     = "network_1"
}

variable "subnets" {
  description = "List of private subnets for the network."
  type = list(object({
    name = string
    cidr = string
  }))
  default = [
    { name = "subnet_1", cidr = "192.168.80.0/24" }
  ]
}

variable "dns_nameservers" {
  description = "List of DNS nameservers for the subnets."
  type        = list(string)
  default     = ["1.1.1.1"]
}

variable "router_name" {
  description = "The name of the OpenStack router."
  type        = string
  default     = "main_router"
}

variable "external_network_id" {
  description = "The external network UUID for router connectivity."
  type        = string
}
