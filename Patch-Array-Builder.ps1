# // ***************************************************************************
# // 
# // ComputerInformation 
# //
# // File:      Patch-Array-Builder.ps1
# // 
# // Purpose:   Scrape Microsoft for Patch Numbers for current builds
# // 
# // 
# // ***************************************************************************

Clear-Host

$w = invoke-webrequest -uri "https://support.microsoft.com/en-us/topic/windows-10-update-history-53c270dc-954f-41f7-7ced-488578904dfe"

#$w | Get-Member

#$w.StatusCode
#$w.AllElements.count

$final = $w.AllElements | Where-Object -Property tagname -EQ -Value "A" | Select-Object -Property innertext

Write-Host ''
Write-host "########" -f green
Write-host "# 1809 #" -f green
Write-host "########" -f green
Write-Host ''

$1809 = $final | Select-Object -Property * | Where-Object innertext -match '17763' | Where-Object innertext -notmatch 'Preview' | Where-Object innertext -notmatch 'band' #| ft -HideTableHeaders


$Count1809 = 0 
$line1809 = $1809.innertext  
foreach ($item1809 in $line1809) {
   $string1809 = $line1809[$Count1809]
   $string1809 = $string1809.Replace('(OS Build 17763.', '')
   $string1809 = $string1809.Replace('(OS Build OS 17763.', '')
   $string1809 = $string1809.Replace(')', '')
   $string1809 = $string1809.Replace(', ', '-')
   ($string1809 = $string1809 -replace "—KB\d{6}[0-9]\s", ',')
   
   $Count1809 += 1
}
   

Write-Host '' 
Write-host "########" -f green
Write-host "# 1909 #" -f green
Write-host "########" -f green
Write-Host '' 

$1909 = $final | Select-Object -Property * | Where-Object innertext -match '18363' | Where-Object innertext -notmatch 'Preview' | Where-Object innertext -notmatch 'band' #| ft -HideTableHeaders

$1909F = $null
$Count1909 = 0 
$line1909 = $1909.innertext  
foreach ($item1909 in $line1909) {
   $string1909 = $line1909[$Count1909]
   $string1909 = $string1909.Replace('(OS Builds 18362.', '')
   $string1909 = $string1909.Replace('(OS Build 18363.', '')
   $string1909 = $string1909.Replace('( and 18363.', '')
   $string1909 = $string1909.Replace(')', '')
   $string1909 = $string1909.Replace(', ', '-')
   $string1909 = $string1909 -replace "—KB\d{6}[0-9]\s", ','
   ($string1909 = $string1909 -replace "\sand\s\d{4}[0-9].\d{2,3}[0-9]", '')
   
   $Count1909 += 1
}

Write-Host '' 
Write-host "########" -f green
Write-host "# 2009 #" -f green
Write-host "########" -f green
Write-Host ''

$2009  = $final | Select-Object -Property * | Where-Object innertext -match '19042' | Where-Object innertext -notmatch 'Preview' | Where-Object innertext -notmatch 'band' # | ft -HideTableHeaders

$Count2009 = 0 
$line2009 = $2009.innertext  
foreach ($item2009 in $line2009) {
   $string2009 = $line2009[$Count2009]
   $string2009 = $string2009.Replace('(OS Builds 19041.', '')
   $string2009 = $string2009.Replace('( and 19042.', '')
   $string2009 = $string2009.Replace(')', '')
   $string2009 = $string2009.Replace(', ', '-')
   $string2009 = $string2009 -replace "—KB\d{6}[0-9]\s", ','
   ($string2009 = $string2009 -replace "\sand\s\d{4}[0-9].\d{2,3}[0-9]", '')
   
   $Count2009 += 1
}
