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
  default = "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-boot.iso"
}

variable "iso_checksum" {
  type = string
  default = "5a0dc65d1308e47b51a49e23f1030b5ee0f0ece3702483a8a6554382e893333c"
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
  default = "Rocky8.5-Template"
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