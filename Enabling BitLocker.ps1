gpupdate /target:computer /force
start-sleep 10
$computername = $env:COMPUTERNAME
$hardwaretype = Get-WmiObject -Class Win32_ComputerSystem -Property PCSystemType

if ($hardwaretype -ne 2)
{
echo "$computername is a Desktop Skipping...."
}
Else{
echo "$computername is a Laptop Enabling BitLocker..."
Enable-Bitlocker -MountPoint c: -UsedSpaceOnly -SkipHardwareTest -RecoveryPasswordProtector
}