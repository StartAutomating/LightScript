function Connect-KeyLight {
    <#
    .Synopsis
        Connects to a Elgato Key Lighting
    .Description
        Connects to a Elgato Key Lighting over Wifi
    .Example
        Connect-KeyLight 1.2.3.4 -PassThru
    .Link
        Get-KeyLight
    #>
    [OutputType([Nullable], [PSObject])]
    param(
        # The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('KeyLightIPAddress')]
        [IPAddress]
        $IPAddress,

        # If set, will output the connection information.
        [switch]
        $PassThru
    )

    begin {
        $PSDefaultParameterValues = @{
            "Invoke-RestMethod:ContentType" = "application/json"
        }
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        #region Attempt to Contact the Device
        $keyLightConf = Invoke-RestMethod -Method Get -Uri "http://$($IpAddress):9123/elgato/accessory-info"
        #endregion Attempt to Contact the Device


        if ($keyLightConf) {
            $macAddress =
            if ($PSVersionTable.Platform -like 'Win*' -or -not $PSVersionTable.Platform) {
                Get-NetNeighbor | Where-Object IPAddress -eq $IPAddress | Select-Object -ExpandProperty LinkLayerAddress
            }
            elseif ($ExecutionContext.SessionState.InvokeCommand.GetCommand('nmap', 'Application')) {
                nmap -Pn "$ipAddress" | 
                Where-Object { $_ -like 'MAC Address:*' } |
                ForEach-Object { @($_ -split ' ')[2] }
            }

            if (-not $macAddress) {
                Write-Error "Unable to resolve MAC address for $IpAddress, will not save connection"
                return
            }
            #region Save Device Information
            if ($home) {
                if (-not (Test-Path $lightScriptRoot)) {
                    $createLightScriptDir = New-Item -ItemType Directory -Path $lightScriptRoot
                    if (-not $createLightScriptDir) { return }
                }

                $keyLightLightsConf = Invoke-RestMethod -Method Get -Uri "http://$($IpAddress):9123/elgato/lights"
                $keyLightSettingsConf = Invoke-RestMethod -Method Get -Uri "http://$($IpAddress):9123/elgato/lights/settings" |
                Select-Object powerOnBehavior, powerOnBrightness, powerOnTemperature
                $keyLightDataFile = Join-Path $lightScriptRoot ".$($macAddress).keylight.clixml"
                $keyLightConf.pstypenames.clear()
                $keyLightConf.pstypenames.add('KeyLight')
                $keyLightConf |
                Add-Member NoteProperty IPAddress $IPAddress -Force -PassThru |
                Add-Member NoteProperty MACAddress $macAddress -Force -PassThru |
                Add-Member NoteProperty Lights $keyLightLightsConf.lights -Force -PassThru |
                Add-Member NoteProperty Lights $keyLightSettingsConf -Force -PassThru |
                Export-Clixml -Path $keyLightDataFile
            }
            #endregion Save Device Information
            if ($PassThru) {
                $keyLightConf
            }
        }
    }
}
