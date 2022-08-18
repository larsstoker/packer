source "vsphere-iso" "rocky" {
  # vSphere settings
  vcenter_server              = var.vsphere_server
  username                    = var.vsphere_user
  password                    = var.vsphere_password
  insecure_connection         = "true"
  cluster                     = var.vsphere_cluster
  convert_to_template         = "true"
  datacenter                  = var.vsphere_datacenter
  datastore                   = var.vsphere_datastore
  folder                      = var.vsphere_folder

  # VM settings
  vm_name         = var.vm_name
  guest_os_type   = "centos8_64Guest"
  notes           = local.vm_notes
  CPUs            = var.vm_cpus
  CPU_hot_plug    = true
  RAM             = var.vm_mem
  RAM_hot_plug    = true
  RAM_reserve_all = false
  firmware        = "efi"

  # HTTP settings
  http_directory = "http"
  http_port_min = "8680"
  http_port_max = "8680"

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
  disk_controller_type = ["pvscsi"]

  # OS disk
  storage { 
    disk_size             = var.vm_disk
    disk_thin_provisioned = true
  }

  # ISO
  iso_url = var.iso_url
  iso_checksum = var.iso_checksum

  # Boot settings
  boot_command = [
    "up",
    "e",
    "<down><down><end><wait>",
    "<bs><bs><bs><bs><bs>",
    "inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg",
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
  ]
  boot_wait        = var.boot_wait
  shutdown_command = "echo '${var.ssh_password}' | sudo -S /sbin/halt -h -p"

  remove_cdrom = "true"
}