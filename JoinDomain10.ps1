
$computername = $env:computername
$IPAddress = Get-WmiObject win32_networkadapterconfiguration | where { $_.ipaddress -like "1*" } | select -ExpandProperty ipaddress | select -First 1
 
 #Getting Chassis type from WIM#
$system = Get-WMIObject -class Win32_systemenclosure

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
     "10.22*" {"PPLA"}
     "10.35*" {"PPSD"}
     "10.31*" {"PPSJ"}	
	 }

#Getting Serial Number from Computer trhough WIM#
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

#Creating Full Name For Computer#
$FullName=$PCName+"-"+$type+$SerialNum

#Get computer name from local enviromental variables
$Dom = "tcses.org"
$os = (Get-WmiObject Win32_OperatingSystem).caption

#Creating OU String
$OU = Switch -wildcard ($FullName)
{
 "ESXX-L*" {"OU=Laptops,OU=Workstations,OU=TCS Education System,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
 "ESXX-D*" {"OU=Desktops,OU=Workstations,OU=TCS Education System,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
 "CLSB-L*" {"OU=Laptops,OU=Workstations,OU=Santa Barbara,OU=Colleges of Law,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "CLSB-D*" {"OU=Desktops,OU=Workstations,OU=Santa Barbara,OU=Colleges of Law,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
 "CLVT-L*" {"OU=Laptops,OU=Workstations,OU=Ventura,OU=Colleges of Law,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "CLVT-D*" {"OU=Desktops,OU=Workstations,OU=Ventura,OU=Colleges of Law,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
 "PPRI-L*" {"OU=Laptops,OU=Workstations,OU=Richardson,OU=The Chicago School,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "PPRI-D*" {"OU=Desktops,OU=Workstations,OU=Dallas Nursing Institute,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
 "POCS-L*" {"OU=Laptops,OU=Workstations,OU=Children's School,OU=Pacific Oaks,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "POCS-D*" {"OU=Desktops,OU=Workstations,OU=Childrens School,OU=Pacific Oaks,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
 "POCX-L*" {"OU=Laptops,OU=Workstations,OU=College,OU=Pacific Oaks,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "POCX-D*" {"OU=Desktops,OU=Workstations,OU=College,OU=Pacific Oaks,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG"}
 "SAOK-L*" {"OU=Laptops,OU=Workstations,OU=Saybrook,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "SAOK-D*" {"OU=Desktops,OU=Workstations,OU=Saybrook,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "PPCH-L*" {"OU=Laptops,OU=Workstations,OU=Chicago,OU=The Chicago School,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "PPCH-D*" {"OU=Desktops,OU=Workstations,OU=Chicago,OU=The Chicago School,OU=Client Production,OU=NewAD,DC=TCSES,DC=ORG                                                            "}
 "PPIR-L*" {"OU=Laptops,OU=Workstations,OU=Irvine,OU=The Chicago School,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "PPIR-D*" {"OU=Desktops,OU=Workstations,OU=Irvine,OU=The Chicago School,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "PPLA-L*" {"OU=Laptops,OU=Workstations,OU=Los Angeles,OU=The Chicago School,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "PPLA-D*" {"OU=Desktops,OU=Workstations,OU=Los Angeles,OU=The Chicago School,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "PPDC-L*" {"OU=Laptops,OU=Workstations,OU=Washington,OU=The Chicago School,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "PPDC-D*" {"OU=Desktops,OU=Workstations,OU=Washington,OU=The Chicago School,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "PPWW-L*" {"OU=Laptops,OU=Workstations,OU=Westwood,OU=The Chicago School,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 "PPWW-D*" {"OU=Desktops,OU=Workstations,OU=Westwood,OU=The Chicago School,OU=Client Production,OU=NEWAD,DC=TCSES,DC=ORG"}
 }

$domip = switch -Wildcard ($FullName)
{
"ESXX-*" {"10.18.108.32"}
"CLSB-*" {"10.26.108.31"}
"CLVT-*" {"10.26.108.31"}
"PPRI-*" {"10.36.108.31"}
"PPIR-*" {"10.23.108.31"}
"PPLA-*" {"10.20.108.31"}
"PPDC-*" {"10.24.108.31"}
"PPWW-*" {"10.21.108.31"}
"POCS-*" {"10.21.108.31"}
"POCX-*" {"10.25.108.31"}
"SAOK-*" {" 10.30.108.31"}
"PPCH-*" {"10.16.108.31"}
"WDCN-*" {"10.28.108.31"}
}

#Credential Info
$Username = "tcses.org\tcsserviceadmin"
$PassFile = "C:\KACE\Applications\110\POWERSHELL\AESpass.txt"
$KeyFile = "C:\KACE\Applications\110\POWERSHELL\AES.key"
$Key = Get-Content $KeyFile
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, (Get-Content $PassFile | ConvertTo-SecureString -key $Key)

#Settings for the auto logon process
$PasswordSecured = Get-Content $PassFile | ConvertTo-SecureString -Key $Key
$marshal = [System.Runtime.InteropServices.Marshal]
$bstr = $marshal::SecureStringToBSTR($PasswordSecured)
$Path = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
$username = "tcses\tcsserviceadmin"
$user = "tcsserviceadmin"
$pass = $marshal::PtrToStringAuto($bstr) 

#LDAP Searching for computer device
$domaininfo = New-Object DirectoryServices.DirectoryEntry("LDAP://$domip","$username","$pass")
$searcher = New-Object System.DirectoryServices.DirectorySearcher($domaininfo)
$searcher.filter = "(cn=$fullname)"
$searchparm = $searcher.FindOne()

#Write-Host "Assigning the domain user to auto log" -fore Green
Set-ItemProperty -Path $Path -Name DefaultUserName -Value $user | Out-NULL
Set-ItemProperty -Path $Path -Name DefaultDomainName -Value tcses.org | Out-NULL
New-ItemProperty -Path $Path -Name DefaultPassword -Value $Pass | Out-NULL
Start-Sleep -Seconds 10

#Clears the Memory
$Marshal::ZeroFreeBSTR($Bstr)

#adds the computer to the domain or restablishing domain relationship
if (!($searchparm)){
#if the computer is not found on the domain
Add-Computer -DomainName $Dom -Credential $credential -OUPath $OU -NewName $FullName -Force
}
else {
#if the comuter is found on the domain
Add-Computer -DomainName $Dom -Credential $credential -OUPath $OU -Force
Write-Host "Domain Relationship Sucessfully Established" -fore Green
Start-Sleep -Seconds 5
}

#Running GP update
gpupdate