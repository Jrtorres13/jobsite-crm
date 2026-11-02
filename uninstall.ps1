# Removes JobSite CRM shortcuts and (optionally) your saved data.
$places = @(
  [Environment]::GetFolderPath('Desktop'),
  (Join-Path ([Environment]::GetFolderPath('StartMenu')) 'Programs'),
  [Environment]::GetFolderPath('Startup')
)
foreach ($dir in $places) { Remove-Item (Join-Path $dir 'JobSite CRM.lnk') -ErrorAction SilentlyContinue }
$dest = Join-Path $env:LOCALAPPDATA 'JobSiteCRM'
$ans = Read-Host 'Also delete your saved jobs, customers and settings? (y/N)'
if ($ans -match '^[yY]') {
  Remove-Item -LiteralPath $dest -Recurse -Force -ErrorAction SilentlyContinue
  if (Test-Path -LiteralPath $dest) { Write-Host 'Close the JobSite CRM window first, then run Uninstall.bat again.' -ForegroundColor Yellow }
  else { Write-Host 'Data deleted.' }
}
Write-Host 'JobSite CRM removed.' -ForegroundColor Green
