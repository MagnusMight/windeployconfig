#REM==========================================
#REM Change Admin From KACE 
#REM==========================================
#REM Created Date : 01 November 2017
#REM Update Date  : 04 January  2019
#REM Author : Chukwuemeka Evulukwu
#REM 
#REM Script Details:
#REM --------------
#REM  This script will:
#REM       + Select the computer by nasm
#REM       + then create a folder called signature
#REM       + Copy the signature from the store to the signature folder
#REM 
#REM===========================================

$computername = $env:COMPUTERNAME
$IPAddress = Get-WmiObject win32_networkadapterconfiguration | where { $_.ipaddress -like "1*" } | select -ExpandProperty ipaddress | select -First 1
 
<# $Adminname = switch -wildcard ($IPAddress) 
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
 }#>

 $Adminname = switch -wildcard ($computername) 
 {
     "ESXX-*" {"ESAdmin"}
     "PPCH-*" {"PPAdmin"}
     "PPDC-*" {"PPAdmin"}
     "PPIR-*" {"PPAdmin"}
     "DNxX-*" {"DNIAdmin"}
     "DNI-*" {"DNIAdmin"}
     "DNIX-*" {"DNIAdmin"}
     "SAOK-*" {"SBAdmin"}
     "SABL-*" {"SBAdmin"}
     "SUOK-*" {"SBAdmin"}
     "SUSE-*" {"SBAdmin"}
     "PPLA-*" {"PPAdmin"}
     "CLSB-*" {"COLAdmin"}
     "CLVT-*" {"COLAdmin"}
     "POCX-*" {"POAdmin"}
     "10.24*" {"PPAdmin"}
     "PPXA-*" {"PPAdmin"}
     "PPSD-*" {"PPAdmin"}
     "PPWW-*" {"PPAdmin"}	
 }
 $PassFile = switch -wildcard ($Adminname)
 {
  "ES*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\PASSFILE\ESPassword.txt"}
     "PP*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\PASSFILE\PPPassword.txt"}
     "DNI*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\PASSFILE\DNIPassword.txt"}
     "SB*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\PASSFILE\SBPassword.txt"}
     "COL*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\PASSFILE\COLPassword.txt"}
     "PO*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\PASSFILE\POPassword.txt"}	


 }

$KeyFile = switch -wildcard ($Adminname) 
 {
     "ES*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\KEYS\ESAES.key"}
     "PP*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\KEYSPPAES.key"}
     "DNI*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\KEYS\DNIAES.key"}
     "SB*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\KEYS\SBAES.key"}
     "COL*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\KEYS\COLAES.key"}
     "PO*" {"\\tcses.org\files\Software\TCSSERVICEFOLDER\KEYS\POAES.key"}	
 }

#Admin password File Setup
$Key = Get-Content $KeyFile

#Settings for the auto logon process
$PasswordSecured = Get-Content $PassFile | ConvertTo-SecureString -Key $Key
$marshal = [System.Runtime.InteropServices.Marshal]
$bstr = $marshal::SecureStringToBSTR($PasswordSecured)
$pass = $marshal::PtrToStringAuto($bstr) 

$Errorlog = "\\tcses.org\files\Software\TCSSERVICEFOLDER\LOGS\$computername.txt"

try{
$admin=[adsi]"WinNT://./Administrator,user" 
$admin.psbase.rename("$adminname") }
catch {
"ERROR: The username Administrator Does not exist"
}

try{
$admin=[adsi]"WinNT://./Administrtor,user" 
$admin.psbase.rename("$adminname") }
catch {
"ERROR: The username Administrtor Does not exist"
}


([adsi]"WinNT://$computername/$adminname").setpassword($Pass)