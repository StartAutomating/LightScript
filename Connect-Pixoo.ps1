function Connect-Pixoo
{
    <#
    .Synopsis
        Connects to a Pixoo
    .Description
        Connects to a Pixoo over Wifi
    .Example
        Connect-Pixoo 1.2.3.4 -PassThru
    .Link
        Get-Pixoo
    #>
    [OutputType([Nullable], [PSObject])]
    param(
    # The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.
    [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
    [Alias('PixooIPAddress')]
    [IPAddress]
    $IPAddress,

    # If set, will output the connection information.
    [switch]
    $PassThru
    )

    begin {
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        #region Attempt to Contact the Device
        $pixooConf = Invoke-RestMethod -Uri "http://$IPAddress/post" -Method POST -Body (
            @{
                Command="Channel/GetAllConf"
            } | ConvertTo-Json
        )
        #endregion Attempt to Contact the Device


        if ($pixooConf) {
            $macAddress =
                if ($PSVersionTable.Platform -like 'Win*' -or -not $PSVersionTable.Platform) {
                    Get-NetNeighbor | Where-Object IPAddress -eq $IPAddress | Select-Object -ExpandProperty LinkLayerAddress
                } elseif ($ExecutionContext.SessionState.InvokeCommand.GetCommand('nmap','Application')) {
                    nmap -Pn "$ipAddress" | 
                        Where-Object { $_ -like 'MAC Address:*'} |
                         ForEach-Object { @($_ -split ' ')[2] }
                }

            if (-not $macAddress) {
                Write-Error "Unable to resolve MAC address for $ipAddress, will not save connection"
                return
            }
            #region Save Device Information
            if ($home) {
                if (-not (Test-Path $lightScriptRoot)) {
                    $createLightScriptDir = New-Item -ItemType Directory -Path $lightScriptRoot
                    if (-not $createLightScriptDir) { return }
                }


                $pixooDataFile = Join-Path $lightScriptRoot ".$($macAddress).pixoo.clixml"
                $pixooConf.pstypenames.clear()
                $pixooConf.pstypenames.add('Pixoo')
                $pixooConf |
                    Add-Member NoteProperty IPAddress $IPAddress -Force -PassThru |
                    Add-Member NoteProperty MACAddress $macAddress -Force -PassThru |
                    Export-Clixml -Path $pixooDataFile
            }
            #endregion Save Device Information
            if ($PassThru) {
                $pixooConf
            }
        }
    }
}
