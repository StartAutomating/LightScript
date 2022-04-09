function Set-KeyLight {
    <#
    .Synopsis
        Sets Elgato Key Lighting
    .Description
        Changes Elgato Key Lighting
    .Example
        Set-KeyLight -Brightness .5
    .LINK
        Get-KeyLight
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        # One or more IP Addresses of Elgato Key Lighting devices.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('KeyLightIPAddress')]
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

        # If set, will turn the light on.
        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]
        $On,

        # If set, will turn the light on.
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
        if (-not $script:KeyLightCache) {
            $script:KeyLightCache = @{}
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
            if ($home -and -not $script:KeyLightCache.Count) {
                # Read all .keylight.clixml files beneath your LightScript directory.
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.keylight.clixml -Force |
                Import-Clixml |
                ForEach-Object {
                    if (-not $_) { return }
                    $KeyLightConnection = $_                        
                    $script:KeyLightCache["$($KeyLightConnection.IPAddress)"] = $KeyLightConnection
                }

                $IPAddress = $script:KeyLightCache.Keys # The keys of the device cache become the -IPAddress.
            }
            elseif ($script:KeyLightCache.Count) {
                $IPAddress = $script:KeyLightCache.Keys # The keys of the device cache become the -IPAddress.
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
