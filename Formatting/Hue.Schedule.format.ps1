Write-FormatView -TypeName 'Hue.Schedule' -Property ID, Name, Status, Time, Command -VirtualProperty @{
    Command = {
        $_.Command.Body | ConvertTo-Json
    }
} -Wrap -Width 4, 40, 15, 20 -ColorProperty @{Status={
    if ($_.Status -eq 'Enabled') {
        '#00ff00'
    } else {
        '#ff0000'
    }
}} 

Write-FormatView -TypeName 'Hue.Schedule' -Action {
    $schedule = $_
    if ($request -and $response) {
New-Object PSObject -Property ([Ordered]@{
    Name = $schedule.Name
    ID = $schedule.ID
    Created = ($schedule.Created -as [DateTime])
    Schedule = $schedule.Time
}) | Out-HTML
"<pre>$($schedule.Command | ConvertTo-Json)</pre>"
    } else {
        $NameLength = $Schedule.Name.Length + 2
        $TimeLength = $Schedule.LocalTime.Length + 2

        $nameLeft = [Math]::Floor(($NameLength - 4) /2)
        if ($NameLength %2) {
            $nameRight = $nameLeft + 1
        } else {
            $nameRight = $nameLeft
        }        
        
        $maxConditionLength = 0 
        $MaxActionLength = 0 

        $wholeLength = $NameLength + 4 + 10 + 20 + $TimeLength + 4
        $extraLength = 0
        $commandLines = ($schedule.Command | ConvertTo-Json).ToString() -split [Environment]::NewLine
        foreach ($_ in $commandLines) {
            if ($_.Length -gt $wholeLength) {
                $extraLength += ($_.Length - $wholeLength)
                $wholeLength = $_.Length
            }
        }

        $timeAreaLength = $TimeLength + $extraLength
        $timeLeft = [Math]::Floor(($timeAreaLength - 6)/2)
        $timeRight  = if ($timeAreaLength %2) {
            $timeLeft + 1 
        } else {
            $timeLeft
        }

        $timeValueLeft = [Math]::Floor(($timeAreaLength - $schedule.LocalTime.Length)/2)
        $timeValueRight = if ($TimeLength % 2) {
            $timeValueLeft + 1
        } else {
            $timeValueLeft
        }

        $timeOccupiedLength = ($timeValueLeft + $Schedule.LocalTime.Length + $timeValueRight)
        if ($timeOccupiedLength -lt $timeAreaLength) {
            $timeValueRight += $timeAreaLength - $timeOccupiedLength
        }

        

        Write-Host "+$('-' * $NameLength)+$('-' * 4)+$('-' * 10)+$('-' * 20)+$('-'*$TimeLength)$('-' * $extraLength)+" -ForegroundColor Cyan

        #region Table Header
        Write-Host "|" -NoNewline -ForegroundColor Cyan
        Write-Host "$(' ' * $nameLeft)Name$(' ' * $nameRight)" -NoNewline -ForegroundColor Green
        Write-Host "|" -NoNewline -ForegroundColor Cyan
        Write-Host " ID " -NoNewline -ForegroundColor Green
        Write-Host "|" -NoNewline -ForegroundColor Cyan
        Write-Host " Status   " -NoNewline -ForegroundColor Green
        Write-Host "|" -NoNewline -ForegroundColor Cyan
        Write-Host "      Created       " -NoNewline -ForegroundColor Green
        Write-Host "|" -NoNewline -ForegroundColor Cyan
        Write-Host "$(' ' * $timeLeft)@ Time$(' ' * $timeRight)" -ForegroundColor Green -NoNewline        
        Write-Host "|" -ForegroundColor Cyan
        #endregion Table Header
        Write-Host "+$('-' * $NameLength)+$('-' * 4)+$('-' * 10)+$('-' * 20)+$('-'*$TimeLength)$('-' * $extraLength)+" -ForegroundColor Cyan

        #region Table Values
        Write-Host "|" -NoNewline -ForegroundColor Cyan
        Write-Host " $($Schedule.Name) " -NoNewline -ForegroundColor Green
        Write-Host "|" -NoNewline -ForegroundColor Cyan
        Write-Host " $($Schedule.ID.ToString().PadRight(2)) " -NoNewline -ForegroundColor Green
        Write-Host "|" -NoNewline -ForegroundColor Cyan
        Write-Host " $($Schedule.Status.PadRight(8, ' ')) " -NoNewline -ForegroundColor $(if ($Schedule.status -eq 'disabled') {'Red' } else { 'Green' })
        Write-Host "|" -NoNewline -ForegroundColor Cyan
        Write-Host "$(($Schedule.Created -as [DateTime]).ToString('s')) " -NoNewline -ForegroundColor Green
        Write-Host "|" -NoNewline -ForegroundColor Cyan
        Write-Host "$(' ' * $timeValueLeft)$($Schedule.localtime)$(' ' * $timeValueRight)" -ForegroundColor Green -NoNewline        
        Write-Host "|" -ForegroundColor Cyan

        #endregion Table Values
        Write-Host "+$('-' * $NameLength)+$('-' * 4)+$('-' * 10)+$('-' * 20)+$('-'*$TimeLength)$('-' * $extraLength)+" -ForegroundColor Cyan

        Write-Host '|' -NoNewline -ForegroundColor Cyan
        Write-Host " Command$(' ' * ($wholeLength - 'Command'.Length - 1))" -ForegroundColor Green -NoNewline 
        Write-Host '|' -ForegroundColor Cyan
        Write-Host "+$('-' * $wholelength)+" -ForegroundColor Cyan
        foreach ($_ in $commandLines) {    
            Write-Host '|' -NoNewline -ForegroundColor Cyan 
            Write-Host $_.PadRight($wholeLength, ' ') -foregroundColor Green -nonewline 
            Write-host '|' -ForegroundColor Cyan
        }
        

        Write-Host "+$('-' * $wholelength)+" -ForegroundColor Cyan
    }
}