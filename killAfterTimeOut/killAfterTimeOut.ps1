$badJobbie = Get-Process | Where-Object { $_.Name -eq "badJob" -and ((Get-Date) - $_.starttime).TotalMinutes -gt 150 } 

if ($badJobbie -ne $null) {
  $archiveDir = "\\fs\archive\"
  $killedDir = "\\fs\archive\killed\"
  $upTime = ((Get-Date) - (Get-Date (Get-Process -Name "badJob").StartTime)).TotalMinutes
  $logFileName = (Get-ChildItem -Path C:\app\* -Include *.log -Name)
  $logFile = $archiveDir + $logFileName
  $logMsg = "`r`n`r`n`r`n$(""=""*140)`r`nError:$(Get-Date) : jobbie $($badJobbie) was terminated after being up for $upTime minutes"

  Stop-Process -Force -Name "EursAE"
  Start-Sleep -s 30

  $logMsg | Out-File $logFile -encoding ASCII -Append
  move $logFile $killedDir
}
