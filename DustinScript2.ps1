#Script was made by Naijabourne 

$computer = $env:computername
New-PSDrive -Name P -PSProvider FileSystem -Root \\tcses.org\files\ES\PerceptiveContent\ISCANFILES -Persist
$userprofiles = Get-childItem ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList’ | % {Get-ItemProperty $_.pspath }
 $path2 = "P:\$computer"
   
 If(Test-Path $Path2){
         Write-host "$Computer already has folder in this location"
        }
        else{
Foreach ($userprofile in $userprofiles){ 
    $Path = $userprofile.ProfileImagePath + "\AppData\Roaming\Imagenow\inscan.xml"
    $DeviceScan =  $userprofile.ProfileImagePath + "\AppData\Roaming\Imagenow\indevice.xml"
    $user = ($userprofile.ProfileImagePath).Split('\')[2]
    $path3 = "P:\$computer\$user"
         If(Test-Path $Path){
        New-Item P:\$env:computername\$user -ItemType directory
        Copy-Item $Path -Destination $path3
       }
                Else {
                    Write-host "The File Does Not Exist in" ($userprofile.ProfileImagePath).Split('\')[2]  "on $computer"
                            }
        If(Test-Path $DeviceScan){
        Copy-Item $DeviceScan -Destination $path3
        }
        Else {
        Write-host ($userprofile.ProfileImagePath).Split('\')[2] "Doesn't Have a Device Scan"
             }
                            }
                            }
Remove-PSDrive P
