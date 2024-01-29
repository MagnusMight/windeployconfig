start-sleep 5

#Getting Chassis type from WIM#
$system = Get-WMIObject -class Win32_systemenclosure

if($system.Manufacturer -like "*Microsoft*"){
Start-Process msiexec /i  "%~dp0SurfaceLaptop2_Win10_17134_1901219085.msi" /qn -Wait -NoNewWindow
Start-Process msiexec /i  "%~dp0Surface_Dock_Updater_v2.23.139.0.msi" /qn -Wait -NoNewWindow
}