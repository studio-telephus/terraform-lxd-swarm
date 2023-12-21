variable "image" {
  type = string
}

variable "profiles" {
  type = list(string)
}

variable "mount_dirs" {
  type = list(string)
}

variable "nicparent" {
  type = string
}

variable "ipv4_address" {
  type = string
}

variable "exec_enabled" {
  type    = bool
  default = false
}

variable "exec" {
  type    = string
  default = null
}

variable "environment" {
  type    = map(any)
  default = {}
}

variable "nicname" {
  type    = string
  default = "eth0"
}

variable "nictype" {
  type    = string
  default = "bridged"
}

variable "name" {
  type = string
}

variable "autostart" {
  type = bool
}