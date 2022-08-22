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
  default = "5s"
}

variable "iso_path" {
  type    = string
  default = "[ISCSI-NAS01-DS02 (ISO)] VMware-VMvisor-Installer-7.0U3-18644231.x86_64.iso"
}

variable "vm_cpus" {
  type    = number
  default = 2
}

variable "vm_os_disk" {
  type    = number
  default = 16384
}

variable "vm_datastore_disk" {
  type    = number
  default = 20480
}

variable "vm_mem" {
  type    = number
  default = 8192
}

variable "vm_name" {
  type    = string
  default = "ESXi7.0-Template"
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