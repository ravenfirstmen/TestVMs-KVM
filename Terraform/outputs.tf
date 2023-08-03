output "machine" {
  value = {
    name    = local.node.name
    address = local.node.ip
    fqdn    = local.node.fqdn
  }
}
