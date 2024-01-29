#Script was made by Naijabourne 

$computer = $env:computername
$userprofiles = Get-childItem ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList’ | % {Get-ItemProperty $_.pspath }
   
Foreach ($userprofile in $userprofiles){ 
	$filearray = @("inscan.xml","indevice.xml")
    $Path = $userprofile.ProfileImagePath + "\AppData\Roaming\Imagenow_old\*"
    $mainpath = $Path0 = $userprofile.ProfileImagePath + "\AppData\Roaming\Imagenow_old"	
    $Path0 = $userprofile.ProfileImagePath + "\AppData\Roaming\Imagenow_old\*xml"
	$Path1 = $userprofile.ProfileImagePath + "\AppData\Roaming\Imagenow"
    $Imagenow = "\\tcses.org\files\Software\_OTHER SOFTWARE\ImageNow TEST ONLY\ImageNow"
    $destination = $userprofile.ProfileImagePath + "\AppData\Roaming"
    $user = ($userprofile.ProfileImagePath).Split('\')[2]
    #$path3 = "C:\$computer\$user"
         If(Test-Path $mainpath){
		Remove-item -recurse $path  -exclude $filearray
        Copy-item -Path $Imagenow -destination $destination -Recurse -force
        Copy-item -Path $Path0 -Destination $Path1 -Force
        New-item -Path "C:\imagenowrename.txt" -ItemType file -force
       }
                Else {
                    Write-host "The File Does Not Exist in" ($userprofile.ProfileImagePath).Split('\')[2]  "on $computer"
                            }
                            }
                            
