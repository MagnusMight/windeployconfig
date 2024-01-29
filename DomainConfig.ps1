Start-Sleep -s 25

#Getting the IP address from wim to set Prefix for Entity#
$computername = $env:COMPUTERNAME
$IPAddress = Get-WmiObject win32_networkadapterconfiguration | where { $_.ipaddress -like "1*" } | select -ExpandProperty ipaddress | select -First 1
 
$PCName=switch -wildcard ($IPAddress)
       {

     "10.18*" {"ESXX"}
     "10.16*" {"PPCH"}
     "10.17*" {"PPCH"}
     "172.16*" {"PPCH"}
     "10.36*" {"PPRI"}
     "10.30*" {"SAOK"}
     "10.28*" {"PPDC"}
     "10.27*" {"CLVT"}
     "10.26*" {"CLSB"}
     "10.25*" {"POCX"}
     "10.24*" {"PPDC"}
     "10.23*" {"PPIR"}
     "10.21*" {"PPWW"}
     "10.20*" {"PPLA"}	
	  }
#Getting Chassis type from WIM#
$system = Get-WMIObject -class Win32_systemenclosure

#Getting Serial Number from Computer though WIM#
$SerialFull=(Get-WmiObject win32_bios).serialnumber
if($system.Manufacturer -like "*Dell*"){
$SerialNum=$SerialFull
}
Else{
$SerialNum=$SerialFull.Substring($SerialFull.Length - 9)
}

$type = Switch ($system.chassistypes)
{
  "1" {“D”}
  "3" {“D"}
  "4" {“D”}
  "5" {“D”}
  "6" {“D”}
  "7" {“D”}
  "8" {“L”}
  "9" {“L”}
  "10" {“L”}
  "11" {“H”} #{"Chassis type is: $type - Handheld"}#
  "13" {“D”} #{"Chassis type is: $type - All-in-One"}#
  "14" {“L”} #{"Chassis type is: $type - Sub-Notebook"}#
  "15" {“D”} #{"Chassis type is: $type - Space Saving"}#
  "16" {“D”} #{"Chassis type is: $type - Lunch Box"}#
  "17" {“S”} #{"Chassis type is: $type - Main System Chassis"}#
  "18" {“S”} #{"Chassis type is: $type - Expansion Chassis"}#
  "19" {“S”} #{"Chassis type is: $type - Sub-Chassis"}#
  "20" {“S”} #{"Chassis type is: $type - Bus Expansion Chassis"}#
  "21" {“S”} #{"Chassis type is: $type - Peripheral Chassis"}#
  "22" {“S”} #{"Chassis type is: $type - Storage Chassis"}#
  "23" {“S”} #{"Chassis type is: $type - Rack Mount Chassis"}#
  "24" {“D”} #{"Chassis type is: $type - Sealed-Case PC"}#
    }

#Creating Full Name For Computer
$FullName=$PCName+"-"+$type+$SerialNum

#Get computer name from local enviromental variables
$Dom = "tcses.org"

if ($computername -ne $FullName){
$LDAP = ([ADSI]'LDAP://rootDSE').defaultNamingContext.value
$searcher=[adsisearcher] "(&(objectclass=computer)(name=$FullName))"            
$searcher.SearchRoot="LDAP://$LDAP"
$searcher.FindAll() | %{$_.GetDirectoryEntry() } | %{$_.DeleteObject(0)} 

#waiting for settings to apply 
Start-Sleep -Seconds 35

#rename
Rename-Computer -NewName $Fullname
start-sleep -Seconds 20
}
else
{
echo "Next"
exit
}
exit