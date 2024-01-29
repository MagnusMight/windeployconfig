
New-Item -ItemType directory -Path C:\temp -Force
$folder = "C:\temp"
$url= "http://dl.google.com/chrome/install/375.126/chrome_installer.exe"
$req = [System.Net.HttpWebRequest]::Create($url)
$req.Method = "HEAD"
$response = $req.GetResponse()
$fUri = $response.ResponseUri
$filename = [System.IO.Path]::GetFileName($fUri.LocalPath); 
$response.Close()
$target = join-path $folder $filename 
Invoke-WebRequest -Uri $url -OutFile $target 