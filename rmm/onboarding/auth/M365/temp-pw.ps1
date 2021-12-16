######### TAP Settings #########
$MinimumLifetime = "60" #Minutes
$MaximumLifetime = "480" #minutes
$DefaultLifeTime = "60" #minutes
$OneTimeUse = $false
$DefaultLength = "8"
######### Secrets #########
$ApplicationId = 'AppID'
$ApplicationSecret = 'AppSecret'
$TenantID = 'TenantIDForWhichtoEnableTap'
######### Secrets #########
  
 
$TAPSettings = @"
  {"@odata.type":"#microsoft.graph.temporaryAccessPassAuthenticationMethodConfiguration",
  "id":"TemporaryAccessPass",
  "includeTargets":[{"id":"all_users",
  "isRegistrationRequired":false,
  "targetType":"group","displayName":"All users"}],
  "defaultLength":$DefaultLength,
  "defaultLifetimeInMinutes":$DefaultLifeTime,
  "isUsableOnce":false,
  "maximumLifetimeInMinutes":$MaximumLifetime,
  "minimumLifetimeInMinutes":$MinimumLifetime,
  "state":"enabled"}
"@
 
$body = @{
    'resource'      = 'https://graph.microsoft.com'
    'client_id'     = $ApplicationId
    'client_secret' = $ApplicationSecret
    'grant_type'    = "client_credentials"
    'scope'         = "openid"
}
   
foreach ($tenant in $tenants) {
  
    write-host "Working on client $($tenant.defaultdomainname)"
    try {
        $ClientToken = Invoke-RestMethod -Method post -Uri "https://login.microsoftonline.com/$($tenantid)/oauth2/token" -Body $body -ErrorAction Stop
        $headers = @{ "Authorization" = "Bearer $($ClientToken.access_token)" }
        Invoke-RestMethod -ContentType "application/json" -UseBasicParsing -Method Patch -Headers $Headers -body $TAPSettings -uri "https://graph.microsoft.com/beta/policies/authenticationmethodspolicy/authenticationMethodConfigurations/TemporaryAccessPass"
    }
    catch {
        Write-Warning "Could not log into tenant $($tenant.DefaultDomainName) or retrieve policy. Error: $($_.Exception.Message)"
    }
   
}
