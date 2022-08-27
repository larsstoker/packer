# Start logging
Start-Transcript -Path "C:\Windows\CFGLogs\Enable-WinRM.txt" -Append

# Stop if any errors occur
$ErrorActionPreference = "Stop"

# Switch network to private mode
$networkProfile = Get-NetConnectionProfile
Set-NetConnectionProfile -Name $networkProfile.Name -NetworkCategory Private

# Enable WinRM service, allow unencrypted WinRM and allow Basic authentication
winrm quickconfig -quiet
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'