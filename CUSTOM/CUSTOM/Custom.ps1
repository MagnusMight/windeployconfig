###==================================================
### Customize windows 10
###==================================================
### Date   : 03 Jan 2019
### Author : Chukwuemeka Evulukwu
### 
### Script Details:
### --------------
###  This is a windows 10 customization Script
###        
###        
###           
###      
### 
###===========================================
#Changes Layout of Start Menu
Write-Host "Beginning the Customazation process..." -fore Yellow
start-sleep -Seconds 5
Write-Host "Starting the Start Layout Modification" -fore Yellow
start-sleep -Seconds 5
Import-StartLayout -LayoutPath C:\Kace\applications\108\custom\Win10layout.xml -MountPath $env:SystemDrive\
Write-host "Completed Start Mod.."
start-sleep -Seconds 5


# Disable Hibernate
Write-Host "Disabling Hibernate..." -ForegroundColor Green
start-sleep -Seconds 5
Write-Host ""
POWERCFG -h off
Write-Host "Finished Disabling Hibernate" -ForegroundColor Green

# Disable IE First Run Wizard:
Write-Host "Disabling IE First Run Wizard..." -ForegroundColor Green
Write-Host ""
New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft' -Name 'Internet Explorer' | Out-Null
New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer' -Name 'Main' | Out-Null
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main' -Name DisableFirstRunCustomize -PropertyType DWORD -Value '1' | Out-Null

# Change Explorer Default View:
Write-Host "Configuring Windows Explorer..." -ForegroundColor Green
Write-Host ""
New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' -PropertyType DWORD -Value '1' | Out-Null

Write-host "Customazation Completed. Script Exiting.." -fore Green
exit