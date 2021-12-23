function Read-HueSensor
{
    <#
    .Synopsis
        Reads Hue Sensors
    .Description
        Reads Sensors values from the Hue Bridge
    .Example
        Read-HueSensor -Name Daylight
    .Link
        Write-HueSensor
    .Link
        Get-HueSensor
    .Link
        Get-HueBridge
    .Link
        Add-HueSensor
    .Link
        Remove-HueSensor
    #>
    [CmdletBinding(DefaultParameterSetName='ConnectionInfo')]
    [OutputType([PSObject])]
    param(
    #If provided, will filter returned items by name
    [Parameter(Position=0, ValueFromPipelineByPropertyName=$true)]
    [string[]]
    $Name,

    #If set, will treat the Name parameter as a regular expression pattern.  By default, Name will be treated as a wildcard
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    $RegularExpression,

    #If set, will treat the Name parameter as a specific match
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [switch]
    $ExactMatch,

    #If provided, will filter returned items by ID
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string[]]
    $ID,

    # If set, will read values from the configuration.  By default, values are read from the sensor state.
    [switch]
    $Config
    )

    process {
        $GetHueBridgeParametersDefault = ConvertFrom-Json @'
        {
            "Sensor":  true
        }
'@
        $GetHueBridgeParameters = @{}
        foreach ($property in $GetHueBridgeParametersDefault.psobject.properties) {
            $GetHueBridgeParameters[$property.Name] = $property.Value
            if ($property.Value -is [string] -and $property.Value.StartsWith('$')) {
                $GetHueBridgeParameters[$property.Name] = $executionContext.SessionState.PSVariable.Get($property.Value.Substring(1)).Value
            }
        }
        #region Copy Parameters from Get-HueBridge
        $MyParameters = [Ordered]@{} + $psBoundParameters # Copy $PSBoundParameters
        foreach ($in in 'Name','ExactMatch','RegularExpression','ID') {
            if (-not $GetHueBridgeParameters.$in -and $myParameters.$in) {
                $GetHueBridgeParameters.$in = $myParameters.$in
            }
        }
        #endregion Copy Parameters from Get-HueBridge

        Get-HueBridge @GetHueBridgeParameters |
            Foreach-Object -Process {

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

            }
    }
}

