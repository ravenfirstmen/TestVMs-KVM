
resource "libvirt_cloudinit_disk" "cloudinit" {
  name           = local.node.cloudinit
  pool           = libvirt_pool.machine.name
  meta_data      = templatefile("${path.module}/cloud-init/meta_data.cfg.tpl", { machine_id = random_uuid.machine_id.result, hostname = local.node.name })
  network_config = templatefile("${path.module}/cloud-init/network_config.cfg.tpl", {})

  user_data = data.template_cloudinit_config.config.rendered
}


resource "libvirt_domain" "virtual-machine" {
  name   = local.node.name
  vcpu   = var.virtual_cpus
  memory = var.virtual_memory

  autostart = false
  machine   = "q35"

  xml { # para a q35 o cdrom necessita de ser sata
    xslt = file("lib-virt/q35-cdrom-model.xslt")
  }
  qemu_agent = true

  firmware  = "${local.uefi_location_files}/OVMF_CODE.fd"
  cloudinit = libvirt_cloudinit_disk.cloudinit.id

  cpu {
    mode = "host-passthrough"
  }

  disk {
    volume_id = libvirt_volume.vm-disk.id
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  network_interface {
    network_id     = local.node.network_id
    hostname       = local.node.name
    addresses      = [local.node.ip]
    wait_for_lease = true
  }

  depends_on = [
    libvirt_cloudinit_disk.cloudinit,
    libvirt_network.network
  ]
}

resource "libvirt_volume" "vm-disk" {
  name             = local.node.volume
  pool             = libvirt_pool.machine.name
  base_volume_pool = var.base_volume_pool
  base_volume_name = var.base_volume_name
}

resource "libvirt_pool" "machine" {
  name = "${var.prefix}-pool"
  type = "dir"
  path = "/Work/KVM/pools/${var.prefix}"
}