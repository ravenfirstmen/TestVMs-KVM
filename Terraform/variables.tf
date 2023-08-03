# network

variable "network_cidr" {
  type    = string
  default = "192.168.180.0/24"
}

variable "network_domain" {
  type    = string
  default = "test.local"
}

# Volumes
variable "base_volume_pool" {
  type    = string
  default = "Ubuntu22.04"
}

variable "base_volume_name" {
  type    = string
  default = "Ubuntu-22.04-LTS.qcow2"
}

variable "virtual_memory" {
  type        = number
  default     = 4096
  description = "Virtual RAM in MB"
}

variable "virtual_cpus" {
  type        = number
  default     = 2
  description = "Number of virtual CPUs"
}

variable "prefix" {
  type        = string
  description = "name used as prefix for the machine names"
  default     = "test"
}
