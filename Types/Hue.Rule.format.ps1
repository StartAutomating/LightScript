Write-FormatView -TypeName Hue.Rule -Action {
    $rule = $_
    if ($request -and $response) {
        
    } else {
        $NameLength = $rule.Name.Length + 2
        $nameLeft = [Math]::Floor(($NameLength - 4) /2)
        if ($NameLength %2) {
            $nameRight = $nameLeft + 1
        } else {
            $nameRight = $nameLeft
        }
        $maxConditionLength = 0 
        $MaxActionLength = 0 

        $wholeLength = $NameLength + 4 + 10 + 20 + 20 + 4
        $extraLength = 0 

        $conditionLines = ($rule.Conditions | ConvertTo-Json).ToString() -split ([Environment]::NewLine)
        $actionLines = ($rule.Actions | ConvertTo-Json).ToString() -split ([Environment]::NewLine)
        foreach ($_ in $conditionLines + $actionLines) {
            if ($_.Length -gt $wholeLength) {
                $extraLength+=($_.Length - $wholeLength)
                $wholeLength = $_.Length
            }
        }

        Write-Host @"

+$('-' * $NameLength)+$('-' * 4)+$('-' * 10)+$('-' * 20)+$('-'*20)$('-' * $extraLength)+
|$(' ' * $nameLeft)Name$(' ' * $nameRight)| ID |  Status  |      Created       |     Last Triggered$(' ' * $extraLength) |
+$('-' * $NameLength)+$('-' * 4)+$('-' * 10)+$('-' * 20)+$('-'*20)$('-' * $extraLength)+
| $($rule.Name) | $($rule.ID.ToString().PadRight(3))| $($rule.Status.PadRight(8, ' ')) |$($rule.Created -as [DateTime]) |$($rule.LastTriggered -as [DateTime]) $('-' * $extraLength)|
+$('-' * $NameLength)+$('-' * 4)+$('-' * 10)+$('-' * 20)+$('-'*20)$('-' * $extraLength)+
| Conditions$(' ' * ($wholeLength - 'Conditions'.Length -1 ))|
+$('-' * $wholelength)+
$(@(foreach ($_ in $conditionLines) {        
        '|' + $_.PadRight($wholeLength, ' ') + '|'
}) -join ([Environment]::NewLine))
+$('-' * $wholelength)+
| Actions$(' ' * ($wholeLength - 'Actions'.Length -1 ))|
+$('-' * $wholelength)+
$(@(foreach ($_ in $actionLines) {        
        '|' + $_.PadRight($wholeLength, ' ') + '|'
}) -join ([Environment]::NewLine))
+$('-' * $wholelength)+

"@

    }
}
