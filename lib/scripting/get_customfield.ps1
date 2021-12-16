
#                                                             𝝢 𝝠 𝝩 𝝞 𝗩 𝝣 ⧟ 𝝞 𝝩                                                             
# ⎧ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ⎫
# |                                                                                                                                         |
# |  This script allows other automation scripts to pull and utilize the values from custom fields. Be sure to tweak the relevant           |
# |  fields to fit your use-case. This was taken from:                                                                                      |
# |                                                                                                                                         |
# |  https://support.atera.com/hc/en-us/articles/360019156800-Get-the-Value-for-Custom-Fields-in-Scripts-                                   |                                                                                                 |
# |                                                                                                                                         |
# |                                                                                                                                         |
# ⎩ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ⎭
#       ⧉ desk.nativeit.net                                                                        𝑖 𝑚 𝑎 𝑔 𝑖 𝑛 𝑎 𝑡 𝑖 𝑜 𝑛  ✚  𝑡 𝑒 𝑐 ℎ 𝑛 𝑜 𝑙 𝑜 𝑔 𝑦


$AteraAPIKey = 'MY ATERA API KEY'
$FieldName = 'Sophos Key'
$SophosURI = 'https://SOME SHAREPOINT PUBLIC URL FOR/SophosSetup.exe'

# Install and load the right version of Atera
if (!(Get-Module -ListAvailable PSAtera)) {
	Install-Module -Name PSAtera -MinimumVersion 1.3.1 -Force
}
Import-Module -Name PSAtera -MinimumVersion 1.3.1

Set-AteraAPIKey -APIKey $AteraAPIKey

# Get the agent information for the PC that's running the script
$agent = Get-AteraAgent

# Get the value from the Customer endpoint
$customValue = Get-AteraCustomValue -ObjectType Customer -ObjectId $agent.CustomerID -FieldName $FieldName

# Download Sophos Installer to temp path
$SophosInstaller = Join-Path -Path $env:TEMP -ChildPath "SophosSetup.exe"
Invoke-WebRequest -Uri $SophosURI -OutFile $SophosInstaller

& $SophosInstaller --customertoken="$($customValue.ValueAsString)" --epiinstallerserver="api-cloudstation-us-east-2.prod.hydra.sophos.com" --products="all" --quiet

# Get the status of the Sophos Install
do {
	Get-Process -Name "*SophosSetup.exe*"
    Start-Sleep -Seconds 10
} while (Get-Process -Name "*SophosSetup.exe*" -ErrorAction SilentlyContinue)

# After install is over, get the status of the Sophos Services
Get-Service -Name "*Sophos*"
