
# + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - + #
# |                                                                                                                                         | #
# |  + ------------------------------------------------- //    N A T I V E  I T    // ------------------------------------------------- +   | #
# |                                                                                                                                         | #
# |  This script replaces the details of the Atera agent such that its app name in Apps & Features, services, and menus reflects            | #
# |  your own brand rather than that of Atera's. The stock icon is replaced with one of your own (hosted from a public URL).                | #
# |                                                                                                                                         | #
# |  This script was revised, tested, and approved on 2021-12-15.                                                                           | #
# |                                                                                                                                         | #
# |  + ------------------------------------------------- //    desk.nativeit.net    // ------------------------------------------------ +   | #
# |                                                                                                                                         | #
# |  NOTES:                                                                                                                                 | #
# |   - App icon in .ico format, hosted at a publicly accessible URL so the script can download and install it.                             | #
# |   - Other variables: application name, business/organization name, a website address and phone number for support and information.      | #
# |   - Must be run as admin/system                                                                                                         | #
# |   - The registry paths are from Windows 10, other versions may differ and cause this script to fail.                                    | #
# |   - See further comments for more details about what is being changed.                                                                  | #
# |                                                                                                                                         | #
# + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - + #


# This is to Modify the Name of the entry in Appwiz.cpl
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "DisplayName" -ErrorAction SilentlyContinue)){
        Write-Host "DisplayName does not yet exist. Creating.."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "DisplayName" -Value "{[your_appname]}" -PropertyType "String"
    } else {
        Write-Host "DisplayName already exists. Modifying.."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "DisplayName" -Value "{[your_appname]}"
    }
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Classes\Installer\Products\75E43F6C44CA62A4B8A085EC5A6E27F5\" -Name "ProductName" -ErrorAction SilentlyContinue)){
        Write-Host "ProductName does not yet exist. Creating.."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Classes\Installer\Products\75E43F6C44CA62A4B8A085EC5A6E27F5\" -Name "ProductName" -Value "{[your_appname]}" -PropertyType "String"
    } else {
        Write-Host "ProductName already exists. Modifying.."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Classes\Installer\Products\75E43F6C44CA62A4B8A085EC5A6E27F5\" -Name "ProductName" -Value "{[your_appname]}"
    }
 
# Copying App icon
Invoke-WebRequest -Uri 'http://{[icon_URL]}/{[appname_slug]}.ico' -OutFile 'C:\windows\system32\{[appname_slug]}.ico'
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "DisplayIcon" -ErrorAction SilentlyContinue)){
        Write-Host "DisplayIcon does not yet exist. Creating.."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "DisplayIcon" -Value "C:\Windows\System32\{[appname_slug]}.ico" -PropertyType "String"
    } else {
        Write-Host "DisplayIcon already exists. Modifying.."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "DisplayIcon" -Value "C:\Windows\System32\{[appname_slug]}.ico"
    }
 
# This is to Modify the Publisher of the entry in Appwiz.cpl
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "Publisher" -ErrorAction SilentlyContinue)){
        Write-Host "Publisher does not yet exist. Creating.."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "Publisher" -Value "{[company_name]}" -PropertyType "String"
    } else {
        Write-Host "Publisher already exists. Modifying.."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "Publisher" -Value "{[company_name]}"
    }
 
 
# These last four modify the Help Link, Support Link and Update Information available in appwiz.cpl
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "HelpLink" -ErrorAction SilentlyContinue)){
        Write-Host "HelpLink does not yet exist. Creating.."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "HelpLink" -Value "{[support_www]}" -PropertyType "String"
    } else {
        Write-Host "HelpLink already exists. Modifying.."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "HelpLink" -Value "{[support_www]}"
    }
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "HelpTelephone" -ErrorAction SilentlyContinue)){
        Write-Host "HelpTelephone does not yet exist. Creating.."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "HelpTelephone" -Value "{[support_phone]}" -PropertyType "String"
    } else {
        Write-Host "HelpTelephone already exists. Modifying.."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "HelpTelephone" -Value "{[support_phone]}"
    }
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "URLInfoAbout" -ErrorAction SilentlyContinue)){
        Write-Host "URLInfoAbout does not yet exist. Creating.."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "URLInfoAbout" -Value "{[company_www]}" -PropertyType "String"
    } else {
        Write-Host "URLInfoAbout already exists. Modifying.."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "URLInfoAbout" -Value "{[company_www]}"
    }
if(-not(Get-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "URLUpdateInfo" -ErrorAction SilentlyContinue)){
        Write-Host "URLUpdateInfo does not yet exist. Creating.."
        New-Itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "URLUpdateInfo" -Value "{[company_www]}" -PropertyType "String"
    } else {
        Write-Host "URLUpdateInfo already exists. Modifying.."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C6F34E57-AC44-4A26-8B0A-58CEA5E6725F}\" -Name "URLUpdateInfo" -Value "{[company_www]}"
    }
