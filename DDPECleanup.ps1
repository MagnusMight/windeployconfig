<#Created By Chukwuemeka Evulukwu

switches to determine if its a 1 or a 0 #>

$name = $env:COMPUTERNAME
$install =switch -wildcard ($name)
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
$user = "tcsserviceadmin"

$Path = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
$Path1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI"

<#This is a clean up stage it takes all the edits we placed
and puts it back to the default setting #>
if ($install -eq 1){
Start-Process "cmd.exe" "/c net localgroup administrators $user /delete" -Wait -NoNewWindow
Start-Sleep -Seconds 3

#Restore of Default values
Set-ItemProperty -Path $Path -Name DefaultUserName -Value Administrator
Set-ItemProperty -Path $Path -Name DefaultDomainName -Value $null
Set-itemproperty -Path $path1 -name LastLoggedOnUser -value $null
Set-itemProperty -Path $path1 -name LastLoggedOnSAMUser -value $null

#Power Setting Change
powercfg -import \\tcses.org\files\Software\TCSSERVICEFOLDER\INSTALL\PowerManagement\TCSPOWERPLAN.pow
Start-Sleep -Seconds 3

#Power Setting Set active 
powercfg /setactive e589740c-f61d-4104-a35a-33dafa6db7ea
}

<#If the computer isn't autorized this message will show for a bit and then continue#>
else {
#echo "Cleaning up Leftovers >.>"
Start-Process "cmd.exe" "/c net localgroup administrators $user /delete" -Wait -NoNewWindow
Start-Sleep -Seconds 6

Set-ItemProperty -Path $Path -Name DefaultUserName -Value Administrator
Set-ItemProperty -Path $Path -Name DefaultDomainName -Value $null 
Set-itemproperty -Path $path1 -name LastLoggedOnUser -value $null 
Set-itemProperty -Path $path1 -name LastLoggedOnSAMUser -value $null 
Start-Sleep -Seconds 3
exit
}
exit

