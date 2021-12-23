Write-FormatView -TypeName Hue.Sensor -Property ID, Name, ModelID, Config, State -Wrap -Width 4, 20, 10, 40 -VirtualProperty @{
    Config = { ($_.Config | Out-String -Width 40).Trim()} 
    State  = { ($_.State | Out-String -Width 40).Trim()}
} -GroupByProperty Manufacturer

Write-FormatView -TypeName Hue.Sensor -Action {
    $sensor = $_ 
    $mfgName = try { 
        $null =[Convert]::FromBase64String($sensor.ManufacturerName) 
    } catch {
        $sensor.ManufacturerName
    }
    $sensorNameString = $mfgName, $sensor.ModelId, $sensor.Name, "[ID: $($sensor.ID)]" -ne $null -join ' ' 
    @($sensorNameString
    ""
    $sensorState = ($sensor.State | Out-String).Trim()
    $sensorConfig = if ($sensor.config) { ($sensor.Config | Out-String).Trim() } 
    "State:"
    $sensorState = $sensorState -replace "($([Environment]::NewLine)|`n)", '$1    '
    $sensorState
    
    if ($sensorConfig) {
        "Config:"
        $($sensorConfig -replace "($([Environment]::NewLine)|`n)", '$1    ')        
    }) -join [Environment]::NewLine
    
}
