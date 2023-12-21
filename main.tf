resource "null_resource" "container_environment" {
  triggers = {
    for item in local.env_ipv4_addresses :
    item.key => item.value
  }
}

resource "random_id" "rng" {
  keepers = {
    first = "${timestamp()}"
  }
  byte_length = 8
}

module "swarm_container" {
  source       = "./modules/container"
  count        = length(var.containers)
  image        = var.image
  name         = var.containers[count.index].name
  ipv4_address = var.containers[count.index].ipv4_address
  profiles     = var.containers[count.index].profiles
  mount_dirs   = var.containers[count.index].mount_dirs
  environment = merge(null_resource.container_environment.triggers, {
    RANDOM_STRING = random_id.rng.hex
  }, var.containers[count.index].environment)
  exec         = var.containers[count.index].exec
  nicparent    = var.nicparent
  autostart    = var.autostart
  exec_enabled = var.exec_enabled
}
