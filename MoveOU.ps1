# Retrieve DN of local computer.
$SysInfo = New-Object -ComObject "ADSystemInfo"
$ComputerDN = $SysInfo.GetType().InvokeMember("ComputerName", "GetProperty", $Null, $SysInfo, $Null)

# Bind to computer object in AD.
$Computer = [ADSI]"LDAP://$ComputerDN"

# Specify target OU.
$TargetOU = {"ou=Windwos10_Test,ou=Test,ou=TCS Education System,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}

# Bind to target OU.
$OU = [ADSI]"LDAP://$TargetOU"
$Computer.psbase.MoveTo($OU)