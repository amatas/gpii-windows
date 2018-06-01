<#
  This script install all the chocolatey packages and configure them.
#>
Import-Module (Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) 'Provisioning.psm1') -Force

$chocolatey = "$env:ChocolateyInstall\bin\choco.exe" -f $env:SystemDrive

$nodePath = "C:\Program Files (x86)\nodejs"
$nodeVersion = "8.9.4"
Invoke-Command $chocolatey "install nodejs.install --version $($nodeVersion) --forcex86 -y"
# TODO: Correct path and automatically added is this one
# C:\Users\vagrant\AppData\Roaming\npm review it.
#Add-Path $nodePath $true
# Call nodevars.bat through Invoke-Environment to have available all the environment vars
# setted by the script in the PS1 environment.
Invoke-Environment (Join-Path $nodePath "nodevars.bat")
refreshenv

$python2Path = "C:\tools\python2"
Invoke-Command $chocolatey "install python2 -y"
Add-Path $python2Path $true
refreshenv

Invoke-Command $chocolatey "install msbuild.extensionpack -y"
refreshenv

exit 0
