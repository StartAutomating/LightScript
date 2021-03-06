#requires -Module Splatter
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Push-Location $myRoot


$excludeFromGet = 'Schedule', 'Sensor', 'Rule', 'Scene', 'Group', 'Configuration', 'Capability', 'Resource', 'Light', 'Detailed'
foreach ($api in 'Sensors', 'Rules', 'Schedules', 'Groups', 'Scenes', 'ResourceLinks')
{
    $cmdletNoun = "Hue$($api.TrimEnd('s'))"
    if ($api -eq 'Groups') {
        $cmdletNoun = "HueRoom"
    }
    if ($api -eq 'ResourceLinks') {
        $cmdletNoun = 'HueResource'
    }

    $SplatBase = @{
        CommandName = "Get-HueBridge"
        DefaultParameter = @{$api = $true }
        InputParameter = 'Name', 'ExactMatch', 'RegularExpression','ID', 'Detailed'
    }

    #region Get-$CmdletNoun
    $OutSplat = $SplatBase + @{
        Synopsis = "Gets Hue $api"
        Description = "Gets $api from one or more Hue Bridges"
        FunctionName = "Get-$cmdletNoun"
        Example = "Get-$cmdletNoun"
        Link = "Remove-$cmdletNoun", "Get-HueBridge", "Send-HueBridge"
    }

    Out-Splat @OutSplat  | Set-Content ".\$($OutSplat.FunctionName).ps1"
    #endregion Get-$CmdletNoun

    #region Remove-$CmdletNoun
    $OutSplat = $SplatBase + @{
        FunctionName = "Remove-$cmdletNoun"
        Where = [ScriptBlock]::Create('$PSCmdlet.ShouldProcess("Delete ' + $api.TrimEnd('s') + '$($_.Name) ($($_.ID))")')
        PipeTo = [ScriptBlock]::Create('Send-HueBridge -Method DELETE -Command {"' + $api.ToLower() + '/$($_.ID)"}')
        CmdletBinding = 'SupportsShouldProcess=$true,ConfirmImpact="High"'
        Synopsis = "Removes Hue $api"
        Description = "Removes $api from one or more Hue Bridges"
        Example = "Remove-$cmdletNoun -Name '${cmdletNoun}Name'"
        Link = "Get-$cmdletNoun", "Get-HueBridge", "Send-HueBridge"
        ExcludeParameter = $excludeFromGet
    }

    Out-Splat @OutSplat | Set-Content ".\$($OutSplat.FunctionName).ps1"
    #endregion Remove-$CmdletNoun
}

Out-Splat -CommandName Get-HueBridge -FunctionName Read-HueSensor -DefaultParameter @{
    Sensor=$true
}  -InputParameter Name, ExactMatch, RegularExpression,ID -ExcludeParameter $excludeFromGet -Synopsis "Reads Hue Sensors"  -Description "Reads Sensors values from the Hue Bridge" -AdditionalParameter @{
    Config = @'
# If set, will read values from the configuration.  By default, values are read from the sensor state.
[switch]
'@
} -Example 'Read-HueSensor -Name Daylight' -Link 'Write-HueSensor', 'Get-HueSensor', 'Get-HueBridge','Add-HueSensor', 'Remove-HueSensor'  -Process {
        $sensor = $_
        $outObj =
            if ($Config) {
                $sensor.config.pstypenames.clear()
                $sensor.config.pstypenames.add("Hue.Sensor.Config.$($sensor.Type)")
                $sensor.config
            } else {

                $sensor.state.pstypenames.clear()
                $sensor.state.pstypenames.add("Hue.Sensor.State.$($sensor.Type)")
                $sensor.State
            }

        $outObj |
            Add-Member NoteProperty Name $sensor.Name -PassThru -Force |
            Add-Member NoteProperty UniqueID $sensor.UniqueID -PassThru -Force
} |
    Set-Content .\Read-HueSensor.ps1

Out-Splat -CommandName Get-HueBridge -FunctionName Write-HueSensor -DefaultParameter @{
    Sensor=$true
}  -InputParameter Name, ExactMatch, RegularExpression,ID -ExcludeParameter $excludeFromGet -Synopsis "Write Hue Sensors"  -Description "Writes data to sensors on the Hue Bridge" -AdditionalParameter @{
    Config = @'
# If set, will write values from to configuration.  By default, values are written to the sensor state.
[switch]
'@
    Data = @'
# The data that will be written to the sensor
[Parameter(Mandatory,ValueFromPipeline)]
[PSObject]
'@
    OutputInput = @'
# If set, will output the data that would be sent to the bridge.  This is useful for creating scheudles, routines, and other macros.
[Parameter(ValueFromPipelineByPropertyName)]
[switch]
'@
} -Example 'Write-HueSensor -Name ChaseStatus1 -Data @{status=0}' -Link 'Read-HueSensor', 'Get-HueSensor', 'Get-HueBridge','Add-HueSensor', 'Remove-HueSensor' -Process {
        $sensor = $_
        if ($Config) {
            $sensor | Send-HueBridge -Command "sensors/$($sensor.Id)/config" -Data $Data -Method PUT
        } else {
            $sensor | Send-HueBridge -Command "sensors/$($sensor.Id)/state" -Data $Data -Method PUT
        }
}  |
    Set-Content .\Write-HueSensor.ps1

Pop-Location