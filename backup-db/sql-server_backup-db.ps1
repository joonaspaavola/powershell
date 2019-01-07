# Provide SQL server details, destination folder and name of the db to backup
$serverName = "localhost"
$backupDirectory = Read-Host -Prompt 'Provide destination folder'
$dbName = Read-Host -Prompt 'Provide database name'

[System.Reflection.Assembly]::LoadWithPartialName(“Microsoft.SqlServer.SMO”) | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName(“Microsoft.SqlServer.SmoExtended”) | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName(“Microsoft.SqlServer.ConnectionInfo”) | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName(“Microsoft.SqlServer.SmoEnum”) | Out-Null

$server = New-Object (“Microsoft.SqlServer.Management.Smo.Server”) $serverName
$dbs = $server.Databases
$timestamp = Get-Date -format yyyy-MM-dd-HHmmss
$targetPath = $backupDirectory + “\” + $dbName + “_” + $timestamp + “.bak”
$smoBackup = New-Object (“Microsoft.SqlServer.Management.Smo.Backup”)
$smoBackup.Action = “Database”
$smoBackup.BackupSetDescription = “Full Backup of “ + $dbName
$smoBackup.BackupSetName = $dbName + ” Backup”
$smoBackup.Database = $dbName
$smoBackup.MediaDescription = “Disk”
$smoBackup.Devices.AddDevice($targetPath, “File”)
$smoBackup.SqlBackup($server)

“Backed up $dbName ($serverName) to $targetPath“