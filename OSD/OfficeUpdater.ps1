# Install-Module OSDUpdate
# Import-Module OSDUpdate -Force
Update-ModuleOSDUpdate

#New-OSDUpdatePackage -PackageName 'Office 2016 64-Bit' -PackagePath 'C:\OfficeBuilder\Repository\Office 2016 64-Bit' -OfficeSetupUpdatesPath 'C:\OfficeBuilder\Repository\Office 2016 64-Bit2'  ## Sept 3, 2019

New-OSDUpdatePackage -PackageName 'Office 2016 64-Bit' -PackagePath 'C:\OfficeBuilder\Repository\Office 2016 64-Bit2' -RemoveSuperseded   ## Sept 3, 2019


#Update-MSOffice2016 -DownloadPath C:\OfficeBuilder -UpdatesPath c:\officeBuilder\Updates -Version '64-Bit' -GridView
#Update-MSOffice2016 -DownloadPath C:\OfficeBuilder -UpdatesPath C:\OfficeBuilder\Updates -Version '64-Bit' -GridView 

#Get-OSDUpdateDownloads -CatalogOffice 'Office 2016 64-Bit' -OfficeProfile Default -RepositoryRootPath C:\OfficeBuilder\Repository -GridView -RemoveSuperseded # -OfficeSetupUpdatesPath C:\OfficeBuilder\Updates

#Get-OSDUpdate  -GridView| Where-Object {$_.Catalog -eq 'Office 2016 64-Bit'}# | Get-DownOSDUpdate -DownloadPath C:\OfficeBuilder\Repository#

#Get-DownOSDUpdate -CatalogOffice 'Office 2016 64-Bit' -RepositoryRootPath C:\OfficeBuilder\Repository -GridView # -RemoveSuperseded # -OfficeSetupUpdatesPath C:\OfficeBuilder\Updates -OfficeProfile Default 
#Get-DownOSDUpdate -Catalog 'Office 2016 64-Bit' -DownloadPath 'C:\OfficeBuilder\Repository\Office 2016 64-Bit' -GridView

#New-OSDUpdatePackage -PackageName "Office 2016 64-Bit" -PackagePath "D:\OSDUpdate\Office\Office 2016 64-Bit" -OfficeSetupUpdatesPath "D:\MDT\Applications\Microsoft Office 2016 64-Bit\updates"

# New-OSDUpdatePackage -PackageName 'Office 2016 64-Bit' -PackagePath 'C:\OfficeBuilder\Repository\Office 2016 64-Bit' -RemoveSuperseded

#Get-OSDUpdateDownloads -CatalogWindows 'Windows 10 x64' -WindowsBuild 1709 -WindowsProfile 'AFPU Adobe Flash Player' -GridView -RepositoryRootPath C:\OfficeBuilder\Repository
#Get-OSDUpdateDownloads -CatalogWindows 'Windows 10' -windowsbuild  -GridView -RepositoryRootPath C:\OfficeBuilder\Repository

#Get-OSDUpdate

#Update-OSDdefender -DownloadPath C:\OfficeBuilder\Repository\Defender -OS 'Windows 10' -OSArch '64-Bit'
