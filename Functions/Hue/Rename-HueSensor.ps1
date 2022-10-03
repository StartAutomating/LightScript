function Rename-HueSensor
{
    <#
    .Synopsis
        Renames Hue Sensors
    .Description
        Renames one or more Hue Sensors.
    .Example
        Rename-HueSensor
    .Link
        Get-HueBridge
    .Link
        Get-HueSensor
    #>
    [OutputType([PSObject])]
    param(
    # The old name of the Sensor.  This can be a wildcard or regular expression.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [Alias('ID')]
    [string]
    $OldName,

    # The new name of the Sensor.  A number sign will be replaced with the match number.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [string]
    $NewName
    )

    begin {
        $Sensors = Get-HueSensor
        $bridges = Get-HueBridge
    }

    process {
        $Sensors |
            Where-Object {
                #region Find matching Sensors
                ($_.Id -eq $oldName) -or
                ($_.Name -like $OldName) -or 
                ($oldName -as [regex] -and $_.Name -match $oldName)                
                #endregion Find matching Sensors
            } |
            ForEach-Object -Begin {
                $matchCount = 0
            } -Process {
                #region Rename the Sensors
                $MatchCount++
                $realNewName = $NewName -replace '#', $MatchCount
                $SensorToRename = $_
                $bridges | Send-HueBridge -Command "sensors/$($SensorToRename.id)" -Method PUT -Data @{name=$realNewName}
                #endregion Rename the Sensors
            }
    }
}

