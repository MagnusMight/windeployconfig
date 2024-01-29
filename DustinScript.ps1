$userprofiles = Get-childItem ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList’ | % {Get-ItemProperty $_.pspath } 

Foreach ($userprofile in $userprofiles){ 
    $Path = $userprofile.ProfileImagePath + "\AppData\Roaming\Imagenow\inscan.xml"
        If(Test-Path $Path){
            (Get-Content $Path).Replace("Human Resources ADP", 'HR Workday') | Set-Content $Path
                }
                Else {
                    Write-host "There is no File in $path"
                            }
                    }
