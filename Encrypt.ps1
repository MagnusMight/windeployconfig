C:\Users\cevulukwu\Documents\windeployconfig\Changeadmin

$PasswordFile = "C:\Users\cevulukwu\Documents\windeployconfig\Changeadmin\COLPassword.txt"
$KeyFile = "C:\Users\cevulukwu\Documents\windeployconfig\Changeadmin\COLAES.key"
$Key = Get-Content $KeyFile
$Password = 'Law)!@"' | ConvertTo-SecureString -AsPlainText -Force
$Password | ConvertFrom-SecureString -key $Key | Out-File $PasswordFile

$KeyFile = "C:\Users\cevulukwu\Documents\windeployconfig\Changeadmin\COLAES.key"
$Key = New-Object Byte[] 32   # You can use 16, 24, or 32 for AES
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($Key)
$Key | out-file $KeyFile