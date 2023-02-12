# Start logging
Start-Transcript -Path "C:\Windows\CFGLogs\Enable-WinRM.txt" -Append

# Stop if any errors occur
$ErrorActionPreference = "Stop"

# Remove HTTP listener
Remove-Item -Path WSMan:\Localhost\listener\listener* -Recurse

# Generate self-signed certificate
$IP = (Get-NetIPAddress -InterfaceAlias "Ethernet*" -AddressFamily IPv4).IPAddress
$CertificateThumbprint = (New-SelfSignedCertificate -DnsName $env:COMPUTERNAME,$IP -CertStoreLocation "Cert:\LocalMachine\My").Thumbprint

# Enable WinRM
$listener = @{
   ResourceURI = "winrm/config/Listener"
   SelectorSet = @{Address="*";Transport="HTTPS"}
   ValueSet = @{CertificateThumbprint=$CertificateThumbprint}
 }
New-WSManInstance @listener

Set-WSManInstance -ResourceURI WinRM/Config/Service/Auth -ValueSet @{Basic = "true"}

$rule = @{
   Name = "WINRM-HTTPS-In-TCP"
   DisplayName = "Windows Remote Management (HTTPS-In)"
   Description = "Inbound rule for Windows Remote Management via WS-Management. [TCP 5986]"
   Enabled = "true"
   Direction = "Inbound"
   Profile = "Any"
   Action = "Allow"
   Protocol = "TCP"
   LocalPort = "5986"
 }
New-NetFirewallRule @rule