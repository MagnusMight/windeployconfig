$computername = $env:COMPUTERNAME
$IPAddress = Get-WmiObject win32_networkadapterconfiguration | where { $_.ipaddress -like "1*" } | select -ExpandProperty ipaddress | select -First 1
 
 $Adminname = switch -wildcard ($IPAddress) 
 {
     "10.18*" {"ESAdmin"}
     "10.16*" {"PPAdmin"}
     "10.17*" {"PPAdmin"}
     "172.16*" {"PPAdmin"}
     "10.32*" {"DNIAdmin"}
     "10.30*" {"SBAdmin"}
     "10.28*" {"PPAdmin"}
     "10.27*" {"COLAdmin"}
     "10.26*" {"COLAdmin"}
     "10.25*" {"POAdmin"}
     "10.24*" {"PPAdmin"}
     "10.23*" {"PPAdmin"}
     "10.21*" {"PPAdmin"}
     "10.20*" {"PPAdmin"}	
 }
 $PassFile = switch -wildcard ($Adminname)
 {
  "ES*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\Changeadmin\ESPassword.txt"}
     "PP*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\Changeadmin\PPPassword.txt"}
     "DNI*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\Changeadmin\DNIPassword.txt"}
     "SB*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\Changeadmin\SBPassword.txt"}
     "COL*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\Changeadmin\COLPassword.txt"}
     "PO*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\Changeadmin\POPassword.txt"}	


 }

$KeyFile = switch -wildcard ($Adminname) 
 {
     "ES*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\Changeadmin\ESAES.key"}
     "PP*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\Changeadmin\PPAES.key"}
     "DNI*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\Changeadmin\DNIAES.key"}
     "SB*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\Changeadmin\SBAES.key"}
     "COL*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\Changeadmin\COLAES.key"}
     "PO*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\Changeadmin\POAES.key"}	
 }

#Admin password File Setup
$Key = Get-Content $KeyFile

#Settings for the auto logon process
$PasswordSecured = Get-Content $PassFile | ConvertTo-SecureString -Key $Key
$marshal = [System.Runtime.InteropServices.Marshal]
$bstr = $marshal::SecureStringToBSTR($PasswordSecured)
$pass = $marshal::PtrToStringAuto($bstr) 


Rename-LocalUser -Name Administrator -NewName $Adminname
([adsi]"WinNT://$computername/$adminname").setpassword($Pass)