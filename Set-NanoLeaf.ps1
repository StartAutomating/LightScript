function Set-NanoLeaf
{
    <#
    .Synopsis
        Changes settings on a NanoLeaf.
    .Description
        Changes settings on one or more NanoLeaf controllers.
    .Example
        Set-NanoLeaf -ColorTemperature 1999
    .Example
        Set-NanoLeaf -Hue (Get-Random -Min 0 -Max 360) -Saturation ((Get-Random -Min 0 -Max 1)/100) -Brightness ((Get-Random -Min 0 -Max 1)/100)
    .Example
        Set-NanoLeaf -EffectName Blaze
    .Example
        Set-NanoLeaf -Palette "#fedcba", "#abcdef"  # Fade between two colors
    .Example
        Set-NanoLeaf -Palette "#fedcba", "#abcdef" -PluginName Flow
    .Example
        Set-NanoLeaf -Palette "#012345", "#543210" -PluginName Wheel
    .Example
        Set-NanoLeaf -Palette "#ff0000", "#000000", "#00ff00", "#000000", "#0000ff", "#000000" -PluginName Fireworks -PluginType Rhythm
    .Link
        Get-NanoLeaf
    .Link
        Send-NanoLeaf
    #>
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='Low',DefaultParameterSetName='SimpleSet')]
    [OutputType([PSObject])]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidAssignmentToAutomaticVariable", "", Justification=" Side-Effects Desired ")]
    param(
    # If set, will turn the nanoleaf off
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Off,

    # If set, will turn the nanoleaf on
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $On,

    # The hue of the NanoLeaf light color.
    [ComponentModel.DefaultBindingProperty('hue')]
    [ComponentModel.AmbientValue({
        [PSCustomObject]@{value=$_ % 360}
    })]
    [int]
    $Hue,

    # Increments the hue of the NanoLeaf light color.
    [ComponentModel.DefaultBindingProperty('hue')]
    [ComponentModel.AmbientValue({
        [PSCustomObject]@{increment=$hueIncrement % 360}
    })]
    [int]
    $HueIncrement,

    # The saturation of the NanoLeaf light color.
    [ComponentModel.DefaultBindingProperty('sat')]
    [ComponentModel.AmbientValue({
        [PSCustomObject]@{value=[Math]::Round($_ * 100)}
    })]
    [ValidateRange(0,1)]
    [double]
    $Saturation,

    # Increments the saturation of the NanoLeaf light color.
    [ComponentModel.DefaultBindingProperty('sat')]
    [ComponentModel.AmbientValue({
        [PSCustomObject]@{increment=[int][Math]::Round($_)}
    })]
    [int]
    $SaturationIncrement,

    # The brightness.
    # If no other parameters are provided, adjusts universal brightness.
    # If provided with -Hue and -Saturation, sets the color of all panels.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateRange(0,1)]
    [double]
    $Brightness,

    # If set, will change all panels on the nanoleaf to a given color temperature.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty('ct')]
    [ComponentModel.AmbientValue({
        $ct = if ($_ -lt 1200) {
            [int](1000000/$_)
        } else {
            $_
        }
        [PSCustomObject]@{value=$ct}
    })]
    [ValidateRange(1,6500)]
    [Alias('CT','TemperatureKelvin')]
    [int]
    $ColorTemperature,

    # The name of the effect.
    [ArgumentCompleter({
        param ( $commandName,
            $parameterName,
            $wordToComplete,
            $commandAst,
            $fakeBoundParameters )
        $effectNames = @(Get-NanoLeaf -ListEffectName | 
            Select-Object -Unique) 
        if ($wordToComplete) {        
            $toComplete = $wordToComplete -replace "^'" -replace "'$"
            return @($effectNames -like "$toComplete*" -replace '^', "'" -replace '$',"'")
        } else {
            return @($effectNames -replace '^', "'" -replace '$',"'")
        }
    })]
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('animName')]
    [string]
    $EffectName,

    # The duration to display.  In most contexts, this will be rounded to the nearest second.
    [Timespan]
    $Duration,

    # If set, will set the NanoLeaf for external control via UDP.
    # If provided with -Panel, will set panels via UDP.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $ExternalControl,

    # The name of the effect plugin.
    [ArgumentCompleter({
        param ( $commandName,
            $parameterName,
            $wordToComplete,
            $commandAst,
            $fakeBoundParameters )
        $pluginNames = @(Get-NanoLeaf -ListPlugin | 
            Select-Object -Unique -ExpandProperty name)
        if ($wordToComplete) {        
            $toComplete = $wordToComplete -replace "^'" -replace "'$"
            return @($pluginNames -like "$toComplete*" -replace '^', "'" -replace '$',"'")
        } else {
            return @($pluginNames -replace '^', "'" -replace '$',"'")
        }
    })]
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $PluginName,

    # The palette used for an effect.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateScript({
        if ($_ -match '#(?>[\da-f]{6}|[\da-f]{3})') { return $true }
        if ($null -eq $_.Hue -and $null -eq $_.H) { throw "Must provide .Hue or .H" }
        if ($null -eq $_.Saturation -and $null -eq $_.S) { throw "Most provide .Saturation or .S" }
        if ($null -eq $_.Luminance -and
            $null -eq $_.L -and
            $null -eq $_.Brightness -and
            $null -eq $_.B
        ) {
            throw "Must provide .Luminance or .L or .Brightness or .B"
        }
        return $true
    })]
    [Alias('RGBColor')]
    [PSObject[]]
    $Palette,

    # The type of effect.
    [ValidateSet('Plugin','Random','Flow','Wheel','Fade','Highlight','Custom','Static')]
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $EffectType = 'plugin',

    # The plugin UUID.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $PluginUuid,

    # The plugin type.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet('Rhythm', 'Color')]
    [string]
    $PluginType,

    # Detailed colors for each panel.
    # The key will be the panel ID.
    # The value will be an RGB color for the panel, followed by an optional timespan.
    # Timespans will be ignored when sending colors via UDP.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateScript({
        foreach ($k in $_.Keys) {
            if ($k -as [int] -le 0) {
                throw "All keys must be integers."
            }
            if (-not ($_[$k] -match "#[0-9a-f]{6,6}")) {
                throw "All values must be hex colors or timespans"
            }
            foreach ($v in $_[$k]) {
                if ($v -isnot [string] -and $v -isnot [Timespan]) {
                    throw "All values must be hex colors or timespans"
                }
                if ($v -notmatch "#[0-9a-f]{6,6}" -and -not ($v -as [Timespan])) {
                    throw "All values must be hex colors or timespans"
                }
            }
        }
        return $true
    })]
    [Collections.IDictionary]
    $Panel = @{},

    # The effect options
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('PluginOption','PluginOptions','EffectOptions')]
    [Collections.IDictionary]
    $EffectOption = @{},

    # If set, will mark the effect to loop.
    [switch]
    $Loop,

    # If set, will set panels using UDP.
    [switch]
    $AsByteStream,

    # The IP Address of the NanoLeaf.
    [Parameter(ValueFromPipelineByPropertyName)]
    [IPAddress]
    $IPAddress = $([IPAddress]::any),

    # The nanoleaf token
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $NanoLeafToken
    )

    begin {
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
                    if ($null -ne $RestInput[$restParamName] -and
                        $RestInput[$restParamName].pstypenames -eq 'System.Management.Automation.PSCustomObject' -and
                        $value.pstypenames -eq 'System.Management.Automation.PSCustomObject') {
                        foreach ($prop in $value.psobject.properties) {
                            Add-Member -InputObject $RestInput[$restParamName] -MemberType NoteProperty -Name $prop.Name -Value $prop.Value -Force
                        }
                    } else {
                        $RestInput[$restParamName] = $value
                        if ($RestInput[$restParamName] -is [switch]) {
                            $RestInput[$restParamName] = $RestInput[$restParamName] -as [bool]
                        }
                    }
                } elseif ($value -is [Collections.IDictionary]) {
                    foreach ($kv in $value.GetEnumerator()) {
                        $RestInput[$kv.Key] = $kv.Value
                    }
                }
            }
            $RestInput
        }
    }
    process {
        if (-not $psBoundParameters['IPAddress']) { # If no -IPAddress was provided
            $psBoundParameters['IPAddress'] = $IpAddress = [IPAddress]::Any # use "Any".
        }
        $ipAndToken = @{IPAddress=$psBoundParameters['IPAddress'];NanoLeafToken=$psBoundParameters['NanoLeafToken']}

        $restIn = & $mapInput

        $endpoint = 'state'
        $sendData = [Ordered]@{} + $restIn


        if ($Brightness) {
            $sendData.brightness = [Ordered]@{value=[int][Math]::Round($Brightness * 100)}
            if ($Duration.TotalSeconds) {
                $sendData.brightness.duration = [int][Math]::Round($Duration.TotalSeconds)
            } else {
                $sendData.brightness.duration = 0
            }
        }

        if ($on) {
            $sendData.on = @{value=$true}
        }
        if ($off) {
            $sendData.on = @{value=$false}
        }

        #region Set HSB/HSL Color for all panels
        if ($Hue -and $Saturation -and $Brightness) {
            $hslData = @{
                write = [Ordered]@{
                    command = 'display'
                    version = '1.0'
                    animType = "solid"
                    palette = @(
                        [Ordered]@{hue=$Hue%360;saturation=$Saturation*100;brightness=$Brightness*100}
                    )
                    colorType="HSB"
                }
            } | ConvertTo-Json -Depth 5

            Send-NanoLeaf @ipAndToken -Command 'effects' -Data $hslData -Method PUT
            return
        }
        #endregion Set HSB/HSL Color for all panels

        $writeCommand = [Ordered]@{}
        if (-not $effectName) {
            $writeCommand.command = "display"
        } else {
            $writeCommand.command = "add"
            $writeCommand.animName = $EffectName
        }
        $writeCommand.version = "2.0"
        $writeCommand.colorType = "HSB"


        #region Select Effect
        if ($EffectName -and -not $Palette)
        {
            Send-NanoLeaf @ipAndToken -Command 'effects/select' -Data @{
                    select = $EffectName
                } -Method PUT
                if ($?) {
                    [PSCustomObject]@{
                        IPAddress = $IPAddress
                        NanoLeafToken = $NanoLeafToken
                        CurrentEffectName = $EffectName
                        PSTypeName = 'NanoLeaf.Effect.Selected'
                    }
                }
            $sendData.Clear()
        }
        #endregion Select Effect

        #region Set specific panels
        if ($Panel.Count) {
            $nanoLeafInfo = Get-NanoLeaf @ipAndToken -Layout
            $panelsIds = $nanoleafinfo.positiondata | Select-Object -ExpandProperty PanelID
            $panelCount = 0
            foreach ($k in $Panel.Keys) {
                if ($panelsIds -contains $k) {
                    $PanelCount++
                }
            }

            $messageData = @(
                if ($AsByteStream) {
                    $panelCountBytes = [BitConverter]::GetBytes([uint16]$panelCount)
                    $panelCountBytes[1]
                    $panelCountBytes[0]
                } else { $panelCount }
                foreach ($k in $panel.Keys) {
                    if ($panelsIds -notcontains $k) { continue }
                    if ($AsByteStream) {
                        $panelIdBytes = [BitConverter]::GetBytes([uint16]$k)
                        $panelIdBytes[1]
                        $panelIdBytes[0]
                    } else {
                        $k
                    }
                    $values = @($panel[$k])
                    $frameCount = @($values -like '#*').Count
                    if (-not $AsByteStream) { $frameCount }
                    for($vN =0; $vn -lt $values.Count; $vn++) {
                        $v = $values[$vn]
                        if ($v -like '#*') {
                            $rgb   = ($v -replace '#', '0x') -as [int]

                            [byte](($rgb -band 0xff0000) -shr 16)
                            [byte](($rgb -band 0x00ff00) -shr 8)
                            [byte]($rgb -band 0x0000ff)

                            0

                            if ($values[$vn + 1] -as [Timespan]) {
                                $ms = [int][Math]::Round(($values[$vn + 1] -as [Timespan]).TotalMilliseconds / 100)
                                if ($ms -ge 0) {
                                    if ($AsByteStream) {
                                        $timeSpanBytes = [BitConverter]::GetBytes([uint16]$ms)
                                        $timeSpanBytes[1]
                                        $timeSpanBytes[0]
                                    } else {
                                        $ms
                                    }
                                }
                                elseif (-not $AsByteStream) { -1 }
                                else { 0;0 }
                                $vn++
                            } else {
                                if ($AsByteStream) {
                                    0;0
                                } else {
                                    0
                                }
                            }
                        }
                    }


                }
            )
            if ($AsByteStream) {
                $datagram = $messageData -as [byte[]]
                $udpClient = [Net.Sockets.UdpClient]::new()
                if ($IPAddress -in [IPAddress]::Any,[IPAddress]::Broadcast) {
                    foreach ($val in $Script:NanoLeafCache.Values) {
                        $ipEndpoint = [IPEndpoint]::new($val.IPAddress, 60222)
                        $null = $udpClient.Send($datagram, $datagram.Length, $ipEndpoint)
                    }
                } else {
                    $ipEndpoint = [IPEndpoint]::new($val.IPAddress, 60222)
                    $null = $udpClient.Send($datagram, $datagram.Length, $ipEndpoint)
                }

                return
            } else {
                $writeCommand.animData = $messageData  -join ' '
            }
            if (-not $panelCount) { return }
            $EffectType = 'static'
        }
        #endregion Set specific panels

        #region Set Palette
        if ($Palette) {
            $realPalette = @(foreach ($p in $Palette) {
                if ($p -like '#*') { $p = ([pscustomobject]@{PSTypeName="LightScript.Color"}).FromRGB("$p") }
                $hslVal = [Ordered]@{
                    hue=$(if ($p.H) {$p.H} else {$p.Hue}) % 360
                    saturation=$(if ($p.S) {$p.S} else {$p.Saturation})
                    brightness=$(
                        if ($p.L) {$p.L}
                        elseif ($p.B) {$p.B }
                        elseif ($p.Luminance) { $p.Luminance }
                        else {$p.Brightness}
                    )
                    probability = $(
                        if ($p.Probability) { $p.Probability } else { 0 }
                    )
                }
                if ($hslVal.Saturation -is [double] -and $hslVal.Saturation -le 1) {
                    $hslVal.saturation = [int]($hslVal.saturation * 100)
                }
                if ($hslVal.Brightness -is [double] -and $hslVal.Brightness -le 1) {
                    $hslVal.brightness = [int]($hslVal.brightness * 100)
                }
                if ($hslVal.Hue -is [double]) {
                    $hslVal.hue = [int]$hslVal.Hue
                }
                $hslVal
            })
            $writeCommand.palette = $realPalette
        }
        #endregion Set Palette

        if ($Palette -and -not $PluginName -and -not ($PluginUuid -and $PluginType)) {
            $PluginName = 'Fade'
        }

        if ($PluginName -and -not ($PluginUuid -and $PluginType)) { # If a -PluginName was provided, but not a UUID or type.
            foreach ($plug in Get-NanoLeaf -ListPlugin @ipAndToken) { # Get all the plugins
                if ($plug.name -eq $PluginName) { # and find the UUID and type.
                    $PluginUuid = $plug.uuid
                    $PluginType = $plug.type
                }
            }
        }

        if ($PluginUuid) {
            $writeCommand.pluginUuid = $PluginUuid
        }
        if ($pluginType) {
            $writeCommand.pluginType = $PluginType.ToLower()
        }

        if ($Loop) {
            $writeCommand.Loop= $true
        }

        if ($_.PluginOptions) {
            foreach ($originalOption in $_.PluginOptions) {
                if (-not $EffectOption[$originalOption.Name]) {
                    $EffectOption[$originalOption.Name] = $originalOption.Value
                }
            }
        }

        if ($EffectOption.Count) {
            $writeCommand.pluginOptions = @(foreach ($kv in $EffectOption.GetEnumerator()) {
                [PSCustomObject][Ordered]@{name=$kv.Key;value=$kv.Value}
            })
        }

        #region Write Palette or Panels
        if ($Palette -or $Panel.Count) {
            $writeCommand.animType = $EffectType
            if (-not $writeCommand.palette) {
                $writeCommand.palette = @()
            }
            Send-NanoLeaf @ipAndToken -Command effects -Data @{
                write = $writeCommand
            } -Method PUT -Verbose
            $sendData.Clear()
        }
        #endregion Write Palette or Panels

        #region Handle External Control
        if ($ExternalControl) {
            $writeCommand = @{
                command = 'display'
                animType = 'extControl'
                extControlVersion = 'v2'
            }
            Send-NanoLeaf @ipAndToken -Command effects -Method PUT -Data @{write=$writeCommand}
            $sendData.Clear()
        }
        #endregion Handle External Control

        if ($sendData.Count) {
            Send-NanoLeaf @ipAndToken -Data ([PSCustomObject]$sendData) -Command $endpoint -Method PUT
        }
    }
}
