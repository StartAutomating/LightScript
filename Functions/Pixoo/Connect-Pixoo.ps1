function Connect-Pixoo
{
    <#
    .Synopsis
        Connects to a Pixoo
    .Description
        Connects to a Pixoo over Wifi
    .Example
        Find-Pixoo | Connect-Pixoo
    .Link
        Get-Pixoo
    #>
    [OutputType([Nullable], [PSObject])]
    param(
    # The IP Address for the Pixoo device.
    # This can be discovered using Find-Pixoo.
    [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
    [Alias('PixooIPAddress','DevicePrivateIP')]
    [IPAddress]
    $IPAddress,

    # If set, will output the connection information.
    [switch]
    $PassThru,

    # The DeviceID.  This can be provided by Find-Pixoo
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $DeviceId
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
                
                $pixooObject = [PSCustomObject]@{
                    PSTypeName = 'Pixoo'
                    IPAddress  = $IPAddress
                    MACAddress = $macAddress
                }                

                # If the -DeviceID was provided
                if ($DeviceId) {
                    # add it to the configuration data.
                    $pixooObject | Add-Member NoteProperty DeviceID $DeviceId -Force
                }
                $pixooObject |
                    Export-Clixml -Path $pixooDataFile
            }
            #endregion Save Device Information
            if ($PassThru) {
                $pixooConf
            }
        }
    }
}
