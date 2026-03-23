function Set-WLED {
    <#
    .Synopsis
        Sets WLED device state
    .Description
        Changes state on one or more WLED devices.
    .Example
        Set-WLED -On
    .Example
        Set-WLED -Brightness .5
    .Example
        Set-WLED -RGBColor "#FF0000"
    .Example
        Set-WLED -EffectName "Rainbow" -EffectSpeed 128
    .Example
        Set-WLED -PaletteName "Ocean" -EffectName "Colorwaves"
    .Example
        Set-WLED -SegmentId 1 -RGBColor "#00FF00" -Brightness .8
    .Example
        Set-WLED -Preset 1
    .Link
        Get-WLED
    .Link
        Send-WLED
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "", Justification = "Handled in process block")]
    param(
        # One or more IP Addresses of WLED devices.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('WLEDIPAddress')]
        [IPAddress[]]
        $IPAddress,

        # If set, will turn the light on.
        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]
        $On,

        # If set, will turn the light off.
        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]
        $Off,

        # The brightness of the light (0 to 1).
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(0, 1)]
        [Alias('Luminance', 'B')]
        [double]
        $Brightness,

        # The RGB color as a hex string (e.g., "#FF0000" for red).
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidatePattern('^#[\da-fA-F]{6}$')]
        [Alias('Color')]
        [string]
        $RGBColor,

        # The color temperature in Kelvin (1900-10091).
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(1900, 10091)]
        [Alias('CT', 'CCT', 'TemperatureKelvin')]
        [int]
        $ColorTemperature,

        # The transition time for this change.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Timespan]
        $Transition,

        # The name or ID of the effect.
        [ArgumentCompleter({
            param ($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
            $effects = @(
                foreach ($device in $script:WLEDCache.Values) {
                    if ($device.effects) { $device.effects }
                }
            ) | Select-Object -Unique
            if ($wordToComplete) {
                $toComplete = $wordToComplete -replace "^'" -replace "'$"
                @($effects -like "$toComplete*" -replace '^', "'" -replace '$', "'")
            } else {
                @($effects -replace '^', "'" -replace '$', "'")
            }
        })]
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('Effect', 'FX')]
        [string]
        $EffectName,

        # The effect speed (0 to 255).
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(0, 255)]
        [Alias('Speed', 'SX')]
        [int]
        $EffectSpeed,

        # The effect intensity (0 to 255).
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(0, 255)]
        [Alias('Intensity', 'IX')]
        [int]
        $EffectIntensity,

        # The name or ID of the color palette.
        [ArgumentCompleter({
            param ($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
            $palettes = @(
                foreach ($device in $script:WLEDCache.Values) {
                    if ($device.palettes) { $device.palettes }
                }
            ) | Select-Object -Unique
            if ($wordToComplete) {
                $toComplete = $wordToComplete -replace "^'" -replace "'$"
                @($palettes -like "$toComplete*" -replace '^', "'" -replace '$', "'")
            } else {
                @($palettes -replace '^', "'" -replace '$', "'")
            }
        })]
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('Palette')]
        [string]
        $PaletteName,

        # The preset ID to load (-1 to 250).
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(-1, 250)]
        [int]
        $Preset,

        # The segment ID to target.  Defaults to the main segment (0).
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('Segment')]
        [int]
        $SegmentId = 0
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
        $paramCopy = @{} + $PSBoundParameters

        #region Default to All Devices
        if (-not $IPAddress) {
            if ($home -and -not $script:WLEDCache.Count) {
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.wled.clixml -Force |
                    Import-Clixml |
                    ForEach-Object {
                        if (-not $_) { return }
                        $script:WLEDCache["$($_.IPAddress)"] = $_
                    }
                $IPAddress = $script:WLEDCache.Keys
            }
            elseif ($script:WLEDCache.Count) {
                $IPAddress = $script:WLEDCache.Keys
            }
            if (-not $IPAddress) { return }
        }
        #endregion Default to All Devices

        foreach ($ip in $IPAddress) {
            $stateData = [Ordered]@{}
            $segData = [Ordered]@{ id = $SegmentId }
            $hasSegData = $false

            #region Power
            if ($On -and -not $Off) {
                $stateData['on'] = $true
            }
            if ($Off) {
                $stateData['on'] = $false
            }
            #endregion Power

            #region Brightness
            if ($paramCopy.ContainsKey('Brightness')) {
                $stateData['bri'] = [int][Math]::Round($Brightness * 255)
            }
            #endregion Brightness

            #region Transition
            if ($paramCopy.ContainsKey('Transition')) {
                $stateData['tt'] = [int][Math]::Round($Transition.TotalMilliseconds / 100)
            }
            #endregion Transition

            #region Preset
            if ($paramCopy.ContainsKey('Preset')) {
                $stateData['ps'] = $Preset
            }
            #endregion Preset

            #region RGB Color
            if ($RGBColor) {
                $hexColor = $RGBColor -replace '^#'
                $r = [Convert]::ToInt32($hexColor.Substring(0, 2), 16)
                $g = [Convert]::ToInt32($hexColor.Substring(2, 2), 16)
                $b = [Convert]::ToInt32($hexColor.Substring(4, 2), 16)
                $segData['col'] = @(, @($r, $g, $b))
                $hasSegData = $true
            }
            #endregion RGB Color

            #region Color Temperature
            if ($paramCopy.ContainsKey('ColorTemperature')) {
                $segData['cct'] = $ColorTemperature
                $hasSegData = $true
            }
            #endregion Color Temperature

            #region Effect
            if ($EffectName) {
                if ($EffectName -match '^\d+$') {
                    $segData['fx'] = [int]$EffectName
                }
                elseif ($EffectName -in '~', '~-', 'r') {
                    $segData['fx'] = $EffectName
                }
                else {
                    $cachedDevice = $script:WLEDCache["$ip"]
                    if ($cachedDevice -and $cachedDevice.effects) {
                        $effectId = $null
                        for ($i = 0; $i -lt $cachedDevice.effects.Count; $i++) {
                            if ($cachedDevice.effects[$i] -eq $EffectName) {
                                $effectId = $i
                                break
                            }
                        }
                        if ($null -eq $effectId) {
                            Write-Error "Effect '$EffectName' not found on WLED device $ip"
                            continue
                        }
                        $segData['fx'] = $effectId
                    } else {
                        Write-Error "No cached effect list for WLED device $ip. Run Get-WLED first."
                        continue
                    }
                }
                $hasSegData = $true
            }
            #endregion Effect

            #region Effect Speed and Intensity
            if ($paramCopy.ContainsKey('EffectSpeed')) {
                $segData['sx'] = $EffectSpeed
                $hasSegData = $true
            }
            if ($paramCopy.ContainsKey('EffectIntensity')) {
                $segData['ix'] = $EffectIntensity
                $hasSegData = $true
            }
            #endregion Effect Speed and Intensity

            #region Palette
            if ($PaletteName) {
                if ($PaletteName -match '^\d+$') {
                    $segData['pal'] = [int]$PaletteName
                }
                elseif ($PaletteName -in '~', '~-', 'r') {
                    $segData['pal'] = $PaletteName
                }
                else {
                    $cachedDevice = $script:WLEDCache["$ip"]
                    if ($cachedDevice -and $cachedDevice.palettes) {
                        $paletteId = $null
                        for ($i = 0; $i -lt $cachedDevice.palettes.Count; $i++) {
                            if ($cachedDevice.palettes[$i] -eq $PaletteName) {
                                $paletteId = $i
                                break
                            }
                        }
                        if ($null -eq $paletteId) {
                            Write-Error "Palette '$PaletteName' not found on WLED device $ip"
                            continue
                        }
                        $segData['pal'] = $paletteId
                    } else {
                        Write-Error "No cached palette list for WLED device $ip. Run Get-WLED first."
                        continue
                    }
                }
                $hasSegData = $true
            }
            #endregion Palette

            if ($hasSegData) {
                $stateData['seg'] = @($segData)
            }

            if ($stateData.Count) {
                $body = ConvertTo-Json $stateData -Compress -Depth 10
                if ($WhatIfPreference) {
                    [PSCustomObject]@{
                        Uri    = "http://$ip/json/state"
                        Method = 'POST'
                        Body   = $body
                    }
                }
                elseif ($PSCmdlet.ShouldProcess("WLED $ip", "$body")) {
                    $null = Invoke-RestMethod -Uri "http://$ip/json/state" -Method POST -Body $body -ContentType 'application/json'
                }
            }
        }
    }
}
