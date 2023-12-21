variable "image" {
  type = string
}

variable "containers" {
  type = list(object({
    name         = string
    ipv4_address = string
    profiles     = list(string)
    mount_dirs   = list(string)
    environment  = map(any)
    exec         = string
  }))
}

variable "nicparent" {
  type = string
}

variable "nicname" {
  type    = string
  default = "eth0"
}

variable "nictype" {
  type    = string
  default = "bridged"
}

variable "autostart" {
  type = bool
}

variable "exec_enabled" {
  type    = bool
  default = false
}