# // ***************************************************************************
# // 
# // ComputerInformation 
# //
# // File:      Scrape_Web_1607.ps1
# // 
# // Purpose:   Scrape Microsoft for Patch Numbers for build 14393
# // 
# // 
# // ***************************************************************************


$url1 ='https://support.microsoft.com/en-ca/help/4000825/windows-10-update-history'
$response1 = Invoke-WebRequest -Uri $url1 -UseBasicParsing
#clear-host
    
$11 = ($response1.content -split '"minorVersions": ')[1]
#$11 = ($response1.content -split '"sideNav": "4000816"')[1]
$21 = (($11 -split '"subType": "release-notes"')[0])

cls

$count1 = 0
$line1 = $21.Split('},')  
foreach($item1 in $line1)
{
  if ($item1.Contains('"heading":'))
  {
    $string1 = $line1[$count1]
    $string1 = $string1 + ',' + $line1[$count1+1]
    
    $string1 = $string1.Replace('"heading":','')
    $string1 = $string1.Replace('"','')
    $string1 = $string1.Replace('(OS Build 14393.','')
    $string1 = $string1.Replace(')','')
    $string1 = $string1.Replace('—','pp')
    $string1 = $string1.Replace(', ','-')
    $string1 = $string1.Replace('pp',',')
    $string1 = $string1 -replace "KB\d{6}[0-9]\s", ''
    
    
        #Write-Host $string1
        $empty1 = $empty1+"$string1"
    }
  $count1 +=1
} 
$empty1 
