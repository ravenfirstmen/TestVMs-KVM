locals {
  uefi_location_files = "/usr/share/OVMF"
  nvram_location      = "/var/lib/libvirt/qemu/nvram"
}

# https://github.com/dmacvicar/terraform-provider-libvirt/issues/778

locals {
  node = {
    name       = var.prefix
    fqdn       = "${var.prefix}.${var.network_domain}"
    ip         = "${cidrhost(var.network_cidr, 2)}"
    ip_cidr    = "${cidrhost(var.network_cidr, 2)}/24"
    network_id = libvirt_network.network.id
    gateway    = local.network_gateway
    volume     = "${var.prefix}" # de momento ignorado
    cloudinit  = "${var.prefix}-cloudinit.iso"
    ssh_key    = tls_private_key.ssh.public_key_openssh
  }
}
