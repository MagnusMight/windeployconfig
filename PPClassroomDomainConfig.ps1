$computername = $env:COMPUTERNAME
$compname = get-content C:\KACE\Applications\compName.txt
Write-Host "Waiting for Network Adapter..." -fore Green
Start-Sleep -s 10

#Getting the IP address from wim to set Prefix for Entity#

Start-Sleep -s 15


if ($computername -ne $compname)
{

$LDAP = ([ADSI]'LDAP://rootDSE').defaultNamingContext.value
$searcher=[adsisearcher] "(&(objectclass=computer)(name=$compname))"            
$searcher.SearchRoot="LDAP://$LDAP"
$searcher.FindAll() | %{$_.GetDirectoryEntry() } | %{$_.DeleteObject(0)} 

#waiting for settings to apply 
Start-Sleep -Seconds 60

#rename
Rename-Computer -NewName $compname

start-sleep -Seconds 7
}
else
{
Write-host "Configured"

exit
}
exit