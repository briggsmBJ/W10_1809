$array2 = import-csv C:\users\mikes\downloads\UBR.txt
 function Get-RegistryValue($key, $value) {
    (Get-ItemProperty $key $value).$value
  }
  $UBR = Get-RegistryValue "HKLM:\software\microsoft\windows nt\currentversion" UBR
 
  $DatePatched = ((@($array2) -match $UBR).date)
  
  write-host "  Patch Release Date ($UBR) =  $DatePatched"
