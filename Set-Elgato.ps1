function Set-Elgato {
    <#
    .Synopsis
        Sets Elgato Lighting
    .Description
        Changes Elgato Lighting
    .Example
        Set-Elgato -Brightness .5
    .LINK
        Get-Elgato
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        # One or more IP Addresses of Elgato Lighting devices.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('ElgatoIPAddress')]
        [IPAddress[]]
        $IPAddress,

        # Sets the brightness of all lights in a fixture
        # When passed with -Hue and -Saturation, sets the color
        # When passed with no other parameters, adjusts the absolute brightness
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('Luminance')]
        [ValidateRange(0, 1)]
        [float]
        $Brightness,

        # If set, will turn a Elgato screen on.
        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]
        $On,

        # If set, will turn a Elgato screen off.
        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]
        $Off,

        # The color temperature as a Mired value.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ComponentModel.DefaultBindingProperty('ct')]
        [ValidateRange(143, 334)]
        [Alias('CT', 'TemperatureMired')]
        [int]
        $ColorTemperature
    )

    begin {
        $PSDefaultParameterValues = @{
            "Invoke-RestMethod:ContentType" = "application/json"
        }
        if (-not $script:ElgatoCache) {
            $script:ElgatoCache = @{}
        }
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        $paramCopy = @{} + $PSBoundParameters
        #region Default to All Devices
        if (-not $IPAddress) {
            # If no -IPAddress was passed
            if ($home -and -not $script:ElgatoCache.Count) {
                # Read all .twinkly.clixml files beneath your LightScript directory.
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.elgato.clixml -Force |
                Import-Clixml |
                ForEach-Object {
                    if (-not $_) { return }
                    $ElgatoConnection = $_                        
                    $script:ElgatoCache["$($ElgatoConnection.IPAddress)"] = $ElgatoConnection
                }

                $IPAddress = $script:ElgatoCache.Keys # The keys of the device cache become the -IPAddress.
            }
            elseif ($script:ElgatoCache.Count) {
                $IPAddress = $script:ElgatoCache.Keys # The keys of the device cache become the -IPAddress.
            }
            if (-not $IPAddress) {
                # If we still have no -IPAddress                
                return #  return.
            }
        }
        #endregion Default to All Devices
        
        
        # Reference to API: https://github.com/adamesch/elgato-key-light-api/tree/master/resources/lights
        foreach ($ip in $ipAddress) {
            $refreshDevice = $false
            $invokeSplat = @{Uri = "http://$($ip):9123/elgato/lights"; Method = 'Put' }
            $restOutputs = @(
                if ($paramCopy.ContainsKey("Brightness")) {
                    $realBrightness = [Math]::Ceiling($Brightness * 100)
                    $invokeSplat.Body = (
                        @{
                            "lights" = @(
                                @{
                                    Brightness = [int]$realBrightness
                                }
                            )
                        } | ConvertTo-Json -Compress)
                    if ($whatIfPreference) {
                        $invokeSplat
                    }
                    elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Body)")) {
                        Invoke-RestMethod @invokeSplat
                    }                    
                    $refreshDevice = $true
                }

                if ($paramCopy.ContainsKey("ColorTemperature")) {
                    $invokeSplat.Body = (
                        @{
                            "lights" = @(
                                @{
                                    temperature = $ColorTemperature
                                }
                            )
                        } | ConvertTo-Json -Compress)                    
                    if ($whatIfPreference) {
                        $invokeSplat
                    }
                    elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Body)")) {
                        Invoke-RestMethod @invokeSplat
                    }
                }

                if ($On -and -not $Off) {
                    $invokeSplat.Body = (
                        @{
                            "lights" = @(
                                @{
                                    on = 1
                                }
                            )
                        } | ConvertTo-Json -Compress)
                    if ($whatIfPreference) {
                        $invokeSplat
                    }
                    elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Body)")) {
                        Invoke-RestMethod @invokeSplat
                    }
                }

                if ($off) {
                    $invokeSplat.Body = (@{
                            "lights" = @(
                                @{
                                    on = 0
                                }
                            )
                        } | ConvertTo-Json -Compress)
                    if ($whatIfPreference) {
                        $invokeSplat
                    }
                    elseif ($psCmdlet.ShouldProcess("$($invokeSplat.Body)")) {
                        Invoke-RestMethod @invokeSplat
                    }
                }
            )

            if ($restOutputs -and $whatIfPreference) {
                $restOutputs
            }

            if ($refreshDevice -and -not ($restOutputs | Where-Object error_code -gt 0) -and -not $whatIfPreference) {
                Connect-Elgato -IPAddress $IP
            }
        }
    }
}
