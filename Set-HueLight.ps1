function Set-HueLight
{
    <#
    .Synopsis
        Sets Hue light state
    .Description
        Changes the state of one or more Hue lights
    .Example
        Set-HueLight -Name *Lightstrip* -Luminance 0.05 # Set any Hue lights named Hue lightstrip to be very dim
    .Example
        LivingRoom -On -ColorTemperature 500 -Brightness .1
        # Room names and light names are automatically aliased to Set-HueLight.
        # This gives all lights in the living room a warm glow.
    .Link
        Get-HueLight
    #>
    [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='Low',DefaultParameterSetName='All')]
    [OutputType([PSObject])]
    param(
    # The name of the Hue light
    [Parameter(Mandatory=$true,Position=0,ParameterSetName='Lights',ValueFromPipelineByPropertyName)]
    [Alias('LightName')]
    [string[]]
    $Name,

    # The name of the Hue room
    [Parameter(Mandatory=$true,Position=0,ParameterSetName='Rooms')]
    [Alias('Group', 'GroupName','Room')]
    [string[]]
    $RoomName,

    # The identifier of the Hue light
    [Parameter(Mandatory=$true,Position=0,ParameterSetName='LightID',ValueFromPipelineByPropertyName)]
    [string]
    $LightID,

    # The identifier of the Hue group
    [Parameter(Mandatory=$true,Position=0,ParameterSetName='GroupID')]
    [string]
    $GroupID,

    # The transition time.  This is how long it will take light to change from it's current state to the one you've set
    [Parameter(Position=1,ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty('transitiontime')]
    [ComponentModel.AmbientValue({  [int][Math]::Floor(($_.TotalMilliseconds / 100))})]
    [Timespan]
    $TransitionTime,

    # If set, will switch the light on
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty('on')]
    [switch]$On,

    # If set, will switch the light off
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.AmbientValue({@{on = $false}})]
    [switch]$Off,


    # Sets lights to an RGB color
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.AmbientValue({
        $fromRgb = ([PSCustomObject]@{PSTypeName='LightScript.Color'}).FromRGB($_)
        @{
            hue=[uint16][Math]::Floor(($fromRgb.Hue / 360) * [Uint16]::maxValue)
            sat=[byte][Math]::min([Math]::Max($(255 * $fromRgb.Saturation), 1), 254)
            bri=[byte][Math]::min([Math]::Max($(255 * $fromRgb.Luminance), 1), 254)
        }
    })]
    [string]
    $RGBColor,

    # The desired hue (ranged 0-360)
    [ValidateRange(0,360)]
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty('hue')]
    [ComponentModel.AmbientValue({ 
        [uint16][Math]::Floor(($_ / 360) * [Uint16]::maxValue)
    })]
    [Alias('H')]
    [float]
    $Hue,

    # The desired saturation (ranged 0-1)
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateRange(0,1)]
    [ComponentModel.DefaultBindingProperty('sat')]
    [ComponentModel.AmbientValue({ [byte](255 * $_) })]
    [Alias('S')]
    [float]
    $Saturation,

    # The desired brightness (ranged 0-1)
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty('bri')]
    [ComponentModel.AmbientValue({ [byte](255 * $_) })]
    [ValidateRange(0,1)]
    [Alias('B','L','Luminance','.bri')]
    [float]
    $Brightness,

    # The effect
    [ValidateSet('colorloop', 'none')]
    [ComponentModel.DefaultBindingProperty('effect')]
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Effect,

    # The alert
    [ValidateSet('select','lselect', 'none')]
    [ComponentModel.DefaultBindingProperty('alert')]
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Alert,

    # The color temperature as a Mired value.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty('ct')]
    [ComponentModel.AmbientValue({
        if ($_ -gt 500) {
            [int](1000000/$_)
        } else {
            $_
        }
    })]
    [ValidateRange(153,7875)]
    [Alias('CT','TemperatureMired')]
    [int]
    $ColorTemperature,

    # The color, in XY coordinates.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateScript({
    if (-not ($_.Count -ne 2)) { throw 'Must provide 2 values to use XY coordinates' }
    return $true
    })]
    [ValidateRange(0,1)]
    [ComponentModel.DefaultBindingProperty('xy')]
    [float[]]
    $XY,

    # The increment in saturation.  This will adjust the intensity of the color
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty('sat_inc')]
    [ValidateRange(-1,1)]
    [float]
    $SaturationIncrement,

    # An increment in luminance.  This will adjust the brightness of the light
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty('bri_inc')]
    [Alias('LuminanceIncrement')]
    [ValidateRange(-1,1)]
    [float]
    $BrightnessIncrement,

    # An increment in hue.  This will adjust the hue
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty('hue_inc')]
    [ComponentModel.AmbientValue({
        [int][Math]::Floor(($_ / 360) * [Uint16]::maxValue)
    })]
    [ValidateRange(-360,360)]
    [int]
    $HueIncrement,

    # A change in the color temperature.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty('ct_inc')]
    [ValidateRange(-65534,65534)]
    [int]
    $ColorTemperatureIncrement,

    # If set, will output the data that would be sent to the bridge.  This is useful for creating scheudles, routines, and other macros.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('OutputParameter','OutputParameters','OutputArgument', 'OutputArguments')]
    [switch]
    $OutputInput
    )

    begin {
        $getLightCmd = $ExecutionContext.SessionState.InvokeCommand.GetCommand('Get-HueLight', 'Function')

        $mapInput = {
            param(
            [Collections.IDictionary]$parameter = ([Ordered]@{} + $PSBoundParameters),
            $Caller = $(
                foreach ($CallStack in Get-PSCallStack) {
                    $callstackCmd = $callStack.InvocationInfo.MyCommand
                    if ($callstackCmd -is [Management.Automation.FunctionInfo] -or
                        $callstackCmd -is [Management.Automation.ExternalScriptInfo]) {
                        $callstackCmd;break
                    }
                })
            )

            $RestInput = @{}
            :nextParameter foreach ($paramName in $parameter.Keys) {
                $paramAttributes = $Caller.Parameters[$paramName].Attributes
                $restParamName   = ''
                $value = $_ = $parameter[$paramName]
                :nextAttribute foreach ($attr in $paramAttributes) {
                    if ($attr -is [ComponentModel.DefaultBindingPropertyAttribute]) {
                        $restParamName = $attr.Name
                    }
                    elseif ($attr -is [ComponentModel.AmbientValueAttribute] -and $attr.Value -is [ScriptBlock]) {
                        $value = $_ = & $attr.Value
                    }
                }
                if ($restParamName) {
                    $RestInput[$restParamName] = $value
                    if ($RestInput[$restParamName] -is [switch]) {
                        $RestInput[$restParamName] = $RestInput[$restParamName] -as [bool]
                    }
                } elseif ($value -is [Collections.IDictionary]) {
                    foreach ($kv in $value.GetEnumerator()) {
                        $RestInput[$kv.Key] = $kv.Value
                    }
                }
            }
            $RestInput
        }

        $invocatonName = $MyInvocation.InvocationName
        $invocationCommand = $MyInvocation.MyCommand
    }


    process {
        $lightSplat = @{} + $PSBoundParameters
        foreach ($k in @($lightSplat.Keys)) {
            if (-not $getLightCmd.Parameters.$k) {
                $lightSplat.Remove($k)
            }
        }



        $restIn = & $mapInput

        $sendSplat = @{
            Method = if ($restIn.Count) { 'PUT' } else { 'GET' }
            Data = $restIn
        }
        

        if (-not $restIn.Count) {
            $sendSplat.Remove('Data')
        }
        if ($OutputInput) {
            $sendSplat.OutputInput = $OutputInput
        }

        $paramSet = $PSCmdlet.ParameterSetName

        $bridges = Get-HueBridge
        switch ($paramSet) {
            All {

                if ($invocatonName -ne $invocationCommand.Name) {
                    foreach ($potentialResource in $script:KnownResources) {
                        if ($potentialResource.Name -eq $invocatonName -or
                            (($potentialResource.Name -replace '\s') -eq $invocatonName)
                        ) {
                            if ($potentialResource.action) { #If there's an action, it's a group
                                if ($restIn.Count) {
                                    $sendSplat.Command = "groups/$($potentialResource.id)/action"
                                } else {
                                    $sendSplat.Command = "groups/$($potentialResource.id)"
                                    $sendSplat.PSTypeName = 'Hue.LightGroup'
                                }
                                break
                            }
                            if ($potentialResource.state) { # If there's a state, it's a light
                                if ($restIn.Count) {
                                    $sendSplat.Command = "lights/$($potentialResource.id)/state"
                                } else {
                                    $sendSplat.Command = "lights/$($potentialResource.id)"
                                    $sendSplat.PSTypeName = 'Hue.Light'
                                }
                                break
                            }
                        }
                    }
                    if ($sendSplat.Command) {
                        $bridges | Send-HueBridge @sendSplat
                    }
                    return
                }

                # Get all bridges and send the data to the url that changes all lights

                if ($restIn.Count) {
                    $sendSplat.Command = "groups/0/action"
                } else {
                    $sendSplat.Command = "groups/0"
                    $sendSplat.PSTypeName = 'Hue.LightGroup'
                }


                $bridges | Send-HueBridge @sendSplat
            }
            Rooms {
                # Getting and filtering the rooms
                $RoomSplat = @{} + $lightSplat
                $RoomSplat.Name =  $RoomName
                $rooms = Get-HueBridge -Room @RoomSplat
                if (-not $restIn.Count) { $sendSplat.PSTypeName = 'Hue.LightGroup'}
                $Rooms |
                    Send-HueBridge -Command {
                        if ($restIn.Count) {
                            "groups/$($_.ID)/action"
                        } else {
                            "groups/$($_.ID)"
                        }
                    } @sendSplat
            }
            LightID {
                if ($restIn.Count) {
                    $sendSplat.Command = "lights/$lightID/state"
                } else {
                    $sendSplat.Command = "lights/$lightID"
                    $sendSplat.PSTypeName = 'Hue.Light'
                }

                $bridges |
                    Send-HueBridge @sendSplat
            }
            GroupID {
                if ($restIn.Count) {
                    $sendSplat.Command = "groups/$lightID/action"
                } else {
                    $sendSplat.Command = "groups/$lightID"
                    $sendSplat.PSTypeName = 'Hue.LightGroup'
                }
                $bridges |
                    Send-HueBridge  @sendSplat
            }
            default {
                $theLights = Get-HueLight @lightSplat
                if (-not $restIn.Count) {
                    $theLights
                } else {
                    $theLights |
                        Send-HueBridge -Command { "lights/$($_.ID)/state" } @sendSplat
                }
            }
        }

    }
}
