$name = $env:COMPUTERNAME

#this switch chages the WUserver and WUstatusserver.
$wsus = switch -Wildcard ($name)
{
 "ESXX-*" {"http://chi350-wsus1"}
 "PPCH-*" {"http://chi325-WSUS1"}
 "DNI-*" {"http://dni-wsus01"}
 "SAOK-*" {"http://SAY-WSUS1"}
 "PPDC-*" {"http://wdcm-wsus01"}
 "CLVT-*" {"http://CLVT-wsus01"}
 "CLSB-*" {"http://clsb-wsus01"}
 "POCX-*" {"http://poc-wsus01"}
 "PPIR-*" {"http://PPIR-wsus01"}
 "PPWW-*" {"http://PPWW-wsus01"}
 "PPLA-*" {"http://PPLA-WSUS1"}
}

#changes the target groups
<#$targetgroup = switch -Wildcard ($name)
{
"ESXX-*" {"TCS Education System"}
 "PPCH-*" {"Chicago"}
 "DNI-*" {"Dallas Nursing Institute"}n
 "SAOK-*" {"Saybrook"}
 "PPDC-*" {"Washington"}
 "CLVT-*" {"Ventura"}
 "CLSB-*" {"Santa Barbara"}
 "POCX-*" {"http://poc-wsus01"}
 "PPIR-*" {"http://PPIR-wsus01"}
 "PPWW-*" {"http://PPWW-wsus01"}
 "PPLA-*" {"http://PPLA-WSUS1"}
}#>

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
$wsusreg = Get-ItemProperty  -Path $RegPath -Name WUServer
$ws = $wsusreg.WUServer
$pathExist = Test-Path $RegPath


#Checks to see if the computer polices have been applied inorder to grab updates from wsus
Write-Debug("Windows Update is Running")

if ($pathExist -EQ $True){
Write-Debug ("Windows update Group Policies has been applied No need For Assignment.") 
Start-Sleep 7
Write-Host("The Assigned WSUS is $ws") -ForegroundColor Green
}
Else {
Write-Host (" Windows Update Group Policies has not been applied. Applying manually...") -fore Red
Start-Process "C:\Windows\System32\gpupdate.exe" -Wait -NoNewWindow
Write-Host("The WSUS Assignment has been Forced and is now $wsus") -ForegroundColor green
}


Start-Sleep -Seconds 4

$UpdateSession = New-Object -Com Microsoft.Update.Session
$UpdateSearcher = $UpdateSession.CreateUpdateSearcher()
 
Write-Host("Searching for applicable updates...") -ForegroundColor Green
 
$SearchResult = $UpdateSearcher.Search("IsAssigned=1 and IsHidden=0 and IsInstalled=0")
 
Write-Host("")
Write-Debug("List of applicable items on the machine:") 
For ($X = 0; $X -lt $SearchResult.Updates.Count; $X++){
    $Update = $SearchResult.Updates.Item($X)
    Write-Host( ($X + 1).ToString() + "&gt; " + $Update.Title)
}
 
If ($SearchResult.Updates.Count -eq 0) {
   Write-Host("There are no applicable updates.") 
    Start-Sleep -Seconds 7
    Exit
}
#Write-Host("")
#Write-Host("Creating collection of updates to download:") -Fore Green
 
$UpdatesToDownload = New-Object -Com Microsoft.Update.UpdateColl
 
For ($X = 0; $X -lt $SearchResult.Updates.Count; $X++){
    $Update = $SearchResult.Updates.Item($X)
    #Write-Host( ($X + 1).ToString() + "&gt; Adding: " + $Update.Title)
    $Null = $UpdatesToDownload.Add($Update)
}
 
Write-Host("")
Write-Host("Downloading Updates...")  
 
$Downloader = $UpdateSession.CreateUpdateDownloader()
$Downloader.Updates = $UpdatesToDownload
$Null = $Downloader.Download()
 
#Write-Host("")
#Write-Host("List of Downloaded Updates...") -Fore Green
 
$UpdatesToInstall = New-Object -Com Microsoft.Update.UpdateColl
 
For ($X = 0; $X -lt $SearchResult.Updates.Count; $X++){
    $Update = $SearchResult.Updates.Item($X)
    If ($Update.IsDownloaded) {
        #Write-Host( ($X + 1).ToString() + "&gt; " + $Update.Title)
        $Null = $UpdatesToInstall.Add($Update)        
    }
}
 
$Install = [System.String]$Args[0]
$Reboot  = [System.String]$Args[1]
 
If (!$Install){
    $Install = Read-Host("Would you like to install these updates now? (Y/N)")
}
 
If ($Install.ToUpper() -eq "Y" -or $Install.ToUpper() -eq "YES"){
    Write-Host("")
    Write-Host("Installing Updates...") -ForegroundColor Green
 
    $Installer = $UpdateSession.CreateUpdateInstaller()
    $Installer.Updates = $UpdatesToInstall
 
    $InstallationResult = $Installer.Install()
 
    Write-Host("")
    Write-Host("List of Updates Installed with Results:") -ForegroundColor Green
 
    For ($X = 0; $X -lt $UpdatesToInstall.Count; $X++){
        Write-Host($UpdatesToInstall.Item($X).Title + ": " + $InstallationResult.GetUpdateResult($X).ResultCode)
    }
 
    Write-Host("")
    Write-Host("Installation Result: " + $InstallationResult.ResultCode)
 
    If ($InstallationResult.RebootRequire -eq $True){
        If (!$Reboot){
            $Reboot = Read-Host("Would You Like To Reboot (Y/N)")
        }
 
        If ($Reboot.ToUpper() -eq "Y" -or $Reboot.ToUpper() -eq "YES"){
            Write-Host("")
            Write-Host("Rebooting...") -ForegroundColor Green
            (Get-WMIObject -Class Win32_OperatingSystem).Reboot()
        }
    }
}
