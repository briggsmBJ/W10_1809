# // ***************************************************************************
# // 
# // ComputerInformation 
# //
# // File:      Scrape_Web_1803.ps1
# // 
# // Purpose:   Scrape Microsoft for Patch Numbers for build 17134
# // 
# // 
# // ***************************************************************************

$url ='https://support.microsoft.com/en-ca/help/4099479/windows-10-update-history'
$response = Invoke-WebRequest -Uri $url -UseBasicParsing
$1 = ($response.content -split '"minorVersions": ')[1]
$2 = (($1 -split '"subType": "release-notes"')[0])
    
cls

$Count = 0
$line = $2.Split('},')  
foreach($item in $line)
{
  if ($item.Contains('"heading":'))
  {
   
    $string = $line[$Count]
    $string = $string + ',' + $line[$Count+1]
    
    $string = $string.Replace('"heading":','')
    $string = $string.Replace('"','')
    $string = $string.Replace('(OS Build 17134.','')
    $string = $string.Replace(')','')
    $string = $string.Replace('—','pp')
    $string = $string.Replace(', ','-')
    $string = $string.Replace('pp',',')
    $string = $string -replace "KB\d{6}[0-9]\s", ''
          
    $empty = $empty+"$String"
    }
  $Count +=1
} 


$empty
