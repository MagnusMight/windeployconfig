$computer1 = $env:COMPUTERNAME
 

$mainOU = Switch -Wildcard ($computer1)
{
"PPCH-RM*" {"OU=Classrooms Completed,OU=Classrooms,OU=Public,OU=Desktops,OU=Workstations,OU=Chicago,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPCH-FCLAB*" {"OU=Lab,OU=Forensic Center,OU=Public,OU=Desktops,OU=Workstations,OU=Chicago,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPCH-LB4102*" {"OU=Mart 4102 Lab,OU=Labs,OU=Public,OU=Desktops,OU=Workstations,OU=Chicago,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPCH-LB516*" {"OU=Wells 516 Lab,OU=Labs,OU=Public,OU=Desktops,OU=Workstations,OU=Chicago,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPCH-LB517*" {"OU=Wells 517 lab,OU=Labs,OU=Public,OU=Desktops,OU=Workstations,OU=Chicago,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPCH-LIB*" {"OU=Library,OU=Public,OU=Desktops,OU=Workstations,OU=Chicago,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPCH-SL13-*" {"OU=Mart 13th Floor Student,OU=Lounges,OU=Public,OU=Desktops,OU=Workstations,OU=Chicago,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPCH-SL4080-*" {"OU=Mart 4th Floor Student,OU=Lounges,OU=Public,OU=Desktops,OU=Workstations,OU=Chicago,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPCH-SL507-*" {"OU=Wells 5th Floor Student,OU=Lounges,OU=Public,OU=Desktops,OU=Workstations,OU=Chicago,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPCH-AL*" {"OU=Wells 4th Floor Adjunct,OU=Lounges,OU=Public,OU=Desktops,OU=Workstations,OU=Chicago,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPIR-DS-*" {"OU=Announcement Screens,OU=Public,OU=Desktops,OU=Workstations,OU=Irvine,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPIR-RM*" {"OU=Classrooms,OU=Public,OU=Desktops,OU=Workstations,OU=Irvine,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPIR-CNSLRECPT" {"OU=Irvine Counseling Center,OU=Public,OU=Desktops,OU=Workstations,OU=Irvine,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPIR-INTERN*" {"OU=Irvine Counseling Center,OU=Public,OU=Desktops,OU=Workstations,OU=Irvine,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPIR-RM435-SUPV" {"OU=Irvine Counseling Center,OU=Public,OU=Desktops,OU=Workstations,OU=Irvine,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPIR-RM436-SUPV" {"OU=Irvine Counseling Center,OU=Public,OU=Desktops,OU=Workstations,OU=Irvine,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPIR-LB412*" {"OU=Lab,OU=Public,OU=Desktops,OU=Workstations,OU=Irvine,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPIR-SL410-*" {"OU=Lounge,OU=Public,OU=Desktops,OU=Workstations,OU=Irvine,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPIR-LIB*" {"OU=Library,OU=Public,OU=Desktops,OU=Workstations,OU=Irvine,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPLA-RM*" {"OU=Classrooms,OU=Public,OU=Desktops,OU=Workstations,OU=Los Angeles,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPLA-LB*" {"OU=Labs,OU=Public,OU=Desktops,OU=Workstations,OU=Los Angeles,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPLA-LIB*" {"OU=Labs,OU=Public,OU=Desktops,OU=Workstations,OU=Los Angeles,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPLA-SL804-*" {"OU=8th Floor Student Lounge,OU=Lounges,OU=Public,OU=Desktops,OU=Workstations,OU=Los Angeles,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPDC-LB412-*" {"OU=Lab,OU=Public,OU=Desktops,OU=Workstations,OU=Washington,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPDC-LIB*" {"OU=Library,OU=Public,OU=Desktops,OU=Workstations,OU=Washington,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"PPDC-SL*" {"OU=Study Rooms,OU=Public,OU=Desktops,OU=Workstations,OU=Washington,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"POCX-RM45*" {"OU=45 Eureka,OU=Classrooms,OU=Public,OU=Desktops,OU=Workstations,OU=College,OU=Pacific Oaks,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"POCX-RM55-*" {"OU=55 Eureka,OU=Classrooms,OU=Public,OU=Desktops,OU=Workstations,OU=College,OU=Pacific Oaks,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"POSJ-RM*" {"OU=San Jose,OU=Classrooms,OU=Public,OU=Desktops,OU=Workstations,OU=College,OU=Pacific Oaks,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"POCX-LB45-2-*" {"OU=45 Eureka,OU=Labs,OU=Public,OU=Desktops,OU=Workstations,OU=College,OU=Pacific Oaks,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"POCX-LB55-*" {"OU=55 Eureka,OU=Labs,OU=Public,OU=Desktops,OU=Workstations,OU=College,OU=Pacific Oaks,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"POCX-REG45-*" {"OU=Registration Computers,OU=Public,OU=Desktops,OU=Workstations,OU=College,OU=Pacific Oaks,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"DNIX-RM*" {"OU=Classrooms,OU=Public,OU=Desktops,OU=Workstations,OU=Dallas Nursing Institute,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"DNIX-FASFA*" {"OU=Fin Aid Kiosk,OU=Public,OU=Desktops,OU=Workstations,OU=Dallas Nursing Institute,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"DNIX-HESILAB*" {"OU=HESI,OU=Public,OU=Desktops,OU=Workstations,OU=Dallas Nursing Institute,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"DNIX-RM103-*" {"OU=Lab 103,OU=Public,OU=Desktops,OU=Workstations,OU=Dallas Nursing Institute,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"DNIX-RM201-*" {"OU=Lab 201,OU=Public,OU=Desktops,OU=Workstations,OU=Dallas Nursing Institute,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"DNIX-LIBRARY*" {"OU=Library,OU=Public,OU=Desktops,OU=Workstations,OU=Dallas Nursing Institute,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"DNIX-TV*" {"OU=TVs,OU=Public,OU=Desktops,OU=Workstations,OU=Dallas Nursing Institute,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"CLVX-LIB*" {"OU=Lab,OU=Public,OU=Desktops,OU=Workstations,OU=Ventura,OU=Colleges of Law,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"CLSB-LIB*" {"OU=Public,OU=Desktops,OU=Workstations,OU=Santa Barbara,OU=Colleges of Law,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
}
$IPAddress = Get-WmiObject win32_networkadapterconfiguration | where { $_.ipaddress -like "1*" } | select -ExpandProperty ipaddress | select -First 1 
$ip = Switch -Wildcard ($IPAddress)
{
"10.24*" {"OU=Classrooms Completed,OU=Main,OU=Classrooms,OU=Public,OU=Desktops,OU=Workstations,OU=Washington,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
"10.28*" {"OU=Classrooms Completed,OU=North,OU=Classrooms,OU=Public,OU=Desktops,OU=Workstations,OU=Washington,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
}

# Retrieve DN of local computer.
$SysInfo = New-Object -ComObject "ADSystemInfo"
$ComputerDN = $SysInfo.GetType().InvokeMember("ComputerName", "GetProperty", $Null, $SysInfo, $Null)

# Bind to computer object in AD.
$Computer = [ADSI]"LDAP://$ComputerDN"

# Specify target OU.
$TargetOU = if ($IPAddress -eq "10.24*","10.28") {
    $ip
    }
else {
$mainOU
   }

# Bind to target OU.
$OU = [ADSI]"LDAP://$TargetOU"
$Computer.psbase.MoveTo($OU)