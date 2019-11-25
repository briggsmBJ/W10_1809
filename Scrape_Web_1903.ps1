# // ***************************************************************************
# // 
# // ComputerInformation 
# //
# // File:      Scrape_Web_1903.ps1
# // 
# // Purpose: Scrape Microsoft for Patch Numbers for build 18362/18363 (1903/1909)
# // 
# // 
# // ***************************************************************************

$url = 'https://support.microsoft.com/en-ca/help/4498140/windows-10-update-history'
$response = Invoke-WebRequest -Uri $url -UseBasicParsing
$1 = ($response.content -split '"minorVersions": ')[1]
$2 = (($1 -split '"subType": "release-notes"')[0])
    
Clear-Host

$Count = 0
$line = $2.Split('},')  
foreach ($item in $line) {
    if ($item.Contains('"heading":')) {
   
        $string = $line[$Count]
        $string = $string + ',' + $line[$Count + 1]
    
        $string = $string.Replace('"heading":', '')
        $string = $string.Replace('"', '')
        $string = $string.Replace('(OS Build 18362.', '')
        $string = $string.Replace(')', '')
        $string = $string.Replace('â', 'pp')
        $string = $string.Replace(', ', '-')
        $string = $string.Replace('pp', ',')
        $string = $string -replace "KB\d{6}[0-9]\s", ''
          
        $empty = $empty + "$String"
    }
    $Count += 1
} 


$empty
