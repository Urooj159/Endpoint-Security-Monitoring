$startTime = (Get-Date).AddMinutes(-10)

$failedLogins = Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    Id = 4625
    StartTime = $startTime
} -ErrorAction SilentlyContinue

$count = @($failedLogins).Count

$reportPath = "$env:USERPROFILE\Documents\Endpoint-Security-Monitoring\04-Automated Alerts\Security-Alerts.txt"

if ($count -ge 5) {
    $message = "$(Get-Date): ALERT! $count failed login attempts detected in the last 10 minutes."
    Write-Host $message -ForegroundColor Red
    Add-Content -Path $reportPath -Value $message
}
else {
    $message = "$(Get-Date): Normal activity. $count failed login attempts in the last 10 minutes."
    Write-Host $message -ForegroundColor Green
    Add-Content -Path $reportPath -Value $message
}