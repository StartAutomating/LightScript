function Set-Pixoo
{
    <#
    .SYNOPSIS
        Sets Pixoo Frames
    .DESCRIPTION
        Changes Pixoo Frames
    .EXAMPLE
        Set-Pixoo -Brightness 1
    .EXAMPLE        
        # Set the pixoo to the 3rd visualizer (a nice frequency graph)
        Set-Pixoo -Visualizer 3
    .EXAMPLE
        # The timer will elapse after 30 seconds.
        Set-Pixoo -Timer "00:00:30"
    .LINK
        Get-Pixoo
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
    # One or more IP Addresses of Twinkly devices.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('TwinklyIPAddress')]
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

    # If set, will turn a Pixoo screen on.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $On,

    # If set, will turn a Pixoo screen off.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Off,

    # If provided, will switch the Pixoo to a given numbered visualizer
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $Visualizer,

    # If provided, will switch the Pixoo custom playlist
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $CustomPlaylist,

    # If provided, will switch the Pixoo's current Cloud Channel.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $CloudChannel,

    # If provided, will switch the Pixoo channel.        
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet("Clock", "Cloud", "Visualizer", "Custom")]
    [string]
    $Channel,

    # If provided, will switch the Pixoo into Stopwatch mode, and Stop, Reset, or Start the StopWatch
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet("Stop", "Start", "Reset")]
    [string]
    $Stopwatch,

    # If provided, will switch the Pixoo into a Timer, with the given timespan.
    # (hours and subseconds will be ignored)
    [Parameter(ValueFromPipelineByPropertyName)]
    [Timespan]
    $Timer,

    # If set, will display a noise meter.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $NoiseMeter,

    # If provided, will switch the Pixoo into a Scoreboard.
    # -RedScore is the score for the Red Team
    # -BlueScore is the score for the Blue Team
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $RedScore,

    # If provided, will switch the Pixoo into a Scoreboard.
    # -RedScore is the score for the Red Team
    # -BlueScore is the score for the Blue Team
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $BlueScore,

    # If provided, will change the Pixoo into a single RGB color.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidatePattern('#(?>[a-f0-9]{6}|[a-f0-9]{3})')]
    [string]
    $RGBColor,

    # The latitude for the device.  Must be provided with -Longitude
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Lat')]
    [double]
    $Latitude,

    # The longitude for the device.  Must be provided with -Latitude
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Long')]
    [double]
    $Longitude,

    # Set the device rotation.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet(0,90,180,270)]
    [int]
    $Rotation,

    # If set, will put the Pixoo device into mirroring mode.
    # This can be nice if you have two Pixoos side by side.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Mirror
    )

    begin {
        if (-not $script:PixooCache) {
            $script:PixooCache = @{}
        }
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        $paramCopy = @{} + $PSBoundParameters
        #region Default to All Devices
        if (-not $IPAddress) { # If no -IPAddress was passed
            if ($home -and -not $script:PixooCache.Count) {
                # Read all .twinkly.clixml files beneath your LightScript directory.
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.pixoo.clixml -Force |
                    Import-Clixml |
                    ForEach-Object {
                        if (-not $_) { return }
                        $pixooConnection = $_                        
                        $script:PixooCache["$($pixooConnection.IPAddress)"] = $pixooConnection
                    }

                $IPAddress = $script:PixooCache.Keys # The keys of the device cache become the -IPAddress.
            } elseif ($script:PixooCache.Count) {
                $IPAddress = $script:PixooCache.Keys # The keys of the device cache become the -IPAddress.
            }
            if (-not $IPAddress) { # If we still have no -IPAddress                
                return #  return.
            }
        }
        #endregion Default to All Devices
        
        

        foreach ($ip in $ipAddress) {
            $refreshDevice = $false
            $invokeSplat = @{Uri="http://$ip/post";Method='POST'}
            $restOutputs = @(
                if ($paramCopy.ContainsKey("Brightness") -and -not 
                    ($paramCopy.ContainsKey("Hue") -or $paramCopy.ContainsKey("Saturation"))) {
                    $realBrightness = [Math]::Ceiling($Brightness * 100)
                    $invokeSplat.Body = (@{
                        Command = "Channel/SetBrightness"
                        Brightness = [int]$realBrightness
                    } | ConvertTo-Json -Compress)
                    if ($whatIfPreference) {
                        $invokeSplat
                    } elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Command)")) {
                        Invoke-RestMethod @invokeSplat
                    }                    
                    $refreshDevice = $true
                } elseif ($paramCopy.ContainsKey("Brightness") -and 
                    $paramCopy.ContainsKey("Hue") -and 
                    $paramCopy.ContainsKey("Saturation")
                ) {
                    $convertedColor = (([PSCustomObject]@{PSTypeName='LightScript.Color'}).HSLToRGB($Hue, $Saturation, $Brightness))
                    $RGBColor = $convertedColor.RGB
                }



                if ($On -and -not $Off) {
                    $invokeSplat.Body = (@{
                        Command = "Channel/OnOffScreen"
                        OnOff   = 1
                    } | ConvertTo-Json -Compress)
                    Invoke-RestMethod @invokeSplat
                    if ($whatIfPreference) {
                        $invokeSplat
                    } elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Command)")) {
                        Invoke-RestMethod @invokeSplat
                    }
                }

                if ($off) {
                    $invokeSplat.Body = (@{
                        Command = "Channel/OnOffScreen"
                        OnOff   = 0
                    } | ConvertTo-Json -Compress)
                    Invoke-RestMethod @invokeSplat
                    if ($whatIfPreference) {
                        $invokeSplat
                    } elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Command)")) {
                        Invoke-RestMethod @invokeSplat
                    }
                }

                if ($paramCopy.ContainsKey("Visualizer")) {
                    $invokeSplat.Body = (@{
                        Command = "Channel/SetEqPosition"
                        EqPosition = $Visualizer
                    } | ConvertTo-Json -Compress)                    
                    if ($whatIfPreference) {
                        $invokeSplat
                    } elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Command)")) {
                        Invoke-RestMethod @invokeSplat
                    }
                }

                if ($Latitude -and $longitude) {
                    $invokeSplat.Body = (@{
                        Command = "Sys/LogAndLat"
                        Longitude = $longitude
                        Latitude  = $Latitude
                    } | ConvertTo-Json -Compress)                    
                    if ($whatIfPreference) {
                        $invokeSplat
                    } elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Command)")) {
                        Invoke-RestMethod @invokeSplat
                    }
                }

                if ($RGBColor) {
                    $r,$g,$b = 
                        if ($RGBColor.Length -eq 7) {
                            [byte]::Parse($RGBColor[1..2]-join'', 'HexNumber')
                            [byte]::Parse($RGBColor[3..4]-join '', 'HexNumber')
                            [byte]::Parse($RGBColor[5..6] -join'', 'HexNumber')
                        }elseif ($RGBColor.Length -eq 4) {
                            [byte]::Parse($RGBColor[1], 'HexNumber') * 16
                            [byte]::Parse($RGBColor[2], 'HexNumber') * 16
                            [byte]::Parse($RGBColor[3], 'HexNumber') * 16
                        }
                    
                        $picId = 
                            if ($whatIfPreference) {
                                Get-Random -Maximum 1000
                            } else {
                                $invokeSplat.Body = (@{
                                    Command = "Draw/GetHttpGifId"
                                } | ConvertTo-Json -Compress)
                                Invoke-RestMethod @invokeSplat | 
                                    Select-Object -ExpandProperty PicID
                            }

                        $picData = 
                            @(foreach ($n in 1..(64 * 64)) {
                                $r
                                $g
                                $b
                            }) -as [byte[]]

                        $invokeSplat.Body = (@{
                            Command = "Draw/SendHttpGif"
                            PicNum = 1
                            PicID  = $picId
                            PicOffset = 0
                            PicSpeed  = 100
                            PicWidth = 64
                            PicData = [Convert]::ToBase64String($picData)
                        } | ConvertTo-Json -Compress)
                        if ($whatIfPreference) {
                            $invokeSplat
                        } else {
                            Invoke-RestMethod @invokeSplat
                        }
                        
                }

                if ($Channel) {
                    $valueList = @($myInvocation.MyCommand.Parameters.Channel.Attributes.ValidValues)                    
                    for ($index = 0; $index -lt $valueList.Count;$index++) {
                        if ($Channel -eq $valueList[$index]) {
                            $invokeSplat.Body = (@{
                                Command = "Channel/SetIndex"
                                SelectIndex = $index
                            } | ConvertTo-Json -Compress)
                            if ($whatIfPreference) {
                                $invokeSplat
                            } elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Command)")) {
                                Invoke-RestMethod @invokeSplat
                            }
                            break
                        }
                    }                    
                }

                if ($Stopwatch) {
                    $valueList = @($myInvocation.MyCommand.Parameters.StopWatch.Attributes.ValidValues)                    
                    for ($index = 0; $index -lt $valueList.Count;$index++) {
                        if ($Stopwatch -eq $valueList[$index]) {
                            $invokeSplat.Body = (@{
                                Command = "Tools/SetStopWatch"
                                Status  = $index
                            } | ConvertTo-Json -Compress)
                            if ($whatIfPreference) {
                                $invokeSplat
                            } elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Command)")) {
                                Invoke-RestMethod @invokeSplat
                            }
                            break
                        }
                    }                    
                }

                if ($PSBoundParameters.ContainsKey("Rotation")) {
                    $invokeSplat.Body = (@{
                        Command = "Device/SetScreenRotationAngle"
                        Mode    = $Rotation / 90
                    } | ConvertTo-Json -Compress)
                    if ($whatIfPreference) {
                        $invokeSplat
                    } elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Command)")) {
                        Invoke-RestMethod @invokeSplat
                    }
                }

                if ($PSBoundParameters.ContainsKey("Mirror")) {
                    $invokeSplat.Body = (@{
                        Command = "Device/SetMirrorMode"
                        Mode    = $Mirror -as [bool] -as [int]
                    } | ConvertTo-Json -Compress)
                    if ($whatIfPreference) {
                        $invokeSplat
                    } elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Command)")) {
                        Invoke-RestMethod @invokeSplat
                    }
                }

                if ($psBoundParameters.ContainsKey("CustomPlaylist")) {                    
                    $invokeSplat.Body = (@{
                        Command = "Channel/SetCustomPageIndex"
                        CustomPageIndex = $CustomPlaylist
                    } | ConvertTo-Json -Compress)
                    if ($whatIfPreference) {
                        $invokeSplat
                    } elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Command)")) {
                        Invoke-RestMethod @invokeSplat
                    }
                }                

                if ($psBoundParameters.ContainsKey("CloudChannel")) {
                    $invokeSplat.Body = (@{
                        Command = "Channel/CloudIndex"
                        Index = $CloudChannel
                    } | ConvertTo-Json -Compress)
                    if ($whatIfPreference) {
                        $invokeSplat
                    } elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Command)")) {
                        Invoke-RestMethod @invokeSplat
                    }
                }

                if ($timer) {
                    $invokeSplat.Body = (@{
                        Command = "Tools/SetTimer"
                        Minute = [int]$Timer.Minutes
                        Second = [int]$Timer.Seconds                        
                    } | ConvertTo-Json -Compress)
                    if ($whatIfPreference) {
                        $invokeSplat
                    } elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Command)")) {
                        Invoke-RestMethod @invokeSplat
                    }
                }

                if ($NoiseMeter.IsPresent) {
                    $invokeSplat.Body = (@{
                        Command = "Tools/SetNoiseStatus"
                        NoiseStatus = $NoiseMeter -as [bool] -as [int]
                    } | ConvertTo-Json -Compress)
                    if ($whatIfPreference) {
                        $invokeSplat
                    } elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Command)")) {
                        Invoke-RestMethod @invokeSplat
                    }
                }

                if ($paramCopy.ContainsKey("RedScore") -or $paramCopy.ContainsKey("BlueScore")) {
                    $invokeSplat.Body = (@{
                        Command = "Tools/SetScoreBoard"
                        BlueScore = 
                            if ($paramCopy.ContainsKey("BlueScore")) {
                                $BlueScore
                                $script:PixooCache["$ip"] = $script:PixooCache["$ip"] | Add-Member NoteProperty BlueScore $BlueScore -Force -PassThru
                            } elseif ($script:PixooCache["$ip"].BlueScore) {
                                $script:PixooCache["$ip"].BlueScore
                            } else { 
                                0
                            }
                        RedScore = 
                            if ($paramCopy.ContainsKey("RedScore")) {
                                $RedScore
                                $script:PixooCache["$ip"] = $script:PixooCache["$ip"] | Add-Member NoteProperty RedScore $RedScore -Force -PassThru
                            } elseif ($script:PixooCache["$ip"].RedScore) {
                                $script:PixooCache["$ip"].RedScore
                            } else { 0 }                        
                    } | ConvertTo-Json -Compress)
                    if ($whatIfPreference) {
                        $invokeSplat
                    } elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Command)")) {
                        Invoke-RestMethod @invokeSplat
                    }
                }
            )

            if ($restOutputs -and $whatIfPreference) {
                $restOutputs
            }

            if ($refreshDevice -and -not ($restOutputs | Where-Object error_code -gt 0) -and -not $whatIfPreference) {
                Connect-Pixoo -IPAddress $IP
            }
        }
    }
}
