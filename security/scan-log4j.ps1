# Look for any instances from before log4j-2.1.50.rc2. If any are found, then immediate steps should be taken to mediate their ability to affect the system and then look for the availability of patches from the parent software package's maintainers.

$PortableEverythingURL = "https://www.voidtools.com/Everything-1.4.1.1009.x64.zip"
 
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Invoke-WebRequest -UseBasicParsing -Uri $PortableEverythingURL -OutFile "$($ENV:TEMP)\Everything.zip"
Expand-Archive "$($ENV:TEMP)\Everything.zip" -DestinationPath $($ENV:Temp) -Force
if (!(Get-Service "Everything Client" -ErrorAction SilentlyContinue)) {
   & "$($ENV:TEMP)\everything.exe" -install-client-service
   & "$($ENV:TEMP)\everything.exe" -reindex
    start-sleep 3
    Install-Module PSEverything
}
else {
       & "$($ENV:TEMP)\everything.exe" -reindex
    Install-Module PSEverything
 
}
$ScanResults = search-everything -global -extension jar
if ($ScanResults) {
    Write-Host "Potential vulnerable JAR files found. Please investigate:"
    Write-Host "all Results:"
    $scanresults
    Write-Host "All Results with vulnerable class:"
($ScanResults | ForEach-Object { Select-String "JndiLookup.class" $_ }).path
}
else {
    Write-Host "Did not find any vulnerable files."
}
