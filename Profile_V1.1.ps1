$size = $Host.UI.RawUI.WindowSize
$size.Width = 80
$size.Height = 55
$Host.UI.RawUI.WindowSize = $size
$PSVersionTable.add("OS",(Get-WmiObject win32_operatingsystem).caption)

whoami /all | %{
    #####################        HIGH   (Purple)      ##################
    if ($_ -like "*S-1-16-12288*") {
        (get-host).ui.rawui.backgroundcolor="DarkMagenta"
        (get-host).ui.rawui.ForegroundColor="Green"
        $Host.Ui.RawUI.WindowTitle = "Integrity Level High - Running as: " + $env:Username
        cls
        exit
    }  
    #####################       System   (Yellow)      ##################
    elseif ($_ -like "*S-1-16-16384*") {
        (get-host).ui.rawui.backgroundcolor="Yellow"
        (get-host).ui.rawui.ForegroundColor="Black"
        $Host.Ui.RawUI.WindowTitle = "Integrity Level System - Running as: " + $env:Username
        cls
        exit
    }
    #####################       Medium (Blue)      ##################
    elseif ($_ -like "*S-1-16-8192*") {        
        $Host.Ui.RawUI.WindowTitle = "Integrity Level Medium - Running as: " + $env:Username
        (get-host).ui.rawui.backgroundcolor="Blue"
        (get-host).ui.rawui.ForegroundColor="White"
        cls
        exit
    }
}
