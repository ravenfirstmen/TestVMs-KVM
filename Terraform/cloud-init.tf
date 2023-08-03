resource "random_uuid" "machine_id" {
}

data "template_cloudinit_config" "config" {
  gzip          = false # does not work with NoCloud ds?!?
  base64_encode = false # does not work with NoCloud ds?!?

  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/cloud-init/base_cloud_init.tpl", {
      host_name           = local.node.name,
      host_fqdn           = local.node.fqdn,
      ssh_key             = local.node.ssh_key,
      ca_cert_pem         = tls_self_signed_cert.ca_cert.cert_pem,
      ssh_private_key_pem = tls_private_key.ssh.private_key_pem
    })
  }
}

