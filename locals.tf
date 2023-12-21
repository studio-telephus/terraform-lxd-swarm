locals {
  env_ipv4_addresses = [for i, item in var.containers : {
    key : replace("${upper(item.name)}_IP", "-", "_"),
    value : item.ipv4_address
  }]
}
