## Pester 
## Hide Progress Bars
$progressPreference = 'silentlyContinue'

## Begin Testing
Describe "App Posture" {Context "Installed Apps"{
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
        (Get-WmiObject -ComputerName localhost -Class Win32_OperatingSystem).Version  | Should Be '10.0.1'
    }

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
