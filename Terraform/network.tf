resource "libvirt_network" "network" {
  name   = "network.${var.network_domain}"
  mode   = "nat"
  domain = var.network_domain

  addresses = [var.network_cidr]

  dns {
    enabled    = true
    local_only = true
  }
}



locals {
  network_gateway = cidrhost(var.network_cidr, 1)
}

