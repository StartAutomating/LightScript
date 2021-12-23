function Write-HueSensor
{
    <#
    .Synopsis
        Write Hue Sensors
    .Description
        Writes data to sensors on the Hue Bridge
    .Example
        Write-HueSensor -Name ChaseStatus1 -Data @{status=0}
    .Link
        Read-HueSensor
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

    # If set, will write values from to configuration.  By default, values are written to the sensor state.
    [switch]
    $Config,

    # The data that will be written to the sensor
    [Parameter(Mandatory,ValueFromPipeline)]
    [PSObject]
    $Data,

    # If set, will output the data that would be sent to the bridge.  This is useful for creating scheudles, routines, and other macros.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $OutputInput
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
                if ($Config) {
                    $sensor | Send-HueBridge -Command "sensors/$($sensor.Id)/config" -Data $Data -Method PUT
                } else {
                    $sensor | Send-HueBridge -Command "sensors/$($sensor.Id)/state" -Data $Data -Method PUT
                }

            }
    }
}

