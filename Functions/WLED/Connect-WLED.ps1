function Connect-WLED {
    <#
    .Synopsis
        Connects to a WLED device
    .Description
        Connects to a WLED device over WiFi and saves connection information.
        WLED is open-source firmware for ESP8266/ESP32 LED controllers with a JSON API.
    .Example
        Connect-WLED 192.168.1.100 -PassThru
    .Link
        Get-WLED
    .Link
        Disconnect-WLED
    #>
    [OutputType([Nullable], [PSObject])]
    param(
        # The IP Address for the WLED device.
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('WLEDIPAddress')]
        [IPAddress]
        $IPAddress,

        # If set, will output the connection information.
        [switch]
        $PassThru
    )

    begin {
        if (-not $script:WLEDCache) {
            $script:WLEDCache = @{}
        }
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        #region Attempt to Contact the Device
        $wledData = Invoke-RestMethod -Uri "http://$IPAddress/json"
        #endregion Attempt to Contact the Device

        if ($wledData) {
            $macAddress =
                if ($wledData.info.mac) {
                    $wledData.info.mac
                }
                elseif ($PSVersionTable.Platform -like 'Win*' -or -not $PSVersionTable.Platform) {
                    Get-NetNeighbor | Where-Object IPAddress -eq $IPAddress | Select-Object -ExpandProperty LinkLayerAddress
                }
                elseif ($ExecutionContext.SessionState.InvokeCommand.GetCommand('nmap', 'Application')) {
                    nmap -Pn "$IPAddress" |
                        Where-Object { $_ -like 'MAC Address:*' } |
                        ForEach-Object { @($_ -split ' ')[2] }
                }

            if (-not $macAddress) {
                Write-Error "Unable to resolve MAC address for $IPAddress, will not save connection"
                return
            }

            #region Save Device Information
            if ($home) {
                if (-not (Test-Path $lightScriptRoot)) {
                    $createLightScriptDir = New-Item -ItemType Directory -Path $lightScriptRoot
                    if (-not $createLightScriptDir) { return }
                }

                $mainSeg = $wledData.state.seg | Select-Object -First 1
                $wledData.pstypenames.clear()
                $wledData.pstypenames.add('WLED')
                $wledData |
                    Add-Member NoteProperty IPAddress $IPAddress -Force -PassThru |
                    Add-Member NoteProperty MACAddress $macAddress -Force -PassThru |
                    Add-Member NoteProperty Name $wledData.info.name -Force -PassThru |
                    Add-Member NoteProperty Version $wledData.info.ver -Force -PassThru |
                    Add-Member NoteProperty LEDCount $wledData.info.leds.count -Force -PassThru |
                    Add-Member NoteProperty On $wledData.state.on -Force -PassThru |
                    Add-Member NoteProperty Brightness $wledData.state.bri -Force -PassThru |
                    Add-Member NoteProperty CurrentEffect $(
                        if ($wledData.effects -and $mainSeg) { $wledData.effects[$mainSeg.fx] }
                    ) -Force -PassThru |
                    Add-Member NoteProperty CurrentPalette $(
                        if ($wledData.palettes -and $mainSeg) { $wledData.palettes[$mainSeg.pal] }
                    ) -Force -PassThru |
                    Export-Clixml -Path (Join-Path $lightScriptRoot ".$macAddress.wled.clixml")

                $script:WLEDCache["$IPAddress"] = $wledData
            }
            #endregion Save Device Information

            if ($PassThru) {
                $wledData
            }
        }
    }
}
