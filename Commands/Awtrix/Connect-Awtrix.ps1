function Connect-Awtrix
{
    <#
    .Synopsis
        Connects to a Awtrix light controller.
    .Description
        Connects to a Awtrix light controller
    .Example
        Connect-Awtrix 192.168.0.160 -PassThru
    .Link
        Get-Awtrix
    #>
    [OutputType([Nullable], [PSObject])]
    param(
    # The IP Address for the Awtrix device.
    # Once you flash the device, this should be displayed on boot and accessible in the web interface.
    [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
    [Alias('AwtrixIPAddress')]
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
        #region Get the device stats
        $AwtrixStats = Invoke-RestMethod -Uri "http://$IPAddress/api/stats"
        #endregion 


        if (-not $AwtrixStats) { return }
        $AwtrixStats.pstypenames.insert(0, 'Awtrix.Info')
        $AwtrixDeviceInfo = $AwtrixStats |
            Add-Member NoteProperty IPAddress $IPAddress -Force -PassThru

        #region Save Device Information
        if ($home -and $AwtrixDeviceInfo) {
            if (-not (Test-Path $lightScriptRoot)) {
                $createLightScriptDir = New-Item -ItemType Directory -Path $lightScriptRoot
                if (-not $createLightScriptDir) { return }
            }

            $AwtrixDataFile = Join-Path $lightScriptRoot ".$($AwtrixDeviceInfo.uid).awtrix.clixml"

            $AwtrixDeviceInfo |
                Export-Clixml -Path $AwtrixDataFile
        }
        #endregion Save Device Information
        if ($PassThru) {
            $AwtrixDeviceInfo
        }
    
    }
}
