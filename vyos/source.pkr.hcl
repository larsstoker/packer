source "vsphere-iso" "vyos" {
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
  guest_os_type   = "debian10_64Guest"
  notes           = local.vm_notes
  CPUs            = var.vm_cpus
  CPU_hot_plug    = true
  RAM             = var.vm_mem
  RAM_hot_plug    = true
  RAM_reserve_all = false
  firmware        = "efi"

  # SSH settings
  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  ssh_port     = 22
  ssh_timeout  = "30m"
  communicator = "ssh"

  # Network adapters
  # WAN
  network_adapters {
    network      = var.vsphere_network
    network_card = "vmxnet3"
  }

  # LAN
  network_adapters {
    network      = var.vsphere_network
    network_card = "vmxnet3"
  }

  # OS disk
  storage {
    disk_size             = var.vm_disk
    disk_thin_provisioned = true
  }

  # ISO
  iso_paths = ["${var.iso_path}"]

  # Boot settings
  boot_command = [
    "<enter><wait>",
    "vyos<enter><wait>",
    "vyos<enter><wait>",
    "install image<enter><wait>",
    "<enter><wait>",
    "<enter><wait>",
    "<enter><wait>",
    "Yes<enter><wait10>",
    "<enter><wait10>",
    "<enter><wait10>",
    "<enter><wait10>",
    "vyos<enter><wait5>",
    "vyos<enter><wait5>",
    "<enter><wait10>",
    "reboot<enter><wait10>",
    "Yes<enter><wait120>",
    "vyos<enter><wait>",
    "vyos<enter><wait>",
    "configure<enter><wait>",
    "set interfaces ethernet eth0 address dhcp<enter><wait>",
    "set service ssh port 22<enter><wait>",
    "commit<enter><wait>",
    "save<enter><wait>",
    "exit<enter><wait>",
    "reboot<enter><wait>",
    "yes<enter><wait120>"
  ]
  boot_wait        = var.boot_wait
  shutdown_command = "echo '${var.ssh_password}' | sudo -S /sbin/halt -h -p"

  remove_cdrom = "true"
}