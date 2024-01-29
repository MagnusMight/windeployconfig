#REM=================================================================
#REM Deleting machine of domain and Renaming a Machine (if required)
#REM=================================================================
#REM Date Created: 02 November 2017
#REM Date updated: 01 Jan 2019
#REM Author : Chukwuemeka Evulukwu
#REM 
#REM Script Details:
#REM --------------
#REM  This script will:
#REM       + Reaching for the Variable file 
#REM       + Check to see if the computer's true name exist on domain
#REM       + If it does it will delete the entry and replace it with this one 
#REM       + But if the Computer true name matches the name 
#REM             attemting to create then it ignores the rule
#REM 
#REM===========================================

Start-Sleep -s 25

Import-Module \\tcses.org\files\Software\TCSSERVICEFOLDER\Variable\Var.ps1

if ($computername -ne $FullName){
$LDAP = ([ADSI]'LDAP://rootDSE').defaultNamingContext.value
$searcher=[adsisearcher] "(&(objectclass=computer)(name=$FullName))"            
$searcher.SearchRoot="LDAP://$LDAP"
$searcher.FindAll() | %{$_.GetDirectoryEntry() } | %{$_.DeleteObject(0)} 

#waiting for settings to apply 
Start-Sleep -Seconds 75

#rename
Rename-Computer -NewName $Fullname -Force
start-sleep -Seconds 20
}
else
{
echo "Next"
exit
}
exit