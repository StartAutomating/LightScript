Write-FormatView -Action {
    Write-FormatViewExpression -Property Name
    Write-FormatViewExpression -If { $_.State.On } -ScriptBlock { ' * ' }
} -TypeName Hue.Light -Name Master

Write-FormatView -Action {
    Write-FormatViewExpression -Property Name
    Write-FormatViewExpression -If { $_.State.On } -ScriptBlock {
        $_.State | ConvertTo-Json | Out-String
    }
} -TypeName Hue.Light -Name Detail