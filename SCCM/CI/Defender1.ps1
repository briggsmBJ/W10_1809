## List the installed Antivirus Products (Check 1)
$AV = (Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct)
$NUMB = ($AV|Measure-Object).count

if ($NUMB -eq 1) 
{ $AVCOUNT = 0 }
else
{ $AVCOUNT = 1 }

## Check if the Defender Service is running (Check 2)
$SVC = 'Windows Defender Antivirus Service'

If ((Get-Service $SVC).Status -eq 'Running')
{ $SVCCOUNT = 0 }
else
{ $SVCCOUNT = 2 }

## Check if Defender Exclusions exist (check 3)
$EXCLU = (Get-MpPreference).ExclusionProcess

if ($EXCLU -ne $null)
{ $EXCLUEXIST = 0 }
else
{ $EXCLUEXIST = 4 }
 
## Animalware Client is 4.18 or greater (check 4) 
$ANTIMAL = (Get-CimInstance -Namespace root\microsoft\securityclient -Classname antimalwarehealthstatus).version

if($ANTIMAL -ge "4.18") 
{ $antimalgood = 0 }
else
{ $antimalgood = 8 }
 
## Defender Endpoint Protectetion Engine Version is 1.1.17000.7 or greater (Check 5)
$EngineVer = Get-Itemproperty 'HKLM:SOFTWARE\Microsoft\Windows Defender\Signature Updates'

if ($EngineVer.EngineVersion -ge '1.1.17000.7')
{ $Enginegood = 0 }
else
{ $Enginegood = 16 }
   
## If all 5 Checks pass, then set to $true
($count = $AVCOUNT + $SVCCOUNT + $EXCLUEXIST + $antimalgood + $enginegood)
