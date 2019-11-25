
# // ***************************************************************************
# // 
# // ComputerInformation 
# //
# // File:      Test_Security.ps1
# // 
# // Purpose:   Powershell Command line Script show security protocol enablement
# // 
# // 
# // ***************************************************************************

function Get-RegistryValue($key, $value) {
  (Get-ItemProperty $key $value).$value
}

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


Function Get-SSL2Status{
  $status = $null
  $status2 = $null
  try {
    $status = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server" -Name "Enabled" -ErrorAction SilentlyContinue
  }
  catch {}
  try {
    $status2 = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client" -Name "Enabled" -ErrorAction SilentlyContinue
  }
  catch {}
  If ($status -eq 0 -and $status -eq 0)
  {
    #return $false
    write-color -text "SSL2 Enabled: ", 'False' -color White, Green
  }
  else
  {
    #return $true
    #$global:DEPLOYABLE = $false;
    #$FINALERROR = 'SSL2';
    write-color -text "SSL2 Enabled: ", 'True' -color White, Red
  }
}

Function Get-SSL3Status{
  $status = $null
  $status2 = $null
  try {
    $status = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server" -Name "Enabled" -ErrorAction SilentlyContinue
  }
  catch {}
  try {
    $status2 = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client" -Name "Enabled" -ErrorAction SilentlyContinue
  }
  catch {}
  If ($status -eq 0 -and $status -eq 0)
  {
    #return $false
    write-color -text "SSL3 Enabled: ", 'False' -color White, Green
  }
  else
  {
    #return $true
    write-color -text "SSL3 Enabled: ", 'True' -color White, Red
  }
}

Function Get-NTLMStatus{
  $status = $null
  try {
    $status = Get-ItemPropertyValue -Path "HKLM:\Software\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -ErrorAction SilentlyContinue
  }
  catch {}
  If ($status -eq '0')
  {
    #return $false
    write-color -text "NTLM Enabled: ", 'False' -color White, Green
  }
  else
  {
    #return $true
    write-color -text "NTLM Enabled: ", 'True' -color White, Red
  }

}

Function Get-TLS10Status{
  $status = $null
  $status2 = $null
  try {
    $status = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "Enabled" -ErrorAction SilentlyContinue
  }
  catch {}
  try {
    $status2 = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "Enabled" -ErrorAction SilentlyContinue
  }
  catch {}
  If ($status -eq 0 -and $status -eq 0)
  {
    #return $false
    write-color -text "TLS1.0 Enabled: ", 'False' -color White, Green         
  }
  else
  {
    #return $true
    write-color -text "TLS1.0 Enabled: ", 'True' -color White, red
  }
}

Function Get-TLS11Status{
  $status = $null
  $status2 = $null
  try {
    $status = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "Enabled" -ErrorAction SilentlyContinue
  }
  catch {}
  try {
    $status2 = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "Enabled" -ErrorAction SilentlyContinue
  }
  catch {}
  If ($status -eq 0 -and $status -eq 0)
  {
    #return $false
    write-color -text "TLS1.1 Enabled: ", 'False' -color White, Green 
  }
  else
  {
    #return $true
    write-color -text "TLS1.1 Enabled: ", 'True' -color White, red
  }
}

Function Get-TLS12Status{
  $status = $null
  $status2 = $null
  try {
    $status = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" -Name "Enabled" -ErrorAction SilentlyContinue
  }
  catch {}
  try {
    $status2 = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" -Name "Enabled" -ErrorAction SilentlyContinue
  }
  catch {}
  If ($status -eq 0 -and $status -eq 0)
  {
    #return $false
    write-color -text "TLS1.2 Enabled: ", 'False' -color White, Green 
  }
  else
  {
    #return $true
    write-color -text "TLS1.2 Enabled: ", 'True' -color White, red
  }
}

Function Get-CipherRC4128Status{
  $status = $null
  $status2 = $null
  try {
    $status = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128" -Name "Enabled" -ErrorAction SilentlyContinue
  }
  catch {}
  If ($status -ne 0)
  {
    #return $false
    write-color -text "Cipher RC4 128 Enabled: ", 'False' -color White, Green
  }
  else
  {
    #return $true
    write-color -text "Cipher RC4 128 Enabled: ", 'False' -color White, red
  }
}

Function Get-CipherRC440Status{
  $status = $null
  $status2 = $null
  try {
    $status = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128" -Name "Enabled" -ErrorAction SilentlyContinue
  }
  catch {}
  If ($status -ne 0)
  {
    #return $false
    write-color -text "Cipher RC4 40 Enabled : ", 'False' -color White, Green
  }
  else
  {
    #return $true
    write-color -text "Cipher RC4 40 Enabled : ", 'True' -color White, red
  }
}

Function Get-CipherRC456Status{
  $status = $null
  $status2 = $null
  try {
    $status = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128" -Name "Enabled" -ErrorAction SilentlyContinue
  }
  catch {}
  If ($status -ne 0)
  {
    #return $false
    write-color -text "Cipher RC4 56 Enabled : ", 'False' -color White, Green
  }
  else
  {
    #return $true
    write-color -text "Cipher RC4 56 Enabled : ", 'True' -color White, Red
  }
}

Function Get-DOTNETSTRONGCRYPTO{
  $status = $null
  try {
    if  (test-path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319\chUseStrongCrypto')
    {
      $status = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319'
    }
  }
  catch {}
  If ($status -ne '1')
  {
    #return $false;
    write-color -text ".NET STRONGCRYPTO Enabled: ", 'False' -color White, Red
  }
  else
  {
    #return $true;
    write-color -text ".NET STRONGCRYPTO Enabled: ", 'True' -color White, Green
  }
}

Function Get-LLMNR{
  $status = $null
  try {
    if  (test-path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient')
    {
      $status = Get-ItemProperty 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient' EnableMulticast
    }
  }
  catch {}
  If ($status.enablemulticast -eq '0')
  {
    #return $false;
    write-color -text "Multicast Name Resolution (LLMNR) is enabled: ", 'False' -color White, Green
  }
  else
  {
    #return $true;
    write-color -text "Multicast Name Resolution (LLMNR) is enabled: ", 'True' -color White, Red
  }
}

Write-host ''
Get-NTLMStatus
Get-LLMNR
Get-DOTNETSTRONGCRYPTO
Write-host ''

Get-SSL2Status
Get-SSL3Status
Write-host ''

Get-TLS10Status
Get-TLS11Status
Get-TLS12Status
Write-host ''

Get-CipherRC4128Status
Get-CipherRC440Status
Get-CipherRC456Status
