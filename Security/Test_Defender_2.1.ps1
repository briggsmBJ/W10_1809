# // ***************************************************************************
# // 
# // ComputerInformation 
# //
# // File:      Test_Defender_2.1.ps1
# // 
# // Purpose:   Powershell Command Line script to check if Defender is working
# //            and if other Antivirus programs are disabled
# // 
# // ***************************************************************************

Function ConvertTo-Hex {
  Param([int]$Number)
  '0x{0:x}' -f $Number
}
Remove-Variable -Name 1,2,address2,Apps,AV,AVENG,AVSig,Enabled,end,EXCLU,EXCLU2,foreach,html2,hx,item,key,mid,NUMB,PROD,Realtime,SENTINELONE,SENTINELONEVERSION,UpToDate,Version -Scope Global -ErrorAction SilentlyContinue | out-null
Write-host "Please wait. Scraping web...." -ForegroundColor cyan

$address2 = "https://www.microsoft.com/en-us/wdsi/definitions/antimalware-definition-release-notes"
$progressPreference = 'silentlyContinue'
$html2 = (invoke-webrequest -uri $address2 -UseBasicParsing).content
$progressPreference = 'Continue'
$1 = $html2 -split "`n" -match 'combobox" value='
$2 = ($1 -split "value=")[1]
$Version = ($2 -split " aria")[0]

# Write-host "Latest Microsoft Security Intelligence Signature Version is:  " -ForegroundColor cyan -NoNewline; Write-host $Version -ForegroundColor Yellow

$AV = (Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct)
$NUMB = ($av|measure).count


$Apps = (Get-ChildItem HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\) | Get-ItemProperty | select DisplayName,DisplayVersion,Version,UninstallString,QuietUninstallString
$Apps += (Get-ChildItem HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\) | Get-ItemProperty | select DisplayName,DisplayVersion,Version,UninstallString,QuietUninstallString

function Write-Color([String[]]$Text, [ConsoleColor[]]$Color = 'White', [int]$StartTab = 0, [int] $LinesBefore = 0,[int] $LinesAfter = 0) {
  $DefaultColor = $Color[0]
  if ($LinesBefore -ne 0) {  for ($i = 0; $i -lt $LinesBefore; $i++) { Write-Host "`n" -NoNewline } } # Add empty line before
  if ($StartTab -ne 0) {  for ($i = 0; $i -lt $StartTab; $i++) { Write-Host "`t" -NoNewLine } }  # Add TABS before text
  if ($Color.Count -ge $Text.Count) {
    for ($i = 0; $i -lt $Text.Length; $i++) { Write-Host $Text[$i] -ForegroundColor $Color[$i] -NoNewLine } 
  } else {
    for ($i = 0; $i -lt $Color.Length ; $i++) { Write-Host $Text[$i] -ForegroundColor $Color[$i] -NoNewLine }
    for ($i = $Color.Length; $i -lt $Text.Length; $i++) { Write-Host $Text[$i] -ForegroundColor $DefaultColor -NoNewLine }
  }
  Write-Host
  if ($LinesAfter -ne 0) {  for ($i = 0; $i -lt $LinesAfter; $i++) { Write-Host "`n" } }  # Add empty line after
}

ForEach ($key in $Apps)
{
  
  #AppSense Green
  If ($key.DisplayName -like "*Sentinel*") 
  {
    $SENTINELONEVERSION = $key.DisplayVersion
  $SENTINELONE = $KEY.DisplayName}
}
  
Write-host "" 
Write-host "" 
Write-host "" 
Write-host "######################################################" -f Gray
if ($NUMB -eq 1)
{
  Write-host "There is " -NoNewLine ; Write-Host "$NUMB" -f Green -NoNewLine ; Write-host " Security Product " -NoNewline ; Write-host "GOOD" -f Green
}
if ($NUMB -eq 3 -or $numb -eq 2)
{
  Write-host "There are " -NoNewLine ; Write-Host "$NUMB" -f Red -NoNewLine ; Write-host " Security Products " -NoNewline ; Write-host "BAD" -f Red
}

Write-host "######################################################" -f Gray
Write-host "" 




foreach ($item in $AV) {
  $hx = ConvertTo-Hex $item.ProductState
  $PROD = $item.displayName
  $mid = $hx.Substring(3,2)
  if ($mid -match "00|01") {
    $Enabled = $False
  }
  else {
    $Enabled = $True
  }
  $end = $hx.Substring(5)
  if ($end -eq "00") {
    $UpToDate = $True
  }
  else {
    $UpToDate = $False
  }

  Write-host "Product: "-NoNewline ; Write-host $prod -f Cyan
  if ($Enabled -eq $true)
  {
    Write-host "Enabled: " -NoNewLine ; Write-host $Enabled -f Green
  }
  Else
  {
    Write-host "Enabled: " -NoNewLine ; Write-host $Enabled -f RED
  }
  
  if ($UpToDate -eq $true)
  {
    Write-host "UpToDate: " -NoNewLine ; Write-host $UpToDate -f Green
  }
  else
  {
    Write-host "UpToDate: " -NoNewLine ; Write-host $UpToDate -f RED
  }
  Write-host "" 
} #foreach

## MID value of 10 is enabled
## END value of 00 is up to date


If ($SENTINELONE -ne $null)
{ if ($SENTINELONEVERSION -ge "3.3.3.29")
      
  {
    Write-color -text 'SentinelOne (',$SENTINELONEVERSION,') Installed: ',' Compliant' -color white,yellow, white, green
  }
  else 
  {
    Write-color -text 'SentinelOne (',$SENTINELONEVERSION,') Installed: ',' NOT The Defender Version' -color white,yellow, white, red
  }
    
}

If ($SENTINELONE -eq $null)
{
  Write-color -text 'SentinelOne',' ********************************************** NOT Installed!!!!!!!!',' **********************************************' -color white,red,red
}
    
Write-Host ""


function Get-RegistryValue($key, $value) {
  (Get-ItemProperty $key $value).$value
}

$AVSig = Get-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows Defender\Signature Updates" AVSignatureVersion
$AVENG = Get-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows Defender\Signature Updates" EngineVersion
## Animalware Client
$ANTIMAL = (Get-CimInstance -Namespace root\microsoft\securityclient -Classname antimalwarehealthstatus).version
#$Antimal = Get-ItemProperty -Path "C:\Program Files\Windows Defender\MpCmdRun.exe" | Select-Object -ExpandProperty VersionInfo

$EXCLU = (Get-MpPreference).ExclusionProcess
if ($EXCLU -ne $null)
{
  Write-host "Defender Process Exclusions: " -f GREEN -nonewline;Write-host $EXCLU; Write-host ""
}
else
{
  Write-host "Defender Process Exclusions: " -nonewline ; Write-Host "Missing" -f RED; Write-host ""
}


$EXCLU2 = (Get-MpPreference).ExclusionPath
if ($EXCLU2 -ne $null)
{
  Write-host "Defender Path Exclusions:" -f GREEN -nonewline; Write-host $EXCLU2; Write-host ""
}
else
{
  Write-host "Defender Path Exclusions: " -nonewline ; Write-Host "Missing" -f RED; Write-host ""
}


$EmptyPolicy= @()
Get-wmiObject -namespace “Root\ccm\Policy\Machine\ActualConfig” -query “Select Name from CCM_AntiMalwarePolicyClientConfig” | ForEach-Object {$EmptyPolicy+=$_.Name}
$1 = ($EmptyPolicy | Group-Object | Select-Object -Property Name -Unique)

## List the Policies
write-host "" ;
write-host "Applied SCCM Policies (WMI)" -foregroundcolor GREEN;
write-host "---------------------------" -foregroundcolor GREEN;
$1.name[0..($1.length - 1)]

Write-Host ""
Write-Host ""

$Realtime = (Get-MpPreference).DisableRealTimeMonitoring
if ($Realtime -eq $True)
{
  Write-host "Defender Realtime Monitoring: " -nonewline; Write-host "OFF" -f RED; Write-host ""
}
else
{
  Write-host "Defender Realtime Monitoring: " -nonewline; Write-host "ON" -f GREEN; Write-host ""
  Write-host "Defender Engine Version: " -nonewline; Write-host $AVENG -f GREEN; Write-host ""
  if (($Antimal) -lt "4.18")
  {
    Write-host "Antimalware Client Version: " -nonewline; Write-host $Antimal -f RED -NoNewline; Write-host " " -NoNewline; Write-host "************ Warning ************" -f Yellow; Write-host ""
  }
  else
  {
    Write-host "Antimalware Client Version: " -nonewline; Write-host $Antimal -f GREEN; Write-host ""
  }
  Write-host "Defender Signature Version: " -nonewline; Write-host $AVSig -NoNewline -f GREEN; Write-host " Latest Version " -NoNewline ; Write-host $Version -ForegroundColor Yellow ; Write-host ""
  Write-Host "Scraped from here: " -NoNewline ; write-host "https://www.microsoft.com/en-us/wdsi/defenderupdates" -f Cyan; Write-host ""
  
}


$COMPAREWITH = Get-Date (get-date).adddays(-2) -format "MM/dd/yyyy"

## Signature Applied
$data = Get-ItemProperty -path "HKLM:\SOFTWARE\Microsoft\Windows Defender\Signature Updates"
$Int64Value = [System.BitConverter]::ToInt64($data.AVSignatureApplied, 0)
$time = [DateTime]::FromFileTime($Int64Value)
$SIGAPPLIED = Get-Date $time -Format "MM/dd/yyyy"
$COMPARENOW = $SIGAPPLIED -Gt $COMPAREWITH

Write-Color "Signature Applied (MM/dd/yyyy): ",$SIGAPPLIED -Color White,yellow

if ($COMPARENOW -eq $true)
{
  Write-color "Applied Within last two Days?: ", $COMPARENOW -Color White,green
}
else
{
  Write-color "Applied Within last two Days?: ", $COMPARENOW -Color White,red
  write-host "" ;
  write-host "" ;
  write-host "Manually Update McAfee Signature" -foregroundcolor yellow;
  write-host "--------------------------------" -foregroundcolor yellow;
  write-Host "cmd /c 'C:\Program Files\Windows Defender\MpCmdRun.exe' -signatureupdate -mmpc -hide" -ForeGroundColor green;
  write-host "" ;
  write-host "" ;
}
 

## Signature Applied
$data1 = Get-ItemProperty -path "HKLM:\SOFTWARE\Microsoft\Windows Defender\Signature Updates"
$Int64Value1 = [System.BitConverter]::ToInt64($data1.SignaturesLastUpdated, 0)
$time1 = [DateTime]::FromFileTime($Int64Value1)
$SIGUPDATED = Get-Date $time1 -Format "MM/dd/yyyy"
$COMPARENOW1 = $SIGUPDATED -Gt $COMPAREWITH

Write-Color "Signature Updated (MM/dd/yyyy): ",$SIGUPDATED -Color White,yellow

if ($COMPARENOW1 -eq $true)
{
  Write-color "Updated Within last two Days?: ", $COMPARENOW1 -Color White,green
}
else
{
  Write-color "Updated Within last two Days?: ", $COMPARENOW1 -Color White,red
  write-host "" ;
  write-host "" ;
  write-host "Manually Update McAfee Signature" -foregroundcolor yellow;
  write-host "--------------------------------" -foregroundcolor yellow;
  write-Host "cmd /c 'C:\Program Files\Windows Defender\MpCmdRun.exe' -signatureupdate -mmpc -hide" -ForeGroundColor green;
  write-host "" ;
  write-host "" ;
}

Write-Host ''

function check-service3
{  param($SVC_1a)
  If (Get-Service $SVC_1a -ErrorAction SilentlyContinue) 
  { 
    If ((Get-Service $SVC_1a).Status -eq 'Running') 
    {
      write-color -text "$SVC_1a Service is ", 'RUNNING' -color White, Green
    }
    
    if ((Get-Service $SVC_1a).Status -eq 'Stopped')
    {
      write-color -text "$SVC_1a Service is ",'STOPPED'  -color white,RED
      write-host "" ;
      write-host "" ;
      write-host "Manually Start Defender Service" -foregroundcolor yellow;
      write-host "-------------------------------" -foregroundcolor yellow;
      write-Host "start-service windefend -passthru" -ForeGroundColor green;
      write-host "" ;
      write-host "" ;
    }
  }
  Else 
  {
    write-color -text "$SVC_1a Service is ",'MISSING' -color white,Red
  }
}




check-service3 'Windows Defender Antivirus Service'

Write-Host ''

#pause
