#Script was made by Naijabourne 

$computer = $env:computername
#New-Item C:\$computer -ItemType directory

$userprofiles = Get-childItem ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList’ | % {Get-ItemProperty $_.pspath }
 $Version = (Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\imagenow").displayversion
 $newversion = 
   
 If($Version -eq $newversion){
         Write-host "$Computer already has $version"
        }
        else{
Foreach ($userprofile in $userprofiles){ 
    $Path = $userprofile.ProfileImagePath + "\AppData\Roaming\Imagenow"
    #$DeviceScan =  $userprofile.ProfileImagePath + "\AppData\Roaming\Imagenow\indevice.xml"
    $user = ($userprofile.ProfileImagePath).Split('\')[2]
    #$path3 = "C:\$computer\$user"
         If(Test-Path $Path){
        Rename-Item $Path -NewName Imagenow_old 
       }
                Else {
                    Write-host "The File Does Not Exist in" ($userprofile.ProfileImagePath).Split('\')[2]  "on $computer"
                            }
                            }
                            }
