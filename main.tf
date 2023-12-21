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
  count     = length(var.containers)
  source    = "github.com/studio-telephus/terraform-lxd-instance.git?ref=1.0.1"
  name      = var.containers[count.index].name
  profiles  = var.containers[count.index].profiles
  image     = var.image
  autostart = var.autostart
  nic = {
    name = var.nicname
    properties = {
      nictype        = var.nictype
      parent         = var.nicparent
      "ipv4.address" = var.containers[count.index].ipv4_address
    }
  }
  mount_dirs   = var.containers[count.index].mount_dirs
  exec_enabled = var.exec_enabled
  exec         = var.containers[count.index].exec
  environment = merge(null_resource.container_environment.triggers, {
    RANDOM_STRING = random_id.rng.hex
  }, var.containers[count.index].environment)
}
