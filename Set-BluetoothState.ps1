Add-Type -AssemblyName System.Runtime.WindowsRuntime
$TaskGeneric = ([System.WindowsRuntimeSystemExtensions].GetMethods() | ? { $_.Name -eq 'asTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1' })[0]
Function wait($WinRtTask, $ResultType) {
    $Task = $TaskGeneric.MakeGenericMethod($ResultType)
    $netTask = $Task.Invoke($null, @($WinRtTask))
    $netTask.Wait(-1) | Out-Null
    $netTask.Result
}
[Windows.Devices.Radios.Radio,Windows.System.Devices,ContentType=WindowsRuntime] | Out-Null
[Windows.Devices.Radios.RadioAccessStatus,Windows.System.Devices,ContentType=WindowsRuntime] | Out-Null
wait ([Windows.Devices.Radios.Radio]::RequestAccessAsync()) ([Windows.Devices.Radios.RadioAccessStatus]) | Out-Null
$radios = wait ([Windows.Devices.Radios.Radio]::GetRadiosAsync()) ([System.Collections.Generic.IReadOnlyList[Windows.Devices.Radios.Radio]])
start-sleep 4
$Wifi = $radios | ? { $_.Kind -eq 'Bluetooth' } | % {$_.SetStateAsync("On")}
Start-Sleep 2
$Wifi = $radios | ? { $_.Kind -eq 'Bluetooth' } | % {$_.SetStateAsync("Off")}
