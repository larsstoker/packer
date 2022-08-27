build {
  sources = ["source.vsphere-iso.rocky"]

  # Enable encrypted vMotion
  provisioner "shell-local" {
    inline = [
      "pwsh ../../scripts/Enable-EncryptedvMotion.ps1 -Server ${var.vsphere_server } -Username ${ var.vsphere_user } -Password ${ var.vsphere_password } -vmName ${ var.vm_name }"
    ]
  }
}