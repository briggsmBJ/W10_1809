# // ***************************************************************************
# // 
# // ComputerInformation 
# //
# // File:      ComputerInformation.ps1
# // 
# // Purpose:   GUI to tell people IP address, patch level, VPN Status, etc
# // 
# // 
# // ***************************************************************************

# .Net methods for hiding/showing the console in the background
Add-Type -Name Window -Namespace Console -MemberDefinition '
  [DllImport("Kernel32.dll")]
  public static extern IntPtr GetConsoleWindow();

  [DllImport("user32.dll")]
  public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
function Hide-Console
{
  $consolePtr = [Console.Window]::GetConsoleWindow()
  #0 hide
  [Console.Window]::ShowWindow($consolePtr, 0)
}
Hide-Console | Out-Null

Function New-WPFMessageBox {

  # For examples for use, see my blog:
  # https://smsagent.wordpress.com/2017/08/24/a-customisable-wpf-messagebox-for-powershell/
    
  # CHANGES
  # 2017-09-11 - Added some required assemblies in the dynamic parameters to avoid errors when run from the PS console host.
    
  # Define Parameters
  [CmdletBinding()]
  Param
  (
    # The popup Content
    [Parameter(Mandatory=$True,Position=0)]
    [Object]$Content,

    # The window title
    [Parameter(Mandatory=$false,Position=1)]
    [string]$Title,

    # The buttons to add
    [Parameter(Mandatory=$false,Position=2)]
    [ValidateSet('OK','OK-Cancel','Abort-Retry-Ignore','Yes-No-Cancel','Yes-No','Retry-Cancel','Cancel-TryAgain-Continue','None')]
    [array]$ButtonType = 'OK',

    # The buttons to add
    [Parameter(Mandatory=$false,Position=3)]
    [array]$CustomButtons,

    # Content font size
    [Parameter(Mandatory=$false,Position=4)]
    [int]$ContentFontSize = 14,

    # Title font size
    [Parameter(Mandatory=$false,Position=5)]
    [int]$TitleFontSize = 14,

    # BorderThickness
    [Parameter(Mandatory=$false,Position=6)]
    [int]$BorderThickness = 0,

    # CornerRadius
    [Parameter(Mandatory=$false,Position=7)]
    [int]$CornerRadius = 8,

    # ShadowDepth
    [Parameter(Mandatory=$false,Position=8)]
    [int]$ShadowDepth = 3,

    # BlurRadius
    [Parameter(Mandatory=$false,Position=9)]
    [int]$BlurRadius = 20,

    # WindowHost
    [Parameter(Mandatory=$false,Position=10)]
    [object]$WindowHost,

    # Timeout in seconds,
    [Parameter(Mandatory=$false,Position=11)]
    [int]$Timeout,

    # Code for Window Loaded event,
    [Parameter(Mandatory=$false,Position=12)]
    [scriptblock]$OnLoaded,

    # Code for Window Closed event,
    [Parameter(Mandatory=$false,Position=13)]
    [scriptblock]$OnClosed

  )

  # Dynamically Populated parameters
  DynamicParam {
        
    # Add assemblies for use in PS Console 
    Add-Type -AssemblyName System.Drawing, PresentationCore
        
    # ContentBackground
    $ContentBackground = 'ContentBackground'
    $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
    $ParameterAttribute.Mandatory = $False
    $AttributeCollection.Add($ParameterAttribute) 
    $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
    $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
    $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
    $AttributeCollection.Add($ValidateSetAttribute)
    $PSBoundParameters.ContentBackground = "White"
    $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ContentBackground, [string], $AttributeCollection)
    $RuntimeParameterDictionary.Add($ContentBackground, $RuntimeParameter)
        

    # FontFamily
    $FontFamily = 'FontFamily'
    $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
    $ParameterAttribute.Mandatory = $False
    $AttributeCollection.Add($ParameterAttribute)  
    $arrSet = [System.Drawing.FontFamily]::Families | Select -ExpandProperty Name 
    $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
    $AttributeCollection.Add($ValidateSetAttribute)
    $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($FontFamily, [string], $AttributeCollection)
    $RuntimeParameterDictionary.Add($FontFamily, $RuntimeParameter)
    $PSBoundParameters.FontFamily = "Segui"

    # TitleFontWeight
    $TitleFontWeight = 'TitleFontWeight'
    $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
    $ParameterAttribute.Mandatory = $False
    $AttributeCollection.Add($ParameterAttribute) 
    $arrSet = [System.Windows.FontWeights] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
    $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
    $AttributeCollection.Add($ValidateSetAttribute)
    $PSBoundParameters.TitleFontWeight = "Normal"
    $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($TitleFontWeight, [string], $AttributeCollection)
    $RuntimeParameterDictionary.Add($TitleFontWeight, $RuntimeParameter)

    # ContentFontWeight
    $ContentFontWeight = 'ContentFontWeight'
    $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
    $ParameterAttribute.Mandatory = $False
    $AttributeCollection.Add($ParameterAttribute) 
    $arrSet = [System.Windows.FontWeights] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
    $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
    $AttributeCollection.Add($ValidateSetAttribute)
    $PSBoundParameters.ContentFontWeight = "Normal"
    $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ContentFontWeight, [string], $AttributeCollection)
    $RuntimeParameterDictionary.Add($ContentFontWeight, $RuntimeParameter)
        

    # ContentTextForeground
    $ContentTextForeground = 'ContentTextForeground'
    $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
    $ParameterAttribute.Mandatory = $False
    $AttributeCollection.Add($ParameterAttribute) 
    $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
    $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
    $AttributeCollection.Add($ValidateSetAttribute)
    $PSBoundParameters.ContentTextForeground = "Black"
    $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ContentTextForeground, [string], $AttributeCollection)
    $RuntimeParameterDictionary.Add($ContentTextForeground, $RuntimeParameter)

    # TitleTextForeground
    $TitleTextForeground = 'TitleTextForeground'
    $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
    $ParameterAttribute.Mandatory = $False
    $AttributeCollection.Add($ParameterAttribute) 
    $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
    $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
    $AttributeCollection.Add($ValidateSetAttribute)
    $PSBoundParameters.TitleTextForeground = "Black"
    $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($TitleTextForeground, [string], $AttributeCollection)
    $RuntimeParameterDictionary.Add($TitleTextForeground, $RuntimeParameter)

    # BorderBrush
    $BorderBrush = 'BorderBrush'
    $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
    $ParameterAttribute.Mandatory = $False
    $AttributeCollection.Add($ParameterAttribute) 
    $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
    $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
    $AttributeCollection.Add($ValidateSetAttribute)
    $PSBoundParameters.BorderBrush = "Black"
    $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($BorderBrush, [string], $AttributeCollection)
    $RuntimeParameterDictionary.Add($BorderBrush, $RuntimeParameter)


    # TitleBackground
    $TitleBackground = 'TitleBackground'
    $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
    $ParameterAttribute.Mandatory = $False
    $AttributeCollection.Add($ParameterAttribute) 
    $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
    $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
    $AttributeCollection.Add($ValidateSetAttribute)
    $PSBoundParameters.TitleBackground = "White"
    $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($TitleBackground, [string], $AttributeCollection)
    $RuntimeParameterDictionary.Add($TitleBackground, $RuntimeParameter)

    # ButtonTextForeground
    $ButtonTextForeground = 'ButtonTextForeground'
    $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
    $ParameterAttribute.Mandatory = $False
    $AttributeCollection.Add($ParameterAttribute) 
    $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
    $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
    $AttributeCollection.Add($ValidateSetAttribute)
    $PSBoundParameters.ButtonTextForeground = "Black"
    $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ButtonTextForeground, [string], $AttributeCollection)
    $RuntimeParameterDictionary.Add($ButtonTextForeground, $RuntimeParameter)

    # Sound
    $Sound = 'Sound'
    $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
    $ParameterAttribute.Mandatory = $False
    #$ParameterAttribute.Position = 14
    $AttributeCollection.Add($ParameterAttribute) 
    $arrSet = (Get-ChildItem "$env:SystemDrive\Windows\Media" -Filter Windows* | Select -ExpandProperty Name).Replace('.wav','')
    $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
    $AttributeCollection.Add($ValidateSetAttribute)
    $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($Sound, [string], $AttributeCollection)
    $RuntimeParameterDictionary.Add($Sound, $RuntimeParameter)

    return $RuntimeParameterDictionary
  }

  Begin {
    Add-Type -AssemblyName PresentationFramework
  }
    
  Process {

    # Define the XAML markup
    [XML]$Xaml = @"
<Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        x:Name="Window" Title="" SizeToContent="WidthAndHeight" WindowStartupLocation="CenterScreen" WindowStyle="None" ResizeMode="NoResize" AllowsTransparency="True" Background="Transparent" Opacity="1">
    <Window.Resources>
        <Style TargetType="{x:Type Button}">
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border>
                            <Grid Background="{TemplateBinding Background}">
                                <ContentPresenter />
                            </Grid>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>
    <Border x:Name="MainBorder" Margin="10" CornerRadius="$CornerRadius" BorderThickness="$BorderThickness" BorderBrush="$($PSBoundParameters.BorderBrush)" Padding="0" >
        <Border.Effect>
            <DropShadowEffect x:Name="DSE" Color="Black" Direction="270" BlurRadius="$BlurRadius" ShadowDepth="$ShadowDepth" Opacity="0.6" />
        </Border.Effect>
        <Border.Triggers>
            <EventTrigger RoutedEvent="Window.Loaded">
                <BeginStoryboard>
                    <Storyboard>
                        <DoubleAnimation Storyboard.TargetName="DSE" Storyboard.TargetProperty="ShadowDepth" From="0" To="$ShadowDepth" Duration="0:0:1" AutoReverse="False" />
                        <DoubleAnimation Storyboard.TargetName="DSE" Storyboard.TargetProperty="BlurRadius" From="0" To="$BlurRadius" Duration="0:0:1" AutoReverse="False" />
                    </Storyboard>
                </BeginStoryboard>
            </EventTrigger>
        </Border.Triggers>
        <Grid >
            <Border Name="Mask" CornerRadius="$CornerRadius" Background="$($PSBoundParameters.ContentBackground)" />
            <Grid x:Name="Grid" Background="$($PSBoundParameters.ContentBackground)">
                <Grid.OpacityMask>
                    <VisualBrush Visual="{Binding ElementName=Mask}"/>
                </Grid.OpacityMask>
                <StackPanel Name="StackPanel" >                   
                    <TextBox Name="TitleBar" IsReadOnly="True" IsHitTestVisible="False" Text="$Title" Padding="10" FontFamily="$($PSBoundParameters.FontFamily)" FontSize="$TitleFontSize" Foreground="$($PSBoundParameters.TitleTextForeground)" FontWeight="$($PSBoundParameters.TitleFontWeight)" Background="$($PSBoundParameters.TitleBackground)" HorizontalAlignment="Stretch" VerticalAlignment="Center" Width="Auto" HorizontalContentAlignment="Center" BorderThickness="0"/>
                    <DockPanel Name="ContentHost" Margin="0,10,0,10"  >
                    </DockPanel>
                    <DockPanel Name="ButtonHost" LastChildFill="False" HorizontalAlignment="Center" >
                    </DockPanel>
                </StackPanel>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

    [XML]$ButtonXaml = @"
<Button xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Width="Auto" Height="30" FontFamily="Segui" FontSize="16" Background="Transparent" Foreground="White" BorderThickness="1" Margin="10" Padding="20,0,20,0" HorizontalAlignment="Right" Cursor="Hand"/>
"@

    [XML]$ButtonTextXaml = @"
<TextBlock xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" FontFamily="$($PSBoundParameters.FontFamily)" FontSize="16" Background="Transparent" Foreground="$($PSBoundParameters.ButtonTextForeground)" Padding="20,5,20,5" HorizontalAlignment="Center" VerticalAlignment="Center"/>
"@

    [XML]$ContentTextXaml = @"
<TextBlock xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Text="$Content" Foreground="$($PSBoundParameters.ContentTextForeground)" DockPanel.Dock="Right" HorizontalAlignment="Center" VerticalAlignment="Center" FontFamily="$($PSBoundParameters.FontFamily)" FontSize="$ContentFontSize" FontWeight="$($PSBoundParameters.ContentFontWeight)" TextWrapping="Wrap" Height="Auto" MaxWidth="500" MinWidth="50" Padding="10"/>
"@

    # Load the window from XAML
    $Window = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $xaml))

    # Custom function to add a button
    Function Add-Button {
      Param($Content)
      $Button = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $ButtonXaml))
      $ButtonText = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $ButtonTextXaml))
      $ButtonText.Text = "$Content"
      $Button.Content = $ButtonText
      $Button.Add_MouseEnter({
          $This.Content.FontSize = "17"
      })
      $Button.Add_MouseLeave({
          $This.Content.FontSize = "16"
      })
      $Button.Add_Click({
          New-Variable -Name WPFMessageBoxOutput -Value $($This.Content.Text) -Option ReadOnly -Scope Script -Force
          $Window.Close()
      })
      $Window.FindName('ButtonHost').AddChild($Button)
    }

    # Add buttons
    If ($ButtonType -eq "OK")
    {
      Add-Button -Content "OK"
    }

    If ($ButtonType -eq "OK-Cancel")
    {
      Add-Button -Content "OK"
      Add-Button -Content "Cancel"
    }

    If ($ButtonType -eq "Abort-Retry-Ignore")
    {
      Add-Button -Content "Abort"
      Add-Button -Content "Retry"
      Add-Button -Content "Ignore"
    }

    If ($ButtonType -eq "Yes-No-Cancel")
    {
      Add-Button -Content "Yes"
      Add-Button -Content "No"
      Add-Button -Content "Cancel"
    }

    If ($ButtonType -eq "Yes-No")
    {
      Add-Button -Content "Yes"
      Add-Button -Content "No"
    }

    If ($ButtonType -eq "Retry-Cancel")
    {
      Add-Button -Content "Retry"
      Add-Button -Content "Cancel"
    }

    If ($ButtonType -eq "Cancel-TryAgain-Continue")
    {
      Add-Button -Content "Cancel"
      Add-Button -Content "TryAgain"
      Add-Button -Content "Continue"
    }

    If ($ButtonType -eq "None" -and $CustomButtons)
    {
      Foreach ($CustomButton in $CustomButtons)
      {
        Add-Button -Content "$CustomButton"
      }
    }

    # Remove the title bar if no title is provided
    If ($Title -eq "")
    {
      $TitleBar = $Window.FindName('TitleBar')
      $Window.FindName('StackPanel').Children.Remove($TitleBar)
    }

    # Add the Content
    If ($Content -is [String])
    {
      # Replace double quotes with single to avoid quote issues in strings
      If ($Content -match '"')
      {
        $Content = $Content.Replace('"',"'")
      }
        
      # Use a text box for a string value...
      $ContentTextBox = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $ContentTextXaml))
      $Window.FindName('ContentHost').AddChild($ContentTextBox)
    }
    Else
    {
      # ...or add a WPF element as a child
      Try
      {
        $Window.FindName('ContentHost').AddChild($Content) 
      }
      Catch
      {
        $_
      }        
    }

    # Enable window to move when dragged
    $Window.FindName('Grid').Add_MouseLeftButtonDown({
        $Window.DragMove()
    })

    # Activate the window on loading
    If ($OnLoaded)
    {
      $Window.Add_Loaded({
          $This.Activate()
          Invoke-Command $OnLoaded
      })
    }
    Else
    {
      $Window.Add_Loaded({
          $This.Activate()
      })
    }
    

    # Stop the dispatcher timer if exists
    If ($OnClosed)
    {
      $Window.Add_Closed({
          If ($DispatcherTimer)
          {
            $DispatcherTimer.Stop()
          }
          Invoke-Command $OnClosed
      })
    }
    Else
    {
      $Window.Add_Closed({
          If ($DispatcherTimer)
          {
            $DispatcherTimer.Stop()
          }
      })
    }
    

    # If a window host is provided assign it as the owner
    If ($WindowHost)
    {
      $Window.Owner = $WindowHost
      $Window.WindowStartupLocation = "CenterOwner"
    }

    # If a timeout value is provided, use a dispatcher timer to close the window when timeout is reached
    If ($Timeout)
    {
      $Stopwatch = New-object System.Diagnostics.Stopwatch
      $TimerCode = {
        If ($Stopwatch.Elapsed.TotalSeconds -ge $Timeout)
        {
          $Stopwatch.Stop()
          $Window.Close()
        }
      }
      $DispatcherTimer = New-Object -TypeName System.Windows.Threading.DispatcherTimer
      $DispatcherTimer.Interval = [TimeSpan]::FromSeconds(1)
      $DispatcherTimer.Add_Tick($TimerCode)
      $Stopwatch.Start()
      $DispatcherTimer.Start()
    }

    # Play a sound
    If ($($PSBoundParameters.Sound))
    {
      $SoundFile = "$env:SystemDrive\Windows\Media\$($PSBoundParameters.Sound).wav"
      $SoundPlayer = New-Object System.Media.SoundPlayer -ArgumentList $SoundFile
      $SoundPlayer.Add_LoadCompleted({
          $This.Play()
          $This.Dispose()
      })
      $SoundPlayer.LoadAsync()
    }

    # Display the window
    $null = $window.Dispatcher.InvokeAsync{$window.ShowDialog()}.Wait()

  }
}
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

function global:GET-CName {
  param([string]$DN)

  # Split the Distinguished name into separate bits
  #
  $Parts=$DN.Split(",")

  # Figure out how deep the Rabbit Hold goes
  #
  $NumParts=$Parts.Count

  # Although typically 2 DC entries, make sure and figure out the length of the FQDN
  #
  $FQDNPieces=($Parts -match 'DC=').Count

  # Keep track of where the FQDN is (calling it the middle even if it
  # Could be WAY out there somewhere
  #
  $Middle=$NumParts-$FQDNPieces

  # Build the CN.  First part is separated by '.'
  # 
  foreach ($x in ($Middle+1)..($NumParts)) {
    $CN+=$Parts[$x-1].SubString(3)+'.'
  }

  # Get rid of that extra Dot
  #
  $CN=$CN.substring(0,($CN.length)-1)

  # Now go BACKWARDS and build the rest of the CN
  #
  foreach ($x in ($Middle-1)..0) { 
    $Parts[$x].substring(3)
    $CN+="/"+$Parts[$x].SubString(3)
  }

  Return $CN
}

function Test-IpAddressInRange {
  [CmdletBinding()]
  param (
    [Parameter(Position = 0, Mandatory = $true)][ipaddress]$from,
    [Parameter(Position = 1, Mandatory = $true)][ipaddress]$to,
    [Parameter(Position = 2, Mandatory = $true)][ipaddress]$target
  )
  $f=$from.GetAddressBytes()|%{"{0:000}" -f $_}   | & {$ofs='-';"$input"}
  $t=$to.GetAddressBytes()|%{"{0:000}" -f $_}   | & {$ofs='-';"$input"}
  $tg=$target.GetAddressBytes()|%{"{0:000}" -f $_}   | & {$ofs='-';"$input"}
  return ($f -le $tg) -and ($t -ge $tg)
}

## Is Direct Access Connected?
#if (((Get-NetAdapter | Where-Object {($_.PhysicalMediaType -eq 'Native 802.11') -or ($_.PhysicalMediaType -eq 'Wireless LAN') -or ($_.PhysicalMediaType -eq 'Wireless WAN') }).Status) -eq "Up") {$TESTDA = (Get-NetIPHttpsState).InterfaceStatus;IF ($TESTDA -eq "IPHTTPS interface active"){$DA = "1"}}
if (((Get-NetAdapter | Where-Object {($_.PhysicalMediaType -eq 'Native 802.11') -or ($_.PhysicalMediaType -eq 'Wireless LAN') -or ($_.PhysicalMediaType -eq 'Wireless WAN') }).Status) -eq "Up") {$TESTDA = ((netsh interface httpstunnel show interface | select-string -Pattern "Interface Status") -split(': ')-split(': '))[1];IF ($TESTDA -eq "IPHTTPS interface active "){$DA = "1"}} ## needs a space

# Get IP Address
IF ($DA -eq '1') 
{
  $IP = Get-WmiObject Win32_NetworkAdapterConfiguration | Select IPAddress | Where { $_.IPAddress } | Select -Expand IPAddress | Where-Object {$_ -notlike '192.*'}
}
Else
{
  $IP = Get-WmiObject Win32_NetworkAdapterConfiguration | Select IPAddress | Where { $_.IPAddress } | Select -Expand IPAddress | where { $_ -like '172.*'}
  $VPN = (Test-IpAddressInRange "172.21.16.0" "172.21.19.255" $IP)
}




# Get Gateway
$GATEWAY = (Get-wmiObject Win32_networkAdapterConfiguration | ?{$_.IPEnabled}).DefaultIPGateway

# Get Mac Address
$MACADDRESS = Get-WMIObject win32_NetworkAdapterConfiguration -filter "IPEnabled = $true" |
Foreach-Object { $_.MACAddress } | Where { $_ -notlike '00*' } # Filter out IP's from VMWare

# Get Computername
$COMPUTERNAME = gc env:computername

# Get EM Config Version
$Alluninstallkeys = Get-ChildItem "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\" -Recurse
ForEach ($key in $Alluninstallkeys){$UninstKey = Get-ItemProperty -Path $key.PsPath
If ($UninstKey.DisplayName -like "*Environment Manager Configuration*") {$EMCONFIG = "$(($UninstKey.DisplayName -Split "'")[1,2])"}}

# Get AM Config Version
ForEach ($key in $Alluninstallkeys){$UninstKey = Get-ItemProperty -Path $key.PsPath
If ($UninstKey.DisplayName -like "*Ivanti Application Control*") {$AMCONFIG = "$(($UninstKey.DisplayName -Split "'")[1,2])"}}

# Get Location
#$filter1 = "(&(objectCategory=computer)(objectClass=computer)(cn=$env:COMPUTERNAME))"
#$DN1 = ([adsisearcher]$filter1).FindOne().Properties.distinguishedname
#$filter = "(&(objectCategory=computer)(objectClass=computer)(cn=$env:COMPUTERNAME))"
#$DN1 = ([adsisearcher]$filter).FindOne().Properties.distinguishedname
$DN1 = Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine' | Get-ItemPropertyValue -Name 'Distinguished-Name'
$CN1 = (GET-CName -DN $dn1).item(1)
$CN2 = (GET-CName -DN $dn1).item(2)
$CN3 = (GET-CName -DN $dn1).item(3)
$CN4 = (GET-CName -DN $dn1).item(4)

$OU1 = $cn1+" \ "+$cn2+" \ "+$CN3

#determine if IPU or OSD
if (((Get-ChildItem -Path  "HKLM:\SOFTWARE\WaaS").name.count) -ge '2')
{
  $BUILDTYPE ="IPU"
}
else
{
  $BUILDTYPE =  "OSD"
} 
#$BUILDTYPE

#get Build Version
$BUILDVER = Get-Content C:\BJ_W10_Version.txt
$BJBUILDVER = $BUILDVER.split(".")[1]
# Get Logged in User
$LOGGEDINUSER = gc env:username

<#
    #get winver
    $MAJOR = ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name CurrentBuildNumber).CurrentBuildNumber); 
    $MINOR = ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name UBR).UBR); 
    $MSWINVER = "$MAJOR.$MINOR"

#>
function Get-RegistryValue($key, $value) {
  (Get-ItemProperty $key $value).$value
}
$UBR = Get-RegistryValue "HKLM:\software\microsoft\windows nt\currentversion" UBR
$WINVER = Get-RegistryValue "HKLM:\software\microsoft\windows nt\currentversion" ReleaseID
$SCCMCLIENT = Get-RegistryValue "HKLM:\SOFTWARE\Microsoft\SMS\Mobile Client" SmsClientVersion

If ($WINVER -ieq '1607'){
  $array = @'
Date,UBR
June 18-2019,3053
June 11-2019,3025
May 23-2019,2999
May 19-2019,2972
May 14-2019,2969
April 25-2019,2941
April 9-2019,2906
March 19-2019,2879
March 12-2019,2848
February 19-2019,2828
February 12-2019,2791
January 17-2019,2759
January 8-2019,2724
December 19-2018,2670
December 11-2018,2665
December 3-2018,2641
November 27-201,2639
November 13-2018,2608
October 18-2018,2580
October 9-2018,2551
September 20-2018,2515
September 11-2018,2485
August 30-2018,2457
August 14-2018,2430
July 30-2018,2396
July 24-2018,2395
July 16-2018,2368
July 10-2018,2363
June 21-2018,2339
June 12-2018,2312
May 17-2018,2273
May 8-2018,2248
April 17-2018,2214
April 10-2018,2189
March 29-2018,2156
March 22-2018,2155
March 13-2018,2126
March 13-2018,2125
February 22-2018,2097
February 13-2018,2068
January 17-2018,2034
January 3-2018,2007
December 12-2017,1944
November 27-2017,1914
November 14-2017,1884
November 2-2017,1797
October 17-2017,1794
October 10-2017,1770
September 28-2017,1737
September 12-2017,1715
August 28-2017,1670
August 16-2017,1613
August 8-2017,1593
August 7-2017,1537
July 18-2017,1532
July 11-2017,1480
June 27-2017,1378
June 13-2017,1358
May 26-2017,1230
May 9-2017,1198
April 11-2017,1083
April 11-2017,1066
March 22-2017,970
March 20-2017,969
March 14-2017,953
January 30-2017,729
January 26-2017,726
January 10-2017,693
December 13-2016 576
December 9-2016,479
November 9-2016,448
November 8-2016,447
October 27-2016,351
October 11-2016,321
September 29-2016,222
September 20-2016,189
September 13-2016,189
September 13-2016,187
August 31-2016,105
August 23-2016,82
August 9-2016,51
August 2-2016,10
'@ | convertfrom-csv
}
If ($WINVER -ieq '1709'){
  $array = @'
Date,UBR
November 12-2019,1508
October 15-2019,1481
October 8-2019,1451
October 3-2019,1421
September 24-2019,1420
September 23-2019,1392
September 10-2019,1387
August 16-2019,1365
August 13-2019,1331
July 16-2019,1296 
July 9-2019,1268
June 26-2019,1239
June 18-2019,1237
June 11-2019,1217
May 28-2019,1182
May 19-2019,1150
May 14-2019,1146
April 25-2019,1127
April 9-2019,1087
March 19-2019,1059
March 12-2019,1029
February 19-2019,1004
February 12-2019,967
January 15-2019,936
January 8-2019,904
December 19-2018,847
December 11-2018,846
December 11-2018,544
November 27-2018,820
November 13-2018,785
October 18-2018,755
October 9-2018,726
September 26-2018,699
September 17-2018,666
September 11-2018,665
August 30-2018,637
August 14-2018,611
July 24-2018,579
July 16-2018,551
July 10-2018,547
June 21-2018,522
June 12-2018,492
May 21-2018,461
May 8-2018,431
April 23-2018,402
April 10-2018,371
March 22-2018,334
March 13-2018,309
March 5-2018,251
February 13-2018,248
January 31-2018,214
January 18-2018,201
January 3-2018,192
December 12-2017,125
November 30-2017,98
November 14-2017,64
October 17-2017,19
'@ | convertfrom-csv
}
If ($WINVER -ieq '1803'){
  $array = @'
Date,UBR
May 14-2019,765
April 25-2019,753
April 9-2019,706
March 19-2019,677
March 12-2019,648
February 19-2019,619
February 12-2019,590
January 15-2019,556
January 8-2019,523
December 19-2018,472
December 11-2018,471
November 27-2018,441
November 13-2018,407
October 24-2018,376
October 9-2018,345
September 26-2018,320
September 17-2018,286
September 11-2018,285
August 30-2018,254
August 14-2018,228
July 24-2018,191
July 16-2018,167
July 10-2018,165
June 26-2018,137
June 12-2018,112
June 5-2018,83
May 23-2018,81
May 8-2018,48
'@ | convertfrom-csv
}
If ($WINVER -ieq '1809'){
  $array = @'
Date,UBR
November 12-2019,864
October 15-2019,832
October 8-2019,805
October 3-2019,775
September 24-2019,774
September 23-2019,740
September 10-2019,737
August 17-2019,720
August 13-2019,678
July 22-2019,652
July 9-2019,615
June 26-2019,593
June 18-2019,592
June 11-2019,557
May 21-2019,529
May 19-2019,504
May 14-2019,503
May 3-2019,475
May 1-2019,439
April 9-2019,437
April 2-2019,404
March 12-2019,379
March 1-2019,348
February 12-2019,316
January 22-2019,292
January 8-2019,253
December 19-2018,195
December 11-2018,194
December 5-2018,168
November 13-2018,134)
November 13-2018,107)
October 9-2018,55)
'@ | convertfrom-csv
}

$DatePatched = ((@($array) -match $UBR).date)

#*****************************************************************************************
#*****************************************************************************************
$SCCMCLIENT_PROD = '5.00.8553.1020'
#*****************************************************************************************
#*****************************************************************************************

[nullable[datetime]]$LastBootUpTime = (Get-Date -ErrorAction 'Stop') - ([timespan]::FromMilliseconds([math]::Abs([Environment]::TickCount))) 
 
$TextBlock = New-Object System.Windows.Controls.TextBlock
$TextBlock.Text = "  Computer Name = $COMPUTERNAME"
$TextBlock.FontSize = "18"
$TextBlock.HorizontalAlignment = "Left"

$TextBlock1 = New-Object System.Windows.Controls.TextBlock
$TextBlock1.Text = "  IP Address = $IP"
$TextBlock1.FontSize = "19"
$TextBlock1.FontWeight = "Bold"
$TextBlock1.HorizontalAlignment = "Left" 
 
$TextBlock2 = New-Object System.Windows.Controls.TextBlock
$TextBlock2.Text = "  Ivanti Green Version = $EMCONFIG"
$TextBlock2.FontSize = "18"
$TextBlock2.HorizontalAlignment = "Left" 

$TextBlock3 = New-Object System.Windows.Controls.TextBlock
$TextBlock3.Text = "  Ivanti Red Version = $AMCONFIG"
$TextBlock3.FontSize = "18"
$TextBlock3.HorizontalAlignment = "Left" 

$TextBlock4 = New-Object System.Windows.Controls.TextBlock
$TextBlock4.Text = "  AD Location = $OU1"
$TextBlock4.FontSize = "18"
$TextBlock4.HorizontalAlignment = "Left" 

$TextBlock5 = New-Object System.Windows.Controls.TextBlock
$TextBlock5.Text = "  Logged In User = $LOGGEDINUSER"
$TextBlock5.FontSize = "18"
$TextBlock5.HorizontalAlignment = "Left" 

$TextBlock6 = New-Object System.Windows.Controls.TextBlock
$TextBlock6.Text = " "
$TextBlock6.FontSize = "18"
$TextBlock6.HorizontalAlignment = "Left" 

$TextBlock7 = New-Object System.Windows.Controls.TextBlock
$TextBlock7.Text = "  Bennett Jones Build Version =  $BUILDVER"
$TextBlock7.FontSize = "18"
#$TextBlock7.FontStyle = "Italic"
$TextBlock7.HorizontalAlignment = "Left" 

$TextBlock8 = New-Object System.Windows.Controls.TextBlock
$TextBlock8.Text = "  Patch Release Date ($UBR) =  $DatePatched"
$TextBlock8.FontSize = "18"
$TextBlock8.HorizontalAlignment = "Left" 

$TextBlock9 = New-Object System.Windows.Controls.TextBlock
$TextBlock9.Text = "  MAC Address =  $MACADDRESS"
$TextBlock9.FontSize = "18"
$TextBlock9.HorizontalAlignment = "Left" 

$TextBlock10 = New-Object System.Windows.Controls.TextBlock
$TextBlock10.Text = " "
$TextBlock10.FontSize = "18"
$TextBlock10.HorizontalAlignment = "Left" 

$TextBlock11 = New-Object System.Windows.Controls.TextBlock
$TextBlock11.Text = "  Last Boot time = $LastBootUpTime"
$TextBlock11.FontSize = "18"
$TextBlock11.HorizontalAlignment = "Left" 

$TextBlock12 = New-Object System.Windows.Controls.TextBlock
$TextBlock12.Text = " "
$TextBlock12.FontSize = "18"
$TextBlock12.HorizontalAlignment = "Left" 

$TextBlock13 = New-Object System.Windows.Controls.TextBlock
$TextBlock13.Text = "  Windows Release Version = $WINVER"
$TextBlock13.FontSize = "18"
#$TextBlock13.FontStyle = "Italic"

$TextBlock13.HorizontalAlignment = "Left"

$TextBlock14 = New-Object System.Windows.Controls.TextBlock
$TextBlock14.Text = "  Direct Access = Connected"
$TextBlock14.FontSize = "19"
$TextBlock14.FontWeight = "Bold"
$TextBlock14.HorizontalAlignment = "Left" 

$TextBlock15 = New-Object System.Windows.Controls.TextBlock
$TextBlock15.Text = "  VPN = Connected"
$TextBlock15.FontSize = "19"
$TextBlock15.FontWeight = "Bold"
$TextBlock15.HorizontalAlignment = "Left" 

$TextBlock16 = New-Object System.Windows.Controls.TextBlock
$TextBlock16.Text = "  Bennett Jones Version: $BJBUILDVER NOT EQUAL to Microsoft Version: $WINVER!!!!"
$TextBlock16.FontSize = "19"
$TextBlock16.FontWeight = "Bold"
$TextBlock16.HorizontalAlignment = "Left" 

$TextBlock17 = New-Object System.Windows.Controls.TextBlock
$TextBlock17.Text = "  SCCM Client: $SCCMCLIENT NOT EQUAL to Production: $SCCMCLIENT_PROD"
$TextBlock17.FontSize = "19"
$TextBlock17.FontWeight = "Bold"
$TextBlock17.HorizontalAlignment = "Left" 

$TextBlock18 = New-Object System.Windows.Controls.TextBlock
$TextBlock18.Text = "  Bennett Jones Build Type = $BUILDTYPE"
$TextBlock18.FontSize = "18"
$TextBlock18.HorizontalAlignment = "Left" 

$Source = "c:\windows\bjsystems\powershell\BJ2.jpg"
$Image = New-Object System.Windows.Controls.Image
$Image.Source = $Source
#$Image.Height = [System.Drawing.Image]::FromFile($Source).Height / 1
#$Image.Width = [System.Drawing.Image]::FromFile($Source).Width / 1
$Image.HorizontalAlignment = "Center"  
$Image.Height = 120
$Image.Width = 180
$Image.Margin = -30
 
$StackPanel = New-Object System.Windows.Controls.StackPanel
$StackPanel.AddChild($Image)
$StackPanel.AddChild($TextBlock12)
$StackPanel.AddChild($TextBlock)
$StackPanel.AddChild($TextBlock1)
IF ($DA -eq '1')
{$StackPanel.AddChild($TextBlock14)}
IF ($VPN -eq '$true')
{$StackPanel.AddChild($TextBlock15)}
$StackPanel.AddChild($TextBlock9) 
$StackPanel.AddChild($TextBlock4)
$StackPanel.AddChild($TextBlock5)
$StackPanel.AddChild($TextBlock11)
IF ($SCCMCLIENT -lt $SCCMCLIENT_PROD)
{$StackPanel.AddChild($TextBlock17)}
$StackPanel.AddChild($TextBlock6)
$StackPanel.AddChild($TextBlock2)
$StackPanel.AddChild($TextBlock3)
$StackPanel.AddChild($TextBlock10)
$StackPanel.AddChild($TextBlock18)
$StackPanel.AddChild($TextBlock7)
$StackPanel.AddChild($TextBlock13)
IF ($BJBUILDVER -ne $WINVER)
{$StackPanel.AddChild($TextBlock16)}

$StackPanel.AddChild($TextBlock8) 
  
## minimize all active windows
(New-Object -ComObject Shell.application).MinimizeAll()

## launch Messagebox
New-WPFMessageBox -Content $StackPanel -TitleFontSize '24' -Title "Computer Information (1.139) - Windows $BUILDVER" -TitleBackground SeaGreen -TitleTextForeground Black -ContentBackground White -TitleFontWeight Bold #-CornerRadius 160 -ShadowDepth 15 -BlurRadius 15 -BorderThickness 1 

$BJBUILDVER = $BUILDVER.split(".")[1]
