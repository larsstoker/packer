source "vsphere-iso" "esxi" {
  # vSphere settings
  vcenter_server      = var.vsphere_server
  username            = var.vsphere_user
  password            = var.vsphere_password
  insecure_connection = "true"
  cluster             = var.vsphere_cluster
  convert_to_template = "true"
  datacenter          = var.vsphere_datacenter
  datastore           = var.vsphere_datastore
  folder              = var.vsphere_folder

  # VM settings
  vm_name         = var.vm_name
  guest_os_type   = "vmkernel65Guest"
  notes           = local.vm_notes
  CPUs            = var.vm_cpus
  CPU_hot_plug    = true
  RAM             = var.vm_mem
  RAM_hot_plug    = true
  RAM_reserve_all = false
  NestedHV        = true

  # HTTP settings
  http_directory = "http"
  http_port_min  = "8680"
  http_port_max  = "8680"

  # SSH settings
  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  ssh_port     = 22
  ssh_timeout  = "30m"
  communicator = "ssh"

  # Network adapters
  network_adapters {
    network      = var.vsphere_network
    network_card = "vmxnet3"
  }

  # Storage controller
  disk_controller_type = ["pvscsi", "nvme"]

  # OS disk
  storage {
    disk_size             = var.vm_os_disk
    disk_thin_provisioned = true
  }

  # Local datastores disk
  storage {
    disk_size             = var.vm_datastore_disk
    disk_thin_provisioned = true
    disk_controller_index = 1
  }

  # ISO
  iso_paths = ["${var.iso_path}"]

  # Boot settings
  boot_command = [
    "<enter><wait>O<wait>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs>ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg",
    "<enter>"
  ]
  boot_wait        = var.boot_wait
  shutdown_command = "esxcli system maintenanceMode set -e true -t 0 ; esxcli system shutdown poweroff -d 10 -r 'Packer Shutdown' ; esxcli system maintenanceMode set -e false -t 0"

  remove_cdrom = "true"
}
