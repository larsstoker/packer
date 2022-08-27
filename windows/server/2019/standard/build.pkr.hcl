build {
  sources = ["source.vsphere-iso.windows"]

  # Need to download from HTTP as parameters can't be used when executing as a script.
  provisioner "powershell" {
    inline = [
      "New-Item -Path 'C:/Temp/' -ItemType 'directory'",
      "Invoke-WebRequest -Uri http://$env:PACKER_HTTP_ADDR/Convert-WindowsEdition.ps1 -OutFile C:/Temp/Convert-WindowsEdition.ps1",
      "cmd.exe /c C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -File C:/Temp/Convert-WindowsEdition.ps1 -windowsEdition 'Microsoft Windows Server 2019 Standard'",
      "Remove-Item -Path 'C:/Temp/' -Recurse"
    ]
  }

  # Enable encrypted vMotion
  provisioner "shell-local" {
    inline = [
      "pwsh ../../../../scripts/Enable-EncryptedvMotion.ps1 -Server ${var.vsphere_server } -Username ${ var.vsphere_user } -Password ${ var.vsphere_password } -vmName ${ var.vm_name }"
    ]
  }

  # Reboot to apply the conversion
  provisioner  "windows-restart" {
    restart_timeout = "30m"
  }

  # Execute the Setup script
  provisioner "powershell" {
    scripts = ["scripts/Setup.ps1"]
  }

  # Execute the Windows Update script
  provisioner "powershell" {
    scripts = ["scripts/Windows-Update.ps1"]
  }

  # Reboot to apply updates
  provisioner  "windows-restart" {
    restart_timeout = "30m"
  }

  # Execute the Windows Update script
  provisioner "powershell" {
    scripts = ["scripts/Windows-Update.ps1"]
  }

  # Reboot to apply updates
  provisioner  "windows-restart" {
    restart_timeout = "30m"
  }

  # Execute the Cleanup script
  provisioner "powershell" {
    scripts = ["scripts/Cleanup.ps1"]
    pause_before = "1m"
  }
}