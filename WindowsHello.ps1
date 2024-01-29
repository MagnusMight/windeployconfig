$system = Get-WMIObject -class Win32_systemenclosure

if($system.Manufacturer -like "*Microsoft*"){
    Set-Location -path HKLM:\SOFTWARE\Policies\Microsoft\Windows
    $path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\system"
    $name = "AllowDomainPINLogon"
    $value = 1
    $type= "DWord"
    New-Itemproperty -path $path -name $name -value $value -propertytype $type
}
Else {
    Write-Host "This is a DELL" -BackgroundColor DarkYellow
     
}