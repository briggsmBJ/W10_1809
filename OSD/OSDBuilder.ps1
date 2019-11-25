## Uninstall-Module -Name OSBuilder -AllVersions -Force

#   Install-Module -Name OSDBuilder -Scope CurrentUser -Force

## Update-ModuleOSDUpdate

# Import-Module -Name OSDBuilder -Force

Get-OSDBuilder

#   osdbuilder -update

Import-OSMedia

Update-OSMedia -Download -Execute


New-OSBuildTask -EnableNetFX3 -TaskName '1809_Aug_6a_2019' -RemoveAppx -RemovePackage -RemoveCapability -DisableFeature -ContentExtraFiles -ContentScripts -EnableFeature

##  New-OSBuildTask -EnableNetFX3 -TaskName 1709_Aug_61_2019 -RemoveAppx -RemovePackage -RemoveCapability -DisableFeature -ContentExtraFiles
Update-OSMedia -Name 'Windows 10 Enterprise x64 1809 17763.615' -Download -Execute

New-OSBuild -Download -Execute ## this one uses the task  ## updated the task to install .NET 3.5


New-OSBMediaISO # Choose OSMedia (latest date?)

# New-OSBMediaUSB ## use rufus
