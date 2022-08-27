# Params
param(
  # vCenter server
  [Parameter()]
  [String]
  $server,
  # vCenter username
  [Parameter()]
  [String]
  $username,
  # vCenter password
  [Parameter()]
  [String]
  $password,
  # VM Name
  [Parameter()]
  [String]
  $vmName
)

# Create credential object
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

# Establish connection to vCenter
$connect = Connect-ViServer -Server $server -Credential $credential

if ($connect) {
  # Enable encrypted vMotion
  $vm = Get-VM -Name $vmName

  $spec = New-Object VMware.Vim.VirtualMachineConfigSpec
  $spec.MigrateEncryption = [vmware.vim.VirtualMachineConfigSpecEncryptedVMotionModes]::required  
  $spec.FtEncryptionMode = [VMware.Vim.VirtualMachineConfigSpecEncryptedFtModes]::ftEncryptionRequired
  $vm.ExtensionData.ReconfigVM_Task($spec)
}