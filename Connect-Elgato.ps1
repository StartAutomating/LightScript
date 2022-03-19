function Connect-Elgato {
    <#
    .Synopsis
        Connects to a Elgato Lighting
    .Description
        Connects to a Elgato Lighting over Wifi
    .Example
        Connect-Elgato 1.2.3.4 -PassThru
    .Link
        Get-Elgato
    #>
    [OutputType([Nullable], [PSObject])]
    param(
        # The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('ElgatoIPAddress')]
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
        $elgatoConf = Invoke-RestMethod -Method Get -Uri "http://$($IpAddress):9123/elgato/accessory-info"
        #endregion Attempt to Contact the Device


        if ($elgatoConf) {
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

                $elgatoLightsConf = Invoke-RestMethod -Method Get -Uri "http://$($IpAddress):9123/elgato/lights"
                $elgatoSettingsConf = Invoke-RestMethod -Method Get -Uri "http://$($IpAddress):9123/elgato/lights/settings" |
                Select-Object powerOnBehavior, powerOnBrightness, powerOnTemperature
                $elgatoDataFile = Join-Path $lightScriptRoot ".$($macAddress).elgato.clixml"
                $elgatoConf.pstypenames.clear()
                $elgatoConf.pstypenames.add('Elgato')
                $elgatoConf |
                Add-Member NoteProperty IPAddress $IPAddress -Force -PassThru |
                Add-Member NoteProperty MACAddress $macAddress -Force -PassThru |
                Add-Member NoteProperty Lights $elgatoLightsConf.lights -Force -PassThru |
                Add-Member NoteProperty Lights $elgatoSettingsConf -Force -PassThru |
                Export-Clixml -Path $elgatoDataFile
            }
            #endregion Save Device Information
            if ($PassThru) {
                $elgatoConf
            }
        }
    }
}
