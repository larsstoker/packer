# Params
param(
  # Windows edition to convert to
  [Parameter()]
  [String]
  $windowsEdition
)

# Start logging
Start-Transcript -Path "C:\Windows\CFGLogs\Convert-WindowsEdition.txt" -Append

# Edition and key list
$windowsEditionList = @{
  'Microsoft Windows Server 2016 Standard'   = 'ServerStandard', 'WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY'
  'Microsoft Windows Server 2016 Datacenter' = 'ServerDataCenter', 'CB7KF-BWN84-R7R2Y-793K2-8XDDG'
  'Microsoft Windows Server 2019 Standard'   = 'ServerStandard', 'N69G4-B89J2-4G8F4-WWYCC-J464C'
  'Microsoft Windows Server 2019 Datacenter' = 'ServerDataCenter', 'WMDGN-G9PQG-XVVXX-R3X43-63DFG'
  'Microsoft Windows Server 2022 Standard'   = 'ServerStandard', 'VDYBN-27WPP-V4HQT-9VMD4-VMK7H'
  'Microsoft Windows Server 2022 Datacenter' = 'ServerDataCenter', 'WX4NM-KYWYW-QJJR4-XV3QB-6VM33'
}

# Convert Windows edition
if ($windowsEditionList[$windowsEdition]) {
  $convertEdition = $windowsEditionList[$windowsEdition][0]
  $convertKey = $windowsEditionList[$windowsEdition][1]

  $command = "DISM.exe /Online /Set-Edition:$convertEdition /ProductKey:$convertKey /AcceptEula /NoRestart"

  cmd.exe /c $command
}