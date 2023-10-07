$MonthNow = 8
$YearNow = 2023

$AllUpdate = Get-HotFix

$updateByMonth = $AllUpdate | Where-Object { $_.InstalledOn.Month -eq $MonthNow -and $_.InstalledOn.Year -eq $YearNow }
$downloadedUpdates = Get-WindowsUpdateLog | Where-Object { $_.Message -match "Downloaded update" -and $_.Message -notmatch "Install Update" }


$selectedUpdateByMonth = $updateByMonth | Select-Object Description, HotFixID, InstalledBy, InstalledOn
$selectedDownloadedKBs = $downloadedUpdates | ForEach-Object { $_.Message -match "KB\d+" | Out-Null; $matches[0] } | Select-Object Description, HotFixID, InstalledBy, InstalledOn


$selectedDownloadedKBs
$selectedUpdateByMonth


$selectedDownloadedKBs | Export-Csv -Path "C:\Users\cesar\Music\kbsBaixados.txt" -NoTypeInformation
$selectedUpdateByMonth | Export-Csv -Path "C:\Users\cesar\Music\KBSinstalados.txt" -NoTypeInformation
