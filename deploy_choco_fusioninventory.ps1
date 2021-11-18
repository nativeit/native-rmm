# |  #   #   #   #   #   #   #   #   #   #   #   #   #   __//    N A T I V E . I T    //__    #   #   #   #   #   #   #   #   #   #   #   |
# |                                                                                                                                       |
# |  This script checks for Chocolatey and installs it if needed. It then installs FusionInventory for our GPLI server at                 |
# |  psa.nativeit.net (BE SURE TO CHANGE THIS IF YOU FORK THIS). A local report directory is added at C:\Support\FusionInventory.         |
# |                                                                                                                                       |
# |  This script was revised, tested, and approved on 2021-11-18.                                                                         |
# |                                                                                                                                       |
# |  #   #   #   #   #   #   #   #   #   #   #   #   #   __//    desk.nativeit.net     //__   #   #   #   #   #   #   #   #   #   #   #   |

# 
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
