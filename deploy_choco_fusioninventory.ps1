# This script checks for Chocolatey and installs if needed
# Must be run as admin/system

# Create directory for Fusion Inventory reports
mkdir C:\Support\FusionInventory

# Adjust permissions on C:\Support\FusionInventory
$mypath = "C:\Support\FusionInventory"
$myacl = Get-Acl $mypath
$myaclentry = "Everyone","FullControl","Allow"
$myaccessrule = New-Object System.Security.AccessControl.FileSystemAccessRule($myaclentry)
$myacl.SetAccessRule($myaccessrule)
Get-ChildItem -Path "$mypath" -Recurse -Force | Set-Acl -AclObject $myacl -Verbose

# Be sure choco.exe is added to $PATH
$choco = Join-Path -Path $env:ProgramData -ChildPath "chocolatey\choco.exe"

# Check for choco.exe, if not found, install it.
if (!(Test-Path $choco)) {
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}else {
  Write-Host "Chocolatey Found!"
}

# Install Fusion Inventory agent with arguments and [{tag}]
choco install fusioninventory-agent --yes --no-progress --installargs "/execmode=service /delaytime=3600 /server='https://psa.nativeit.net/plugins/fusioninventory/' /local="C:\Support\FusionInventory" /debug=1 /no-start-menu /tag={[computer_tag]} /add-firewall-exception /runnow"
