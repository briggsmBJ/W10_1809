## Pester 
## Hide Progress Bars
$progressPreference = 'silentlyContinue'

## Begin Testing
Describe "App Posture" {
  Context "Installed Apps"{
    BeforeAll{
        
        $INSTAPPS = (Get-ChildItem HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\) | Get-ItemProperty | Select-Object DisplayName,DisplayVersion
        $INSTAPPS += (Get-ChildItem HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\) | Get-ItemProperty | Select-Object DisplayName,DisplayVersion

    
    }
    It "Should have Google Chrome" {
        $INSTAPPS.Where{'Google Chrome'} | Should Not BeNullOrEmpty
    }
    It "Google Chrome should BeGreaterThan version 83.0.4103.96" {
        $INSTAPPS.Where{$_.displayname -eq 'Google Chrome'}.DisplayVersion | Should BegreaterThan 83.0.4103.96
    }
    It "Should have Everything" -Skip:$true{
        $INSTAPPS.Where{$_.displayname -like 'Everything*'} | Should Not BeNullOrEmpty
    }
    It "Should have CLCL" -Skip:$true{
        $INSTAPPS.Where{$_.displayname -eq 'CLCL'} | Should Not BeNullOrEmpty
    }
    It "Should have VLC" {
        $INSTAPPS.Where{'VLC media Player'} | Should Not BeNullOrEmpty
    }
    It "VLC should BeGreaterThan version 3.0.09" {
        $INSTAPPS.Where{$_.displayname -eq 'VLC media Player'}.DisplayVersion | Should BegreaterThan 3.0.09
    }
    It "Should have Acrobat DC" {
        $INSTAPPS.Where{$_.DisplayName -like "*Acrobat DC*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Printer Installer Client" {
        $INSTAPPS.Where{$_.DisplayName -like "*Printer Installer Client*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Microsoft Access Database Engine" -Skip:$true{
        $INSTAPPS.Where{$_.DisplayName -like "*Microsoft Access Database Engine*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should NOT have Java" {
        $INSTAPPS.Where{$_.DisplayName -like "*Java*"}.DisplayVersion | Should BeNullOrEmpty
    }
    It "Should have Jabber" {
        $INSTAPPS.Where{$_.DisplayName -like "Cisco Jabber"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have InterAction" {
        $INSTAPPS.Where{$_.DisplayName -like "*LexisNexis Interac*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have AnyConnect ISE" {
        $INSTAPPS.Where{$_.DisplayName -like "*AnyConnect ISE Comp*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
        It "Should have AnyConnect ISE Posture" {
        $INSTAPPS.Where{$_.DisplayName -like "*AnyConnect ISE Posture*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Proxy Pro Host" {
        $INSTAPPS.Where{$_.DisplayName -like "*Proxy Pro Host*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should haveCisco WebEx Meetings Desktop App" {
        $INSTAPPS.Where{$_.DisplayName -like "*Cisco WebEx Meetings Desktop App*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have WebEx Productivity Tools" -skip:$true {
        $INSTAPPS.Where{$_.DisplayName -like "*WebEx Productivity Tools*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Adobe Connect" {
        $INSTAPPS.Where{$_.DisplayName -like "*Adobe Connect*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should NOT have Microsoft Visual C++ 2005 x86" {
        $INSTAPPS.Where{$_.DisplayName -like "*Microsoft Visual C++ 2005*"}.DisplayVersion | Should BeNullOrEmpty
    }
    It "Should NOT have Microsoft Visual C++ 2008 x86" {
        $INSTAPPS.Where{$_.DisplayName -like "*Microsoft Visual C++ 2008*"}.DisplayVersion | Should BeNullOrEmpty
    }
    It "Should have Microsoft Visual C++ 2010  x86 Redistributable" {
        $INSTAPPS.Where{$_.DisplayName -like "*Microsoft Visual C++ 2010  x86 Redistributable*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Microsoft Visual C++ 2012 Redistributable (x86)" {
        $INSTAPPS.Where{$_.DisplayName -like "*Microsoft Visual C++ 2012 Redistributable (x86)*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Microsoft Visual C++ 2012 Redistributable (x64)" {
        $INSTAPPS.Where{$_.DisplayName -like "*Microsoft Visual C++ 2012 Redistributable (x64)*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Microsoft Visual C++ 2013 Redistributable (x86)" {
        $INSTAPPS.Where{$_.DisplayName -like "*Microsoft Visual C++ 2013 Redistributable (x86)*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Microsoft Visual C++ 2013 Redistributable (x64)" {
        $INSTAPPS.Where{$_.DisplayName -like "*Microsoft Visual C++ 2013 Redistributable (x64)*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should NOT have Microsoft Visual C++ 2017 Redistributable (x86)" {
        $INSTAPPS.Where{$_.DisplayName -like "*Microsoft Visual C++ 2017 Redistributable (x86)*"}.DisplayVersion | Should BeNullOrEmpty
    }
    It "Should NOT have Microsoft Visual C++ 2017 Redistributable (x64)" {
        $INSTAPPS.Where{$_.DisplayName -like "*Microsoft Visual C++ 2017 Redistributable (x64)*"}.DisplayVersion | Should BeNullOrEmpty
    }
    It "Should have Microsoft Visual C++ 2015-2019 Redistributable (x86)" {
        $INSTAPPS.Where{$_.DisplayName -like "*Microsoft Visual C++ 2015-2019 Redistributable (x86)*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Microsoft Visual C++ 2015-2019 Redistributable (x64)" {
        $INSTAPPS.Where{$_.DisplayName -like "*Microsoft Visual C++ 2015-2019 Redistributable (x64)*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Microsoft Ribbon for WPF*" {
        $INSTAPPS.Where{$_.DisplayName -like "Microsoft Ribbon for WPF*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have WSLinkLauncher" {
        $INSTAPPS.Where{$_.DisplayName -like "*WSLinkLauncher*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Ivanti Environment Manager Agent" {
        $INSTAPPS.Where{$_.DisplayName -like "*Ivanti Environment Manager Agent*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Ivanti Application Control Agent" {
        $INSTAPPS.Where{$_.DisplayName -like "*Ivanti Application Control Agent*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have BJ Green Policy" {
        $INSTAPPS.Where{$_.DisplayName -like "*BJ Green Policy*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have BJ Red Policy" {
        $INSTAPPS.Where{$_.DisplayName -like "*BJ Red Policy*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have 1E Agent" {
        $INSTAPPS.Where{$_.DisplayName -like "*1E Agent*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have MDOP MBAM" {
        $INSTAPPS.Where{$_.DisplayName -like "*MDOP MBAM*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Local Administrator Password Solution" {
        $INSTAPPS.Where{$_.DisplayName -like "*Local Administrator Password Solution*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Workshare Professional" {
        $INSTAPPS.Where{$_.DisplayName -like "*Workshare Professional*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have iManage Work" {
        $INSTAPPS.Where{$_.DisplayName -like "*iManage Work*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Forte" {
        $INSTAPPS.Where{$_.DisplayName -like "*Forte*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Office Professional Plus 2016" {
        $INSTAPPS.Where{$_.DisplayName -like "*Office Professional Plus 2016*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Enterprise Vault Outlook" {
        $INSTAPPS.Where{$_.DisplayName -like "*Enterprise Vault Outlook*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Mimecast" {
        $INSTAPPS.Where{$_.DisplayName -like "*Mimecast*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Specops" {
        $INSTAPPS.Where{$_.DisplayName -like "*Specops*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Proxy Pro Host" {
        $INSTAPPS.Where{$_.DisplayName -like "*Proxy Pro Host*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have BennettJonesSignature" {
        $INSTAPPS.Where{$_.DisplayName -like "*BennettJonesSignature*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have BlueJeans" {
        $INSTAPPS.Where{$_.DisplayName -like "*BlueJeans*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Microsoft SQL Server Compact 4.0 x64" {
        $INSTAPPS.Where{$_.DisplayName -like "*Microsoft SQL Server Compact 4.0 x64*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have SentinelOne" {
        $INSTAPPS.Where{$_.DisplayName -like "*Sentinel*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have Microsoft Visual C++ 2010  x64 Redistributable" {
        $INSTAPPS.Where{$_.DisplayName -like "*Microsoft Visual C++ 2010  x64 Redistributable*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should have McAfee File and Removable Media Protection" {
        $INSTAPPS.Where{$_.DisplayName -like "*McAfee File and Removable Media Protection*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
    It "Should NOT have McAfee Endpoint Security Threat Prevention" {
        $INSTAPPS.Where{$_.DisplayName -like "*McAfee Endpoint Security Threat Prevention*"}.DisplayVersion | Should BeNullOrEmpty
    }
    It "Should have Zoom" {
        $INSTAPPS.Where{$_.DisplayName -like "*Zoom*"}.DisplayVersion | Should Not BeNullOrEmpty
    }
  }


Context "OS Version Check" {
    It "Installed Operating System is 1607" -Skip:$true{
        (Get-WmiObject -ComputerName localhost -Class Win32_OperatingSystem).Version  | Should Be '10.0.14393'
    }
    It "Installed Operating System is 1709"  {
        (Get-WmiObject -ComputerName localhost -Class Win32_OperatingSystem).Version  | Should Be '10.0.16299'
    }
    It "Installed Operating System is 1809" -Skip:$true{
        (Get-WmiObject -ComputerName localhost -Class Win32_OperatingSystem).Version  | Should Be '10.0.17763'
    }
    It "Installed Operating System is 1909" -Skip:$true{
        (Get-WmiObject -ComputerName localhost -Class Win32_OperatingSystem).Version  | Should Be '10.0.18363'
    }
    It "Installed Operating System is 2004" -Skip:$true{
        (Get-WmiObject -ComputerName localhost -Class Win32_OperatingSystem).Version  | Should Be '10.0.19033'
    }

}


  ## Services we want to test for
  $services = 'AppSense Application Manager Agent', 'CcmExec', 'iphlpsvc', 'masvc', 'ProxyHostService', 'PrinterInstallerLauncher', 'SentinelAgent', 'Windefend', 'bthserv', 'WinRM'
 
  Context -Name 'Testing that the Service is running' -Fixture {
  $services.ForEach{
   It -name "The $($_) service should be running" -test {
        (Get-Service -ServiceName $_ ).status | Should be 'Running'
      }
    }
   }
}


## Reset Progress Bars
$progressPreference = 'Continue'
