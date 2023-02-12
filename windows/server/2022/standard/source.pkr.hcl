source "vsphere-iso" "windows" {
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
  guest_os_type   = "windows9Server64Guest"
  notes           = local.vm_notes
  CPUs            = var.vm_cpus
  CPU_hot_plug    = true
  RAM             = var.vm_mem
  RAM_hot_plug    = true
  RAM_reserve_all = false
  firmware        = "efi-secure"

  # HTTP settings
  http_directory = "http"
  http_port_min  = "8680"
  http_port_max  = "8680"

  # WinRM settings
  winrm_username = var.winrm_username
  winrm_password = var.winrm_password
  winrm_timeout  = "1h30m"
  winrm_use_ssl  = true
  winrm_insecure = true
  communicator   = "winrm"

  # Network adapters
  network_adapters {
    network      = var.vsphere_network
    network_card = "vmxnet3"
  }

  # Storage controller
  disk_controller_type = ["pvscsi"]

  # OS disk
  storage {
    disk_size             = var.vm_disk
    disk_thin_provisioned = true
  }

  # ISO
  iso_paths = [
    "${var.iso_path}",
    "[] /vmimages/tools-isoimages/windows.iso"
  ]

  # Floppy
  floppy_files = [
    "scripts/autounattend.xml",
    "scripts/Install-VMwareTools.ps1",
    "scripts/Enable-WinRM.ps1"
  ]
  floppy_img_path = var.pvscsi_driver_path

  # Boot settings
  boot_command = [
    "<spacebar>"
  ]
  boot_wait        = var.boot_wait
  shutdown_command = "shutdown /s /t 5"

  remove_cdrom = "true"
}
