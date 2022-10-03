function Add-HueSensor
{
    <#
    .Synopsis
        Adds a sensor to a Hue Bridge.
    .Description
        Adds sensors to a Hue Bridge.
        Sensors can be physical sensors, such as a motion detector, or virtual sensors, such as GenericFlag.
    .Link
        Get-HueSensor
    .Example
        Add-HueSensor -Name "ChaseStatus1" -SensorType GenericStatus
    #>
    [OutputType([PSObject])]
    [CmdletBinding(SupportsShouldProcess)]
    param(
    # The name of the sensor.
    [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName,ParameterSetName='CustomSensor')]
    [string]
    $Name,

    <#

    The sensor type.

    Sensors can be:

        * Switches
        * OpenClose
        * Presence (motion detectors)
        * Temperature
        * Humidity
        * LightLevel
        * GenericFlag (used for virtual sensors)
        * GenericStatus (used for virtual sensors)
    #>
    [Parameter(Mandatory,Position=1,ValueFromPipelineByPropertyName,ParameterSetName='CustomSensor')]
    [ValidateSet('Switch','OpenClose','Presence','Temperature','Humidity','LightLevel', 'GenericFlag', 'GenericStatus')]
    [string]
    $SensorType,

    # The sensor ModelID
    [Parameter(Position=2,ValueFromPipelineByPropertyName,ParameterSetName='CustomSensor')]
    [string]
    $ModelID = "ABCD-12345",

    # The sensor manufacturer
    [Parameter(Position=2,ValueFromPipelineByPropertyName,ParameterSetName='CustomSensor')]
    [string]
    $Manufacturer = "ACME LTD",

    # The sensor unique ID.
    [Parameter(Position=3,ValueFromPipelineByPropertyName,ParameterSetName='CustomSensor')]
    [string]
    $UniqueID= [guid]::NewGuid().tostring('n'),

    # The sensor version.
    [Parameter(Position=4,ValueFromPipelineByPropertyName,ParameterSetName='CustomSensor')]
    [Version]
    $Version = '0.1',

    # If set, will search for new sensors to add.
    [Parameter(Mandatory,ParameterSetName='NewSensor')]
    [Alias('Find','Discover')]
    [switch]
    $New
    )

    begin {
        $myCmd = $MyInvocation.MyCommand
    }

    process {
        #region Prepare REST Input        
        $sensorRest = 
            if ($PSCmdlet.ParameterSetName -eq 'CustomSensor') {
                if ($SensorType) {
                    $sensorType =
                        foreach ($_ in $myCmd.Parameters['SensorType'].Attributes) {
                            if (-not $_.ValidValues) { continue }
                            $_.ValidValues -eq $SensorType
                            break
                        }
                }
    
                @{
                    name = $Name
                    modelid = $ModelID
                    swversion = "$Version"
                    type = 'CLIP' + $SensorType
                    uniqueid = $UniqueID
                    manufacturername = $Manufacturer
                    recycle = $false
                }
            } elseif ($New) {
                $name = "new"                
            }       
        #endregion Prepare REST Input


        if ($WhatIfPreference) {
            return $sensorRest
        }

        if ($PSCmdlet.ShouldProcess("Add-HueSensor $name")) {
            Get-HueBridge |
                Send-HueBridge -Method POST -Data $sensorRest -Command "sensors"
        }
    }
}
