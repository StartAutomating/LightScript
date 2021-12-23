function Get-Twinkly
{
    <#
    .Synopsis
        Gets Twinkly
    .Description
        Gets Twinkly lights.
    .Example
        Get-Twinkly
    .Link
        Connect-Twinkly
    #>
    [CmdletBinding(PositionalBinding=$false,DefaultParameterSetName='ListDevices')]
    [OutputType([PSObject])]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSReviewUnusedParameter", "", Justification="Parameters used as hints for Parameter Sets")]
    param(
    # One or more IP Addresses of Twinkly devices.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('TwinklyIPAddress')]
    [IPAddress[]]
    $IPAddress,

    # If set, will get the operation mode
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/led/mode')]
    [switch]
    $OperationMode,

    # If set, will get the layout of the Twinkly lights.  This may take a bit.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/led/layout/full')]
    [switch]
    $Layout,

    # If set, will get the color displayed when the Twinkly lights are in color mode.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/led/color')]
    [Alias('CurrentColour')]
    [switch]
    $CurrentColor,

    # If set, will list the available effects.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/led/effects')]
    [Alias('ListEffects')]
    [switch]
    $ListEffect,

    # If set, will show the current effect.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/led/effects/current')]
    [switch]
    $CurrentEffect,

    # If set, will list the configuration of each LED.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/led/config')]
    [Alias('Config')]
    [switch]
    $Configuration,

    # If set, will output the brightness levels.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/led/out/brightness')]
    [switch]
    $Brightness,

    # If set, will output the saturation levels.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/led/out/saturation')]
    [switch]
    $Saturation,

    # If set, will output the list of movies.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/movies')]
    [switch]
    $ListMovie,

    # If set, will output the list of movies.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/movies/current')]
    [switch]
    $CurrentMovie,

    # If set, will output movie configuration.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/led/movie/config')]
    [switch]
    $MovieConfiguration,

    # If set, will output the playlists.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/playlist')]
    [Alias('Playlists')]
    [switch]
    $Playlist,

    # If set, will output the current playlist item.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/playlist/current')]
    [switch]
    $CurrentPlaylistItem,

    # If set, will output the MQTT configuration.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/mqtt/config')]
    [Alias('MQTTConfig')]
    [switch]
    $MQTTConfiguration,

    # If set, will output the summary.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/summary')]
    [switch]
    $Summary,

    # If set, will output the network status.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/network/status')]
    [switch]
    $NetworkStatus,

    # If set, will output the network status.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/fw/version')]
    [switch]
    $FirmwareVersion,

    # If set, will output timers associated with each device.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='/xled/v1/timer')]
    [switch]
    $Timer
    )

    begin {
        if (-not $script:TwinklyCache) {
            $script:TwinklyCache = @{}
        }
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }
    process {
        #region Default to All Devices
        if (-not $IPAddress) { # If no -IPAddress was passed
            if ($home) {
                # Read all .twinkly.clixml files beneath your LightScript directory.
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.twinkly.clixml -Force |
                    Import-Clixml |
                    ForEach-Object {
                        if (-not $_) { return }
                        $twinklyConnection = $_
                        # If the connection would have expired
                        if ([DateTime]::Now -ge $twinklyConnection.Authentication_ExpiresAt) { # then reconnect.
                            $twinklyConnection = Connect-Twinkly -IPAddress $twinklyConnection.IPAddress -PassThru
                        }
                        $script:TwinklyCache["$($twinklyConnection.IPAddress)"] = $twinklyConnection
                    }

                $IPAddress = $script:TwinklyCache.Keys # The keys of the device cache become the -IPAddress.
            }
            if (-not $IPAddress) { # If we still have no -IPAddress
                Write-Warning "No -IPAddress provided and no cached devices found" # warn
                return # and return.
            }
        }
        #endregion Default to All Devices

        if ($PSCmdlet.ParameterSetName -like '/*') {
            foreach ($ip in $IPAddress) {
                $uri = "http://$ip$($PSCmdlet.ParameterSetName)"
                if ($VerbosePreference -ne 'silentlyContinue') {
                    Write-Verbose "GET $uri"
                }

                Invoke-RestMethod -Uri $uri -Headers @{
                    "X-Auth-Token" = $script:TwinklyCache["$ip"].authentication_token
                } |
                    & { process {
                        $out = $_

                        $out.pstypenames.clear()
                        $out.pstypenames.add(($PSCmdlet.ParameterSetName -replace '/xled/v1/' -replace '/', '.'))
                        $out
                    } }
            }
        } elseif ($PSCmdlet.ParameterSetName -eq 'ListDevices') {
            $script:TwinklyCache.Values
        }
    }
}
