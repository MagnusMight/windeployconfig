Write-Host "Scanning $env:COMPUTERNAME for $env:USERNAME Profile" -ForegroundColor Green
NET USE P: \\tcses.org\files\Software\TCSSERVICEFOLDER\INSTALL\USMT\amd64
NET USE Q: \\tcses.org\files\Software\TCSSERVICEFOLDER\INSTALL\USMT\MainStore
New-Item -path "\\tcses.org\files\Software\TCSSERVICEFOLDER\INSTALL\USMT\MainStore\$env:COMPUTERNAME\" -Name "USMT" -ItemType "Directory"
Start-process cmd /c "p:\scanstate.exe q:\$env:COMPUTERNAME /efs:skip /i:p:\miguser.xml /i:p:\migapp.xml /config:P:\config.xml /ue:*\* /ui:TCSES\$env:USERNAME" /o -wait

NET USE P: /DELETE
NET USE Q: /DELETE

