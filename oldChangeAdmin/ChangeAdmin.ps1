
#Admin password File Setup
$Key = Get-Content $KeyFile

#Settings for the auto logon process
$PasswordSecured = Get-Content $PassFile | ConvertTo-SecureString -Key $Key
$marshal = [System.Runtime.InteropServices.Marshal]
$bstr = $marshal::SecureStringToBSTR($PasswordSecured)
$pass = $marshal::PtrToStringAuto($bstr) 


Rename-LocalUser -Name Administrator -NewName $Adminname
([adsi]"WinNT://$computername/$adminname").setpassword($Pass)