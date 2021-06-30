$ErrorActionPreference = 'Stop';

$packageName= 'amazon-appstream-usb'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://clients.amazonappstream.com/installers/windows/AmazonAppStreamClient_EnterpriseSetup_1.1.294.zip'
$downloadedZip = Join-Path $toolsDir 'AmazonAppStreamClient_EnterpriseSetup.zip'
$fileLocation = Join-Path $toolsDir 'AmazonAppStreamUsbDriverSetup_1.1.294.exe'

$packageArgs = @{
  packageName   = $packageName
  filefullpath  = $downloadedZip
  url           = $url
  checksum      = 'E6340D40D88994BAC6C18BEB3F49791D79E4192448352954C9536A4D824E2DC8'
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Get-ChocolateyUnzip -FileFullPath $downloadedZip -Destination $toolsDir

$installerArgs  = @{
  packageName   = $packageName
  silentArgs    = '/quiet /norestart /log ASUSBLog.txt'
  file          = $fileLocation
  fileType      = 'exe'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @installerArgs

Write-Host "Finished installation of AppStream 2.0 Client USB Drivers."

Write-Host -ForegroundColor Magenta @"
  AppStream 2.0 Client USB drivers installed.
  You must reboot your PC to finalize the driver installation.
"@
