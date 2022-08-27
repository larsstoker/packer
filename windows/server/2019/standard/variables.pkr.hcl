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
  default = "3s"
}

variable "iso_path" {
  type    = string
  default = "[ISCSI-NAS01-DS02 (ISO)] en_windows_server_2019_SERVER_EVAL_x64FRE_en-us_1.iso"
}

variable "pvscsi_driver_path" {
  type    = string
  default = "[ISCSI-NAS01-DS02 (ISO)] drivers/pvscsi-Windows8.flp"
}

variable "vm_cpus" {
  type    = number
  default = 2
}

variable "vm_disk" {
  type    = number
  default = 65536
}

variable "vm_mem" {
  type    = number
  default = 4096
}

variable "vm_name" {
  type    = string
  default = "WinSrv2019Std-Template"
}

# SSH settings
variable "winrm_username" {
  type    = string
  default = ""
}

variable "winrm_password" {
  type    = string
  default = ""
}
