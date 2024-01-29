#Created By Chukwuemeka Evulukwu
Start-sleep -Seconds 10
#switches to determine if its a 1 or a 0 
$name = $env:COMPUTERNAME
$install = switch -wildcard ($name)
{
"ESXX-D*" {0}
"ESXX-L*" {1}
"PPCH-D*" {0}
"PPCH-L*" {0}
"DNI-L*" {0}
"DNI-D*" {0}
"SAOK-L*" {0}
"SAOK-D*" {0}
"PPDC-L*" {0}
"PPDC-D*" {0}
"CLVT-L*" {0}
"CLVT-D*" {0}
"CLSB-L*" {0}
"CLSB-D*" {0}
"POCX-D*" {0}
"POCX-L*" {0}
"PPIR-D*" {0}
"PPIR-L*" {0}
"PPWW-L*" {0}
"PPWW-D*" {0}
"PPLA-D*" {0}
"PPLA-L*" {0}
}

#checks for the arch to go to the right folder to grab info.
$Arch = (Get-WmiObject win32_operatingsystem).OSArchitecture

#checks for the os
$os = (Get-WmiObject -class Win32_OperatingSystem).Caption

$Regpath = "HKLM:\System\CurrentControlSet\Services\CmgShieldCEF"

<#
* First it sits a path for it to goto in the registry
* Next it puts the new values and creates value if it doesnt exist
* Then it creates a new DDPE path on the c drive so it can run properly
* then it begins the bat file and installs DDPE The Tcses.org location needs to be available#>
if ($install -eq 1){
#Preparing to install DDPE
Start-Sleep -Seconds 3
New-Item -path $Regpath -Force | Out-Null
New-ItemProperty -Path $Regpath -Name EnableW2kMode  -Value 1 -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $Regpath -Name UseIppFlags -Value 2 -PropertyType DWORD -Force | Out-Null
New-Item -Path c:\DDPE -ItemType directory | Out-Null
Start-sleep -Seconds 6
Copy-Item -Path \\tcses.org\files\Software\DDPEInstall\AutoInstallKBOX\$Arch\$os\* -Destination c:\DDPE -Force | Out-Null
Start-sleep -Seconds 6

#installing DDPE now
Start-Process C:\DDPE\DELLDPEinstall_silent.bat -Wait -NoNewWindow | Out-Null
Start-Sleep -Seconds 3
}

<#If the computer isn't autorized this message will show
for a bit and then continue#>

Else
{
Write-host "skipped" -fore Green
exit
}
exit