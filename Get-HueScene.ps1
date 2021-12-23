function Get-HueScene
{
    <#
    .Synopsis
        Gets Hue Scenes
    .Description
        Gets Scenes from one or more Hue Bridges
    .Example
        Get-HueScene
    .Link
        Remove-HueScene
    .Link
        Get-HueBridge
    .Link
        Send-HueBridge
    #>
    [CmdletBinding(DefaultParameterSetName='ConnectionInfo')]
    [OutputType([PSObject])]
    param(
    #If set, will get the schedules defined on the Hue bridge
    [Parameter(ParameterSetName='Schedules', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('Schedules','Timer','Timers')]
    [switch]
    $Schedule,

    #If set, will get the rules defined on the Hue bridge
    [Parameter(ParameterSetName='Rules', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('Rules','Trigger','Triggers')]
    [switch]
    $Rule,

    #If set, will get the scenes defined on the Hue bridge
    [Parameter(ParameterSetName='Scenes', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('Scenes')]
    [switch]
    $Scene,

    #If set, will get the sensors defined on the Hue bridge
    [Parameter(ParameterSetName='Sensors', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('Sensors')]
    [switch]
    $Sensor,

    #If set, will get the groups (or rooms) defined on the Hue bridge
    [Parameter(ParameterSetName='Groups', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('Groups','Room','Rooms')]
    [switch]
    $Group,

    #If set, will get the device configuration
    [Parameter(ParameterSetName='Config', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [switch]
    $Configuration,

    #If set, will get the device capabilities
    [Parameter(ParameterSetName='Capabilities', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('Capabilities')]
    [switch]
    $Capability,

    #If set, will get resources defined on the device
    [Parameter(ParameterSetName='Resourcelinks', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('Resources','ResourceLink','ResourceLinks')]
    [switch]
    $Resource,

    #If set, will get the lights defined on the device
    [Parameter(ParameterSetName='Lights', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('Lights')]
    [switch]
    $Light,

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

    #If set, will requery each returned resource to retreive additional information.
    [switch]
    $Detailed
    )

    process {
        $GetHueBridgeParametersDefault = ConvertFrom-Json @'
        {
            "Scenes":  true
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
        foreach ($in in 'Name','ExactMatch','RegularExpression','ID','Detailed') {
            if (-not $GetHueBridgeParameters.$in -and $myParameters.$in) {
                $GetHueBridgeParameters.$in = $myParameters.$in
            }
        }
        #endregion Copy Parameters from Get-HueBridge

        Get-HueBridge @GetHueBridgeParameters
    }
}

