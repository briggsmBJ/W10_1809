## Hide Progress Bars
$progressPreference = 'silentlyContinue'

## Execute Tests
$a = Invoke-Pester -script .\POST_OSD.tests.ps1 -PassThru -Quiet

## Count failures
if ($a.FailedCount -ne "0")
{
  Write-Host "--------------------------" -ForegroundColor Yellow ;
  Write-Host "There were failed tests:  " -ForegroundColor Cyan ;
  Write-Host "--------------------------" -ForegroundColor Yellow ;
  Write-host '';

  ## Give the name of the failure
  ($a.TestResult | Where-Object {$_.passed -ne $true}).name
  Write-host '';
  Write-Host "-----" -ForegroundColor Yellow ;
  Write-Host " End" -ForegroundColor Cyan ;
  Write-Host "-----" -ForegroundColor Yellow ;
}

## Reset Progress Bars
$progressPreference = 'Continue'
