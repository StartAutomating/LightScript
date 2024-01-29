function Set-Awtrix
{
    <#
    .SYNOPSIS
        Sets Awtrix 
    .DESCRIPTION
        Changes Awtrix devices
    .EXAMPLE
        Set-Awtrix -Brightness 1
    .EXAMPLE
        Set-Awtrix -RGBColor "#4488ff" # Sets the Awtrix to a blue moodlight
    .EXAMPLE
        Set-Awtrix -NotificationText "Hello World"
    .EXAMPLE
        Set-Awtrix -Hue 180 -Saturation .5 -Brightness .25
    .LINK
        Get-Awtrix
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
    # One or more IP Addresses of Awtrix devices.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('AwtrixIPAddress')]
    [IPAddress[]]
    $IPAddress,
    # Sets the brightness of all lights in a fixture
    # When passed with -Hue and -Saturation, sets the color
    # When passed with no other parameters, adjusts the absolute brightness
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Luminance')]
    [ValidateRange(0,1)]
    [float]
    $Brightness,

    # Sets the hue of all lights in a fixture
    [Parameter(ValueFromPipelineByPropertyName)]
    [double]
    $Hue,

    # Sets the saturation of all lights in a fixture
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateRange(0,1)]
    [double]
    $Saturation,

    # If set, will turn a Awtrix screen on.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $On,

    # If set, will turn a Awtrix screen off.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Off,

    # If set, will reboot an Awtrix device.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Reset')]
    [switch]
    $Reboot,

    # If provided, will change the Awtrix into a single RGB color.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('#(?>[a-f0-9]{6}|[a-f0-9]{3})')]
    [string]
    $RGBColor,    

    # If set, will change the Awtrix into a given color temperature.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty('ct')]
    [ComponentModel.AmbientValue({
        $ct = if ($_ -lt 1200) {
            [int](1000000/$_)
        } else {
            $_
        }
        @{kelvin=$ct}
    })]
    [ValidateRange(1,6500)]
    [Alias('CT','TemperatureKelvin')]
    [int]
    $ColorTemperature,

    # The name of the application on the device.
    # This is used when sending custom notifications, and when -SwitchTo is passed.
    [Parameter(ValueFromPipelineByPropertyName)]
    [AliaS('AppName')]
    [string]
    $ApplicationName,

    # If set, will switch to a specific application (provided by `-ApplicationName`) or the next item.
    [Alias('SwitchingTo')]
    [switch]
    $SwitchTo,

    # If set, will switch to the previous application on the Awtrix.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('LastApp','Last','Prev', 'Previous','PreviousApp', 'PreviousApplication')]
    [switch]
    $LastApplication,

    # If set, will switch to the next application on the Awtrix.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('NextApp','Next')]
    [switch]
    $NextApplication,

    # One or more messages of notification text
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Activity')]
    [string[]]
    $NotificationText,

    # If provided, will display a progress bar within a notification.
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $PercentComplete,
    
    # If set, will clear a progress bar within a notification.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Completed,

    # The duration of the notification (rounded to the nearest second).
    # By default, 15 seconds.
    [Parameter(ValueFromPipelineByPropertyName)]
    [timespan]
    $NotificationDuration = "00:00:15",

    # The number of times to display the notification.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('LoopCount','RepeatCount')]
    [int]
    $NotificationLoopCount,

    # If set, will hold a notification, instead of displaying it for a duration.
    [switch]
    $HoldNotification,

    # The name of the effect.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ArgumentCompleter({
        param ( $commandName,
            $parameterName,
            $wordToComplete,
            $commandAst,
            $fakeBoundParameters )
        $effectNames = @(Get-Awtrix -ListEffectName | 
            Select-Object -Unique)
        if ($wordToComplete) {        
            $toComplete = $wordToComplete -replace "^'" -replace "'$"
            return @($effectNames -like "$toComplete*" -replace '^', "'" -replace '$',"'")
        } else {
            return @($effectNames -replace '^', "'" -replace '$',"'")
        }
    })]
    [Alias('animName')]
    [string]
    $EffectName,

    # Any options for the effect
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('EffectOptions','EffectParameter','EffectParameters')]
    [PSObject]
    $EffectOption,

    # The speed of the effect
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('EffectSpeeds')]
    [int]
    $EffectSpeed,

    # Any options related to the notification.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('NotificationOptions','NotificationParameter','NotificationParameters')]
    [PSObject]
    $NotificationOption
    )

    begin {
        if (-not $script:AwtrixCache) {
            $script:AwtrixCache = @{}
        }
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        $paramCopy = @{} + $PSBoundParameters
        #region Default to All Devices
        if (-not $IPAddress) { # If no -IPAddress was passed
            if ($home -and -not $script:AwtrixCache.Count) {
                # Read all .twinkly.clixml files beneath your LightScript directory.
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.awtrix.clixml -Force |
                    Import-Clixml |
                    ForEach-Object {
                        if (-not $_) { return }
                        $AwtrixConnection = $_                        
                        $script:AwtrixCache["$($AwtrixConnection.IPAddress)"] = $AwtrixConnection
                    }

                $IPAddress = $script:AwtrixCache.Keys # The keys of the device cache become the -IPAddress.
            } elseif ($script:AwtrixCache.Count) {
                $IPAddress = $script:AwtrixCache.Keys # The keys of the device cache become the -IPAddress.
            }
            if (-not $IPAddress) { # If we still have no -IPAddress                
                return #  return.
            }
        }
        #endregion Default to All Devices
                
        foreach ($ip in $ipAddress) {
            $refreshDevice = $false
            $invokeSplat = @{Uri="http://$ip/";Method='POST';ContentType='application/json'}
            $restSplats = @(
                if ($paramCopy.ContainsKey("Brightness") -and -not 
                    (
                        $paramCopy.ContainsKey("Hue") -or 
                        $paramCopy.ContainsKey("Saturation") -or 
                        $paramCopy.RGBColor -or 
                        $paramCopy.ColorTemperature
                    )) {
                    $realBrightness = [Math]::Ceiling($Brightness * 255)
                    $invokeSplat.Uri = "http://$ip/api/settings"
                    $invokeSplat.Body = (@{
                        BRI = [byte]$realBrightness
                    } | ConvertTo-Json -Compress)
                    [Ordered]@{} + $invokeSplat                    
                    
                } elseif ($paramCopy.ContainsKey("Brightness") -and 
                    $paramCopy.ContainsKey("Hue") -and 
                    $paramCopy.ContainsKey("Saturation")
                ) {
                    $convertedColor = (([PSCustomObject]@{PSTypeName='LightScript.Color'}).HSLToRGB($Hue, $Saturation, $Brightness))
                    $RGBColor = $convertedColor.RGB
                }


                #region On/Off Switch
                if ($On -and -not $Off) {
                    $invokeSplat.Uri = "http://$ip/api/power"
                    $invokeSplat.Body = (@{power   = $true} | ConvertTo-Json -Compress)                    
                    [Ordered]@{} + $invokeSplat
                }

                if ($off) {
                    $invokeSplat.Uri = "http://$ip/api/power"
                    $invokeSplat.Body = (@{power   = $false} | ConvertTo-Json -Compress)
                    Invoke-RestMethod @invokeSplat
                    [Ordered]@{} + $invokeSplat
                }
                #endregion On/Off Switch

                #region Color Temperature
                if ($ColorTemperature) {
                    $invokeSplat.Uri = "http://$ip/api/moodlight"
                    foreach ($attr in $MyInvocation.MyCommand.Parameters['ColorTemperature'].Attributes) {
                        if ($attr -isnot [ComponentModel.AmbientValueAttribute]) { continue }
                        $_ = $ColorTemperature
                        $invokeSplat.Body = . $attr.Value
                        break
                    }
                    if ($Brightness) {
                        $invokeSplat.Body.brightness = [byte][Math]::Ceiling($Brightness * 255)
                    }                    
                    [Ordered]@{} + $invokeSplat
                }
                #endregion Color Temperature
                
                #region RGBColor
                if ($RGBColor) {
                    $invokeSplat.Uri = "http://$ip/api/moodlight"
                    $invokeSplat.Body = @{color="$rgbColor"}
                    if ($paramCopy.ContainsKey("Brightness")) {
                        $invokeSplat.Body.brightness = [byte][Math]::Ceiling($Brightness * 255)
                    }
                    [Ordered]@{} + $invokeSplat                             
                }
                #endregion RGBColor

                if ($NextApplication -or $LastApplication -or $SwitchTo) {
                    
                    if ($LastApplication) {
                        $invokeSplat.Uri = "http://$ip/api/previousapp"
                    }
                    elseif ($NextApplication -or ($SwitchTo -and -not $ApplicationName)) {
                        $invokeSplat.Uri = "http://$ip/api/nextapp"
                    }
                    elseif ($SwitchTo -and $ApplicationName) {
                        $invokeSplat.Uri = "http://$ip/api/switch"
                        $invokeSplat.Body = @{name=$ApplicationName} | ConvertTo-Json                        
                    }
                    [Ordered]@{} + $invokeSplat
                }
                
                if ($NotificationText -or $NotificationOption -or $EffectName) {
                    if ($ApplicationName) {
                        $invokeSplat.Uri = "http://$ip/api/custom?name=$($ApplicationName)"
                    } else {
                        $invokeSplat.Uri = "http://$ip/api/notify"
                    }
                    
                    $invokeSplat.Body = @{}
                    foreach ($NotificationString in $NotificationText) {
                        if (-not $invokeSplat.Body.text) {
                            $invokeSplat.Body.text = @()
                        }
                        $textFragment = @{t=$NotificationString}
                        if ($RGBColor) { $textFragment.c = $RGBColor -replace '^#'}
                        $invokeSplat.Body.text += $textFragment
                    }

                    if ($EffectName) {
                        $invokeSplat.Body.effect = $EffectName
                    }
                    
                    if ($EffectOption) {
                        $invokeSplat.Body.effectSettings = $EffectOption
                    } else {
                        if (-not $invokeSplat.Body.effectSettings) {
                            $invokeSplat.Body.effectSettings = @{}
                        }
                    }

                    if ($EffectSpeed) {                        
                        $invokeSplat.Body.effectSettings.speed = $EffectSpeed
                    }

                    if ($Completed) {
                        $PSBoundParameters['PercentComplete'] = $PercentComplete = -1
                    }

                    if ($PSBoundParameters.ContainsKey('PercentComplete')) {
                        $invokeSplat.Body.progress = $PercentComplete
                    }

                    if ($HoldNotification) {
                        $invokeSplat.Body.hold = $true
                    } elseif ($PSBoundParameters["NotifcationDuration"]) {
                        $invokeSplat.Body.duration = [int][Math]::round($NotificationDuration.TotalSeconds)
                    }

                    if ($NotificationOption) {
                        if ($NotificationOption -is [Collections.IDictionary]) {
                            $NotificationOption = [PSCustomObject]$NotificationOption
                        }
                        
                        foreach ($notificationProperty in $NotificationOption.psobject.properties) {
                            $invokeSplat.Body.$($notificationProperty.Name) = $notificationProperty.Value
                        }
                    }

                    $invokeSplat                    
                }

                if ($Reboot) {
                    $invokeSplat.Uri = "http://$ip/api/reboot"
                    $invokeSplat.Body = ""
                    $invokeSplat.Method = "POST"
                    [Ordered]@{} + $invokeSplat
                }
            )

            $restOutputs = 
                foreach ($restSplat in $restSplats) {
                    if ($restSplat.Body) {
                        $restSplat.Body  = $restSplat.Body | ConvertTo-Json -Depth 100
                    }
                    if ($whatIfPreference) {
                        $restSplat
                    }
                    elseif ($PSCmdlet.ShouldProcess("$($restSplat.Method) $($restSplat.Uri)")) {
                        Invoke-RestMethod @restSplat
                    }
                }

            if ($restOutputs -and $whatIfPreference) {
                $restOutputs
            }
        }
    }
}
