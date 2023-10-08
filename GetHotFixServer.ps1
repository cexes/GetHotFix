$YearNow = (Get-Date).Year
$MonthNow = (Get-Date).Month

$AllUpdate = Get-HotFix

$updateByMonth = $AllUpdate | Where-Object { $_.InstalledOn.Month -eq $MonthNow -and $_.InstalledOn.Year -eq $YearNow }
$downloadedUpdates = Get-WindowsUpdateLog | Where-Object { $_.Message -match "Downloaded update" -and $_.Message -notmatch "Install Update" }


$selectedUpdateByMonth = $updateByMonth | Select-Object Description, HotFixID, InstalledBy, InstalledOn
$selectedDownloadedKBs = $downloadedUpdates | ForEach-Object { $_.Message -match "KB\d+" | Out-Null; $matches[0] } | Select-Object Description, HotFixID, InstalledBy, InstalledOn


$selectedDownloadedKBs
$selectedUpdateByMonth


$selectedDownloadedKBs | Export-Csv -Path "C:\" -NoTypeInformation
$selectedUpdateByMonth | Export-Csv -Path "C:\" -NoTypeInformation
