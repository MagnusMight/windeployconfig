$user = "tcsserviceadmin"

$Path = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
$Path1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI"

Start-Process "cmd.exe" "/c net localgroup administrators $user /delete" -Wait -NoNewWindow
Start-Sleep -Seconds 3

#Restore of Default values
Set-ItemProperty -Path $Path -Name DefaultUserName -Value Administrator
Set-ItemProperty -Path $Path -Name DefaultDomainName -Value $null
Set-itemproperty -Path $path1 -name LastLoggedOnUser -value $null
Set-itemProperty -Path $path1 -name LastLoggedOnSAMUser -value $null