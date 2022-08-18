# vSphere variables
variable "vsphere_server" {
  type    = string
  default = ""
}

variable "vsphere_user" {
  type    = string
  default = ""
}

variable "vsphere_password" {
  type    = string
  default = ""
}

variable "vsphere_datacenter" {
  type    = string
  default = ""
}

variable "vsphere_cluster" {
  type    = string
  default = ""
}

variable "vsphere_network" {
  type    = string
  default = ""
}

variable "vsphere_datastore" {
  type    = string
  default = ""
}

variable "vsphere_folder" {
  type    = string
  default = ""
}

# VM variables
variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "iso_url" {
  type    = string
  default = "https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.0-x86_64-boot.iso"
}

variable "iso_checksum" {
  type = string
  default = "fc6b306b9fc8d327d7545373ce88c48bd1f7e84d29548814a91e84676b7d26e4"
}

variable "vm_cpus" {
  type    = number
  default = 2
}

variable "vm_disk" {
  type    = number
  default = 32768
}

variable "vm_mem" {
  type    = number
  default = 2048
}

variable "vm_name" {
  type    = string
  default = "Rocky9.0-Template"
}

# SSH settings
variable "ssh_username" {
  type    = string
  default = ""
}

variable "ssh_password" {
  type    = string
  default = ""
}