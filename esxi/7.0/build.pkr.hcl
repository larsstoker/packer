build {
  sources = ["source.vsphere-iso.esxi"]

  provisioner "shell" {
    expect_disconnect = true
    inline = [
      "DATASTORE=$(esxcli storage filesystem list | grep LOCAL-DS01 | cut -f1 -d' ')",
      "mkdir -p $DATASTORE/.locker",
      "vim-cmd hostsvc/advopt/update ScratchConfig.ConfiguredScratchLocation string $DATASTORE/.locker",
      "unset DATASTORE",
      "esxcli sched swap system set --datastore-enabled=true",
      "esxcli sched swap system set --datastore-name=LOCAL-DS01",
      "esxcli system maintenanceMode set -e true -t 0 ; esxcli system shutdown reboot -d 10 -r 'Packer ScratchDir and Swap config Restart' ; esxcli system maintenanceMode set -e false -t 0"
    ]
    pause_after = "2m"
  }

  provisioner "shell" {
    expect_disconnect = true
    inline = [
      "esxcli system maintenanceMode set -e true -t 0",
      "esxcli network firewall ruleset set -e true -r httpClient",
      "esxcli software profile update --no-hardware-warning -p ESXi-7.0U3f-20036589-standard -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml",
      "esxcli network firewall ruleset set -e false -r httpClient",
      "esxcli system shutdown reboot -d 10 -r 'Packer Update Restart' ; esxcli system maintenanceMode set -e false -t 0"
    ]
    pause_after = "2m"
    max_retries = 10
  }

  provisioner "shell" {
    inline = [
        "esxcli system settings advanced set -o /Net/FollowHardwareMac -i 1",
        "sed -i 's#/system/uuid.*##' /etc/vmware/esx.conf",
        "/sbin/auto-backup.sh"
    ]
    max_retries = 10
  }
}