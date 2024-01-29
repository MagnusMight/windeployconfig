#First Form 
Add-Type -AssemblyName system.windows.forms
$formSchool = New-Object System.Windows.Forms.Form
$formSchool.Text = "Computer Configuration"
$formSchool.AutoSizeMode = "Growandshrink"
$formSchool.AutoSize = $true
$formSchool.StartPosition = "CenterScreen"

#This controls the ok button Location and size and function
$OkButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = new-object System.Drawing.Size(200,50)
    $OKButton.Size = new-object System.Drawing.Size(100,20)
    $OKButton.Text = "OK"
    $OkButton.add_click({
    $OKButton.DialogResult = "OK" 
    $formSchool.Close()
    })
    $formSchool.Controls.Add($OKButton)

$dropdownarry = @(
"Please Select School",
"College's of Law Santa Barbara",
"College's of Law Ventura",
"Pacific Oaks College Main",
"Pacific Oaks College San Jose",
"Chicago School Chicago",
"Chicago School Washington",
"Chicago School Irvine",
"Chicago School LA",
"Chicago School RI"
)

$DropdownBoxSchool = New-Object System.Windows.Forms.combobox
$DropdownBoxschool.Text = "Select School"
$DropdownBoxSchool.Location = New-Object System.Drawing.Size(130,10)
$DropdownBoxSchool.Size = New-Object System.Drawing.Size(180,10)
$DropdownBoxSchool.DropDownStyle =  [System.Windows.Forms.ComboBoxStyle]::DropDownlist;
$DropdownBoxSchool.Items.AddRange($dropdownArry)
$DropdownBoxSchool.SelectedIndex = 0;
$formSchool.Controls.Add($DropdownBoxSchool)

$dropdownArray2 = @(
"TYPE"
"Room", <##>
"Lab",
"Library",
"Student Lounge",
"Adjunct Lounge",
"Digital Signage"
)

$DropdownBoxTYPE = New-Object System.Windows.Forms.combobox

$DropdownBoxTYPE.Location = New-Object System.Drawing.Size(310,10)
$DropdownBoxTYPE.Size = New-Object System.Drawing.Size(100,10)
$DropdownBoxTYPE.Items.AddRange($dropdownArray2)
$DropdownBoxTYPE.DropDownStyle =  [System.Windows.Forms.ComboBoxStyle]::DropDownList; 
$DropdownBoxTYPE.SelectedIndex = 0;
$formSchool.Controls.Add($DropdownBoxTYPE)

$comboBoxSchool = New-Object System.Windows.Forms.textbox
$comboBoxschool.Text = "Room#,Lab#,ETC"
$comboBoxSchool.Location = New-Object System.Drawing.Size(410,10)
$comboBoxschool.Size = New-Object System.Drawing.Size(100,30)
$formSchool.Controls.Add($comboBoxSchool)

$dropdownArray3 = @("Computer # If applicable","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","29","30","31","32","33","34","35","36","37","38","39","40")
$ComboboxNumber = New-Object System.Windows.Forms.combobox 
$ComboboxNumber.Location = New-Object System.Drawing.Size(510,10) 
$ComboboxNumber.Size = New-Object System.Drawing.Size(140,30)
$ComboboxNumber.Items.AddRange($dropdownArray3)
$ComboboxNumber.DropDownStyle =  [System.Windows.Forms.ComboBoxStyle]::DropDownList; 
$ComboboxNumber.SelectedIndex = 0;
$Formschool.Controls.Add($ComboboxNumber) 

$comboBoxSchoolLabel = New-Object System.Windows.Forms.Label
$comboBoxSchoolLabel.Location = New-Object System.drawing.size(10,10)
$comboBoxSchoolLabel.Size = New-Object System.Drawing.Size(100,40)
$comboBoxSchoolLabel.Text = "Enter the New ComputerName"
$formSchool.Controls.Add($comboBoxSchoolLabel)



    $Formschool.Add_Shown({$Formschool.Activate()})
    $result = $Formschool.ShowDialog()
    $dropdownArray3Switch = Switch ($ComboboxNumber.text)
    {"Computer # If applicable" {""}
    "01" {"-01"}
    "02" {"-02"}
    "03" {"-03"}
    "04" {"-04"}
    "05" {"-05"}
    "06" {"-06"}
    "07" {"-07"}
    "08" {"-08"}
    "09" {"-09"}
    "10" {"-10"}
    "11" {"-11"}
    "12" {"-12"}
    "13" {"-13"}
    "14" {"-14"}
    "15" {"-15"}
    "16" {"-16"}
    "17" {"-17"}
    "18" {"-18"}
    "19" {"-19"}
    "20" {"-20"}
    "21" {"-21"}
    "22" {"-22"}
    "23" {"-23"}
    "24" {"-24"}
    "25" {"-25"}
    }

    $dropdownarrySwitch = switch -Wildcard ($DropdownBoxschool.Text)
        {
            "College's of Law Santa*" {"CLSB"}
            "College's of Law Ven*" {"CLVT"}
            "Pacific Oaks College Ma*" {"POCX"}
            "Pacific Oaks College San*" {"POSJ"}
            "Chicago School Chi*" {"PPCH"}
            "Chicago School Wash*" {"PPDC"}
            "Chicago School Irv*" {"PPIR"}
            "Chicago School LA*" {"PPLA"}
            "Chicago School RI*" {"DNXX"}
        }
    $dropdownSwitch = switch ($DropdownBoxTYPE.Text)
        {
            "Room" {"RM"}
            "Lab" {"LB"}
            "Library" {"LIB"}
            "Student Lounge" {"SL"}
            "Adjunct Lounge" {"AL"}
            "Digital Signage" {"TV"}
        }
    $feedback = $dropdownarrySwitch + "-" + $Dropdownswitch + $comboBoxSchool.Text + $dropdownArray3Switch | Out-File C:\KACE\Applications\compName.txt



$compname = get-content C:\KACE\Applications\compName.txt
$domip = switch -Wildcard ($compname)
{{
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
"PPCH-*" {"10.18.108.32"}
}


$credential = New-Object System.Management.Automation.PsCredential("tcses.org\tcsserviceadmin", (ConvertTo-SecureString "Technician1" -AsPlainText -Force))
$domaininfo = New-Object DirectoryServices.DirectoryEntry("LDAP://$domip","tcses\tcsserviceadmin","Technician1")
$searcher = New-Object System.DirectoryServices.DirectorySearcher($domaininfo)
$searcher.filter = "(cn=$compname)"
$searchparm = $searcher.FindOne() 



$Dom = "tcses.org"


If(!($searchparm)){
    Add-Computer -DomainName $Dom -Credential $credential -NewName $compname -Force
    }
else {
    Add-Computer -DomainName $Dom -Credential $credential -Force
    }

$Path = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
$username = "tcses\tcsserviceadmin"
$user = "tcsserviceadmin"
$pass = "Technician1"


#Write-Host "Adding the Domain User to Local Admin" -fore Green
Start-Process "cmd.exe" "/c net localgroup administrators $username /add" -Wait -NoNewWindow 
Start-Sleep -Seconds 4

#Write-Host "Assigning the domain user to auto log" -fore Green
Set-ItemProperty -Path $Path -Name DefaultUserName -Value $user | Out-NULL
Set-ItemProperty -Path $Path -Name DefaultDomainName -Value tcses.org | Out-NULL
New-ItemProperty -Path $Path -Name DefaultPassword -Value $pass | Out-NULL
Start-Sleep -Seconds 3
