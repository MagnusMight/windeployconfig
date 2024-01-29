$compname = $env:COMPUTERNAME
$domip = switch -Wildcard ($compname)
{
"ESXX-*" {"10.16.108.31"}
"CLSB-*" {"10.26.0.31"}
"CLVT-*" {"10.26.0.31"}
"DNI-*" {"10.32.0.31"}
"PPIR-*" {"10.23.108.31"}
"PPLA-*" {"10.20.0.31"}
"PPDC-*" {"10.20.0.31"}
"PPWW-*" {"10.21.0.31"}
"POCS-*" {"10.21.0.31"}
"POCX-*" {"10.31.108.31"}
"SAOK-*" {" 10.30.0.31"}
"PPCH-*" {"10.16.108.31"}
}


$credential = New-Object System.Management.Automation.PsCredential("tcses.org\tcsserviceadmin", (ConvertTo-SecureString "Technician1" -AsPlainText -Force))
$domaininfo = New-Object DirectoryServices.DirectoryEntry("LDAP://$domip","tcses\tcsserviceadmin","Technician1")
$searcher = New-Object System.DirectoryServices.DirectorySearcher($domaininfo)
$searcher.filter = "(cn=$compname)"
$searchparm = $searcher.FindOne() 



$Dom = "tcses.org"


If($searchparm -eq $null){
    Add-Computer -DomainName $Dom -Credential $credential -Force
    }
else {
    $LDAP = ([ADSI]'LDAP://rootDSE').defaultNamingContext.value
    $searcher=[adsisearcher] "(&(objectclass=computer)(name=$Compname))"            
    $searcher.SearchRoot="LDAP://$LDAP"
    $searcher.FindAll() | %{$_.GetDirectoryEntry() } | %{$_.DeleteObject(0)} 
    
    Start-sleep 10
    
    Add-Computer -DomainName $Dom -Credential $credential -Force
    }
$Path = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
$username = "tcses\tcsserviceadmin"
$user = "tcsserviceadmin"
$pass = "Technician1"


#Write-Host "Adding the Domain User to Local Admin" -fore Green
Start-Process "cmd.exe" "/c net localgroup administrators $username /add" -Wait -NoNewWindow 
Start-Sleep -Seconds 4

#Write-Host "Assigning the domain user to auto log" -fore Green
Set-ItemProperty -Path $Path -Name DefaultUserName -Value $user | Out-NULL
Set-ItemProperty -Path $Path -Name DefaultDomainName -Value tcses.org | Out-NULL
New-ItemProperty -Path $Path -Name DefaultPassword -Value $pass | Out-NULL
Start-Sleep -Seconds 3
