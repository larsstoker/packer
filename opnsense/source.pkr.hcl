source "vsphere-iso" "opnsense" {
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
  guest_os_type   = "freebsd12_64Guest"
  notes           = local.vm_notes
  CPUs            = var.vm_cpus
  CPU_hot_plug    = true
  RAM             = var.vm_mem
  RAM_hot_plug    = true
  RAM_reserve_all = false

  # HTTP settings
  http_directory = "http"
  http_port_max  = "8680"
  http_port_min  = "8680"

  # SSH settings
  # ssh_username = var.ssh_username
  # ssh_password = var.ssh_password
  # ssh_port     = 22
  # ssh_timeout  = "30m"
  communicator = "none"

  # Network adapters
  # LAN
  network_adapters {
    network      = var.vsphere_network
    network_card = "vmxnet3"
  }

  # WAN
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
    # Installation
    #   Boot screen
    #       Options: Boot Multi user, Boot single user, Escape to loader prompt, Reboot, Cons: Video, Kernel, Boot Options
    #       Action: Enter and boot to Multi User
    "<enter><wait2m>",
    #   Welcome/Login
    #       Options: Login as 'root' or 'installer'
    #       Action: Login as 'installer' with default password 'opnsense'
    "installer<enter><wait2s>",
    "opnsense<enter><wait2s>",
    #   Keymap Selection
    #       Action: continue with default (US)
    "<enter><wait2s>",
    #   Choose one of the following tasks
    #       Options: Install (UFS), Install (ZFS), Other Modes >>, Import Config, Password Reset, Force Reboot
    #       Action: Install (ZFS)
    "<down><enter><wait5s>",
    #   ZFS Configuration
    #       Options: stripe, mirror, raid10, raidz1, raidz2, raidz3
    #       Action: stripe
    "<enter><wait2s>",
    #   Select device
    #       Options: da0 VMware Virtual disk
    #       Action: da0
    "<spacebar><enter><wait2s>",
    #   Are you sure you want to destroy the current contents of da0
    #       Options: YES, NO
    #       Action: YES
    "<left><enter><wait5m>",
    #   Final Configuration
    #       Options: Root Password, Complete Install (Exit and reboot)
    #       Action: Complete Install
    "<down><enter>",
    # First Boot
    "<wait2m>",
    #   Welcome/Login
    #       Options: Login
    #       Action: Login as root
    "root<enter><wait2s>",
    "opnsense<enter><wait2s>",
    # Home screen
    #     Action: Enter shell, install open-vm-tools and execute config.sh
    "8<enter><wait>",
    "pkg install -y os-vmware<enter><wait30s>",
    "cd /tmp/ && curl -o /tmp/config.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/config.sh && chmod +x /tmp/config.sh && sh /tmp/config.sh<enter><wait30s>",
    "exit<enter><wait>",
    # Home screen
    #     Action: Shutdown system
    "5<enter><wait>",
    # Do you want to proceed?
    #     Options: Y, N
    #     Action: Y
    "y<enter><wait>"
  ]
  boot_wait = var.boot_wait

  remove_cdrom = "true"
}