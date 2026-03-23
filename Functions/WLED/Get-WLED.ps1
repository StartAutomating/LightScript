function Get-WLED {
    <#
    .Synopsis
        Gets WLED devices
    .Description
        Gets saved WLED devices and their current state.
        Can also list available effects and palettes.
    .Example
        Get-WLED
    .Example
        Get-WLED -ListEffect
    .Example
        Get-WLED -ListPalette
    .Example
        Get-WLED -Force
    .Link
        Connect-WLED
    .Link
        Set-WLED
    #>
    [CmdletBinding(DefaultParameterSetName = 'ListDevices')]
    [OutputType([PSObject])]
    param(
        # The IP Address for the WLED device.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('WLEDIPAddress')]
        [IPAddress[]]
        $IPAddress,

        # If set, will list available effects.
        [Parameter(ParameterSetName = 'ListEffect')]
        [Alias('Effect', 'Effects')]
        [switch]
        $ListEffect,

        # If set, will list available palettes.
        [Parameter(ParameterSetName = 'ListPalette')]
        [Alias('Palette', 'Palettes')]
        [switch]
        $ListPalette,

        # If set, will refresh device state from the API.
        [switch]
        $Force
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
        #region Default to All Devices
        if (-not $IPAddress) {
            if ($home -and (-not $script:WLEDCache.Count -or $Force)) {
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.wled.clixml -Force |
                    Import-Clixml |
                    ForEach-Object {
                        if (-not $_) { return }
                        $script:WLEDCache["$($_.IPAddress)"] = $_
                    }
            }
            $IPAddress = $script:WLEDCache.Keys
            if (-not $IPAddress) { return }
        }
        #endregion Default to All Devices

        foreach ($ip in $IPAddress) {
            #region Refresh from Device
            if ($Force) {
                $wledData = $null
                $wledData = Invoke-RestMethod -Uri "http://$ip/json" -ErrorAction SilentlyContinue
                if ($wledData) {
                    $mainSeg = $wledData.state.seg | Select-Object -First 1
                    $wledData.pstypenames.clear()
                    $wledData.pstypenames.add('WLED')
                    $script:WLEDCache["$ip"] = $wledData |
                        Add-Member NoteProperty IPAddress ([IPAddress]"$ip") -Force -PassThru |
                        Add-Member NoteProperty MACAddress $wledData.info.mac -Force -PassThru |
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
                        ) -Force -PassThru
                } else {
                    Write-Warning "WLED device at $ip is not reachable"
                }
            }
            #endregion Refresh from Device

            $device = $script:WLEDCache["$ip"]
            if (-not $device) { continue }

            if ($ListEffect) {
                if ($device.effects) {
                    for ($i = 0; $i -lt $device.effects.Count; $i++) {
                        [PSCustomObject]@{
                            PSTypeName = 'WLED.Effect'
                            Id         = $i
                            Name       = $device.effects[$i]
                            IPAddress  = $device.IPAddress
                        }
                    }
                }
            }
            elseif ($ListPalette) {
                if ($device.palettes) {
                    for ($i = 0; $i -lt $device.palettes.Count; $i++) {
                        [PSCustomObject]@{
                            PSTypeName = 'WLED.Palette'
                            Id         = $i
                            Name       = $device.palettes[$i]
                            IPAddress  = $device.IPAddress
                        }
                    }
                }
            }
            else {
                $device
            }
        }
    }
}
