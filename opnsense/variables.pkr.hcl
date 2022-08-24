# vSphere variables
variable "vsphere_server" {
  type = string
  default = ""
}

variable "vsphere_user" {
  type = string
  default = ""
}

variable "vsphere_password" {
  type = string
  default = ""
}

variable "vsphere_datacenter" {
  type = string
  default = ""
}

variable "vsphere_cluster" {
  type = string
  default = ""
}

variable "vsphere_network" {
  type = string
  default = ""
}

variable "vsphere_datastore" {
  type = string
  default = ""
}

variable "vsphere_folder" {
  type = string
  default = ""
}

# VM variables
variable "boot_wait" {
  type    = string
  default = "5s"
}

variable "iso_path" {
  type    = string
  default = "[ISCSI-NAS01-DS02 (ISO)] OPNsense-22.1.2-OpenSSL-dvd-amd64.iso"
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
  default = 4096
}

variable "vm_name" {
  type    = string
  default = "OPNsense-Template"
}