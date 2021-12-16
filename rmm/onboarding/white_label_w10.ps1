
#                                                             𝝢 𝝠 𝝩 𝝞 𝗩 𝝣 ⧟ 𝝞 𝝩                                                             
# ⎧ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ⎫
# |                                                                                                                                         |
# |  This script replaces the details of the Atera agent such that its app name in Apps & Features, services, and menus reflects            |
# |  your own brand rather than that of Atera's. The stock icon is replaced with one of your own (hosted from a public URL).                |
# |                                                                                                                                         |
# |  This script was revised, tested, and approved on 2021-12-15.                                                                           |
# |                                                                                                                                         |
# |     NOTES:                                                                                                                              |
# |                                                                                                                                         |
# |   - App icon in .ico format, hosted at a publicly accessible URL so the script can download and install it.                             |
# |   - Other variables: application name, business/organization name, a website address and phone number for support and information.      |
# |   - Must be run as admin/system                                                                                                         |
# |   - The registry paths are from Windows 10, other versions may differ and cause this script to fail.                                    |
# |   - See further comments for more details about what is being changed.                                                                  |
# |                                                                                                                                         |
# |    VARIABLES:                                                                                                                           |
# |   - your_appname:   Name that will appear as the agent software in Apps & Features                                                      |
# |   - icon_url:       Publicly accessible URL for downloading your app icon in .ico format                                                |
# |   - appname_slug:   Your app name abbreviated with no spaces or special characters (to use with icon filename)                          |
# |   - company_name:   Your company's name as you want it to appear in support and publisher details in Apps & Features                    |
# |   - support_www:    URL to your help desk/contact form/ticketing system for users to access support.                                    |
# |   - support_phone:  Phone number to your help desk/contact form/ticketing system for users to access support.                           |
# |   - company_www:    Your company's main website to be included in Apps & Features details/system properties.                            |
# |   - logo_url:       Publicly accessible URL for downloading your logo in 32-bit .bmp format, dimensions should be 120w x 120h           |
# |                                                                                                                                         |
# ⎩ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ⎭
#       ⧉ desk.nativeit.net                                                                        𝑖 𝑚 𝑎 𝑔 𝑖 𝑛 𝑎 𝑡 𝑖 𝑜 𝑛  ✚  𝑡 𝑒 𝑐 ℎ 𝑛 𝑜 𝑙 𝑜 𝑔 𝑦


#### This sets the name for the agent software listed in Apps & Features ####

if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "DisplayName" -ErrorAction SilentlyContinue)){
        Write-Host "DisplayName does not yet exist. Adding custom entries."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "DisplayName" -Value "{[your_appname]}" -PropertyType "String"
    } else {
        Write-Host "DisplayName existing data found. Updating with custom entries."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "DisplayName" -Value "{[your_appname]}"
    }
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Classes\Installer\Products\75E43F6C44CA62A4B8A085EC5A6E27F5\" -Name "ProductName" -ErrorAction SilentlyContinue)){
        Write-Host "ProductName does not yet exist. Adding custom entries."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Classes\Installer\Products\75E43F6C44CA62A4B8A085EC5A6E27F5\" -Name "ProductName" -Value "{[your_appname]}" -PropertyType "String"
    } else {
        Write-Host "ProductName existing data found. Updating with custom entries."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Classes\Installer\Products\75E43F6C44CA62A4B8A085EC5A6E27F5\" -Name "ProductName" -Value "{[your_appname]}"
    }
    
 
#### Downloads your custom icon (.ico format) from a public host specified in variables ####

Invoke-WebRequest -Uri 'http://{[icon_URL]}' -OutFile 'C:\windows\system32\{[appname_slug]}.ico'
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "DisplayIcon" -ErrorAction SilentlyContinue)){
        Write-Host "DisplayIcon does not yet exist. Adding custom entries."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "DisplayIcon" -Value "C:\Windows\System32\{[appname_slug]}.ico" -PropertyType "String"
    } else {
        Write-Host "DisplayIcon existing data found. Updating with custom entries."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "DisplayIcon" -Value "C:\Windows\System32\{[appname_slug]}.ico"
    }
    
 
#### Sets your company name in the "Publisher" field ####

if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "Publisher" -ErrorAction SilentlyContinue)){
        Write-Host "Publisher does not yet exist. Adding custom entries."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "Publisher" -Value "{[company_name]}" -PropertyType "String"
    } else {
        Write-Host "Publisher existing data found. Updating with custom entries."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "Publisher" -Value "{[company_name]}"
    }
 
 
#### This sets the links for help, support, and information in Apps & Features ####

if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "HelpLink" -ErrorAction SilentlyContinue)){
        Write-Host "HelpLink does not yet exist. Adding custom entries."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "HelpLink" -Value "{[support_www]}" -PropertyType "String"
    } else {
        Write-Host "HelpLink existing data found. Updating with custom entries."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "HelpLink" -Value "{[support_www]}"
    }
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "HelpTelephone" -ErrorAction SilentlyContinue)){
        Write-Host "HelpTelephone does not yet exist. Adding custom entries."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "HelpTelephone" -Value "{[support_phone]}" -PropertyType "String"
    } else {
        Write-Host "HelpTelephone existing data found. Updating with custom entries."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "HelpTelephone" -Value "{[support_phone]}"
    }
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "URLInfoAbout" -ErrorAction SilentlyContinue)){
        Write-Host "URLInfoAbout does not yet exist. Adding custom entries."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "URLInfoAbout" -Value "{[company_www]}" -PropertyType "String"
    } else {
        Write-Host "URLInfoAbout existing data found. Updating with custom entries."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "URLInfoAbout" -Value "{[company_www]}"
    }
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "URLUpdateInfo" -ErrorAction SilentlyContinue)){
        Write-Host "URLUpdateInfo does not yet exist. Adding custom entries."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "URLUpdateInfo" -Value "{[company_www]}" -PropertyType "String"
    } else {
        Write-Host "URLUpdateInfo existing data found. Updating with custom entries."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "URLUpdateInfo" -Value "{[company_www]}"
    }
    
    
 #### Sets the OEM information under System Properties ####
 
  ## Sets support phone number
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation\" -Name "SupportPhone" -ErrorAction SilentlyContinue)){
        Write-Host "Existing support phone data not found. Adding custom entries."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation\" -Name "SupportPhone" -Value "{[support_phone]}" -PropertyType "String"
    } else {
        Write-Host "Support phone existing data found. Updating with custom entries."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation\" -Name "SupportPhone" -Value "{[support_phone]}"
    }
    
  ## Sets helpdesk email link
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation\" -Name "SupportURL" -ErrorAction SilentlyContinue)){
        Write-Host "Existing support phone data not found. Adding custom entries."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation\" -Name "SupportURL" -Value "{[support_www]}" -PropertyType "String"
    } else {
        Write-Host "Support phone existing data found. Updating with custom entries."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation\" -Name "SupportURL" -Value "{[support_www]}"
    }
    
  ## Downloads your custom logo (.bmp format, 120w x 120h) from a public host specified in variables. NOTE: This setting has been deprecated and will no longer appear in future versions of Windows.
Invoke-WebRequest -Uri 'http://{[logo_URL]}' -OutFile 'C:\windows\system32\oemlogo.bmp'
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation\" -Name "Logo" -ErrorAction SilentlyContinue)){
        Write-Host "Logo does not yet exist. Adding custom entries."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation\" -Name "Logo" -Value "C:\Windows\System32\oemlogo.bmp" -PropertyType "String"
    } else {
        Write-Host "Logo existing data found. Updating with custom entries."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation\" -Name "Logo" -Value "C:\Windows\System32\oemlogo.bmp"
    }
 

