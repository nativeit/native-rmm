
#                                                             𝝢 𝝠 𝝩 𝝞 𝗩 𝝣 ⧟ 𝝞 𝝩                                                             
# ⎧ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ⎫
# |                                                                                                                                         |
# |   This script pulls all administrative events from system logs that have been recorded in the previous hour, and then provides the      |
# |   results in the Atera agent dashboard. This is particularly useful when set up to run regularly throughout the day so that if/when     |
# |   an incident occurs that results in the PC going offline or otherwise being unavailable for remote troubleshooting there is at         |
# |   least a relatively recent record of what was happening on the machine.                                                                |
# |                                                                                                                                         |
# |   We have this script set to run every hour on standard agents, and every half hour on servers and mission-critical agents.             |
# |                                                                                                                                         |
# ⎩ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ⎭
#       ⧉ desk.nativeit.net                                                                        𝑖 𝑚 𝑎 𝑔 𝑖 𝑛 𝑎 𝑡 𝑖 𝑜 𝑛  ✚  𝑡 𝑒 𝑐 ℎ 𝑛 𝑜 𝑙 𝑜 𝑔 𝑦


$xmlFilter = "$($env:TEMP)\adminFilter.xml"
$header = "<QueryList>`r`n  <Query Id=`"0`" Path=`"Application`">"
$footer = "  </Query>`r`n</QueryList>"
$loglist = @()
$EventLogs = Get-WinEvent -Force -ListLog * -ErrorAction SilentlyContinue

foreach ($Log in $EventLogs) {
  if ($Log.LogType -eq "Administrative") {
    $loglist += $log.logName
  }
}

set-content $xmlFilter $header
foreach ($logName in $loglist) { Add-Content $xmlFilter "    <Select Path=`"$($logName)`">*[System[(Level=1 or Level=2 or Level=3) and
    TimeCreated[timediff(@SystemTime) &lt;= 3600000]]]</Select>" }
add-content $xmlFilter  $footer

#start notepad $xmlFilter 
Get-WinEvent -FilterXml ([xml](Get-Content $xmlFilter))
