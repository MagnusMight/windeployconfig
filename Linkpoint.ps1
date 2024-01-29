#made by Naijabourne


#Get the users name.
$user = (Get-WMIObject -class Win32_ComputerSystem | select username).username
$Username = $user.Substring(6)

#variable for path
$path = "C:\Users\$username\AppData\Roaming\LinkPoint360"

#stopping Processes before beginning
Write-host "Stopping processes" -ForegroundColor White
#this is an option if you want to alert users that this is will stop outlook
#[System.Windows.MessageBox]::Show('PLEASE CLOSE YOUR DRAFT EMAILS AND THINGS YOU NEED TO SAVE FROM OUTLOOK BEFORE WE CLOSE IT. Please Hit Ok after closing outlook','IT Services')
Stop-Process -Name OUTLOOK -Force
Stop-Process -Name LinkPointAssist -Force

#if statement for the rest of the installation. this is if it should configure only or install and configure
if (Test-Path $path){
            Write-host "This HAs been installed Moving to Configuration Steps..." -ForegroundColor White
            Remove-Item -path C:\Users\$username\AppData\roaming\linkpoint360\Salesforce.schema -Force
            Copy-Item -Path \\stuff\Software\LinkPoint\* -Destination  C:\Users\$username\AppData\roaming\linkpoint360 -Force 
            Start-Process -FilePath "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE" -Wait
            Start-Process -FilePath "C:\Users\$username\AppData\Roaming\LinkPoint360\Bin\LinkPointAssist.exe" -wait
        }
Else{
            Write-host "Begin installing..." -ForegroundColor White
            Start-Process -FilePath \\tcses.org\files\Dept\Public\Linkpoint360\Install\LinkPointInstall.vbs
            
            #To pause and wait for an install to be completed 
            Write-host "Waiting for installer..." -ForegroundColor White
            Start-Sleep 30
            Write-host "Starting the config steps..." -ForegroundColor White
            
            #finishing steps
            Remove-Item -path C:\Users\$username\AppData\roaming\linkpoint360\* -Filter *Salesforce.schema* -Recurse
            Copy-Item -Path \\stuff\Software\LinkPoint\* -Destination  C:\Users\$username\AppData\roaming\linkpoint360 -Force 
            Start-Process -FilePath "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE" -Wait
            Start-Process -FilePath "C:\Users\$username\AppData\Roaming\LinkPoint360\Bin\LinkPointAssist.exe" -wait
}