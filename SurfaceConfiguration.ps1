start-sleep 5

#Getting Chassis type from WIM#
$system = Get-WMIObject -class Win32_systemenclosure

if($system.Manufacturer -like "*Microsoft*"){
cmd.exe /c  "Start /wait msiexec /i %~dp0SurfaceLaptop2_Win10_17134_1901219085.msi /qn /norestart" 
cmd.exe /c "Start /wait msiexec /i %~dp0surface_Dock_Updater_v2.23.139.0.msi /qn /norestart"
}
Else{
Write-Host "Not a Surface, Successfull"
}