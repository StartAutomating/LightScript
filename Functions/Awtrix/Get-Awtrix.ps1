function Get-Awtrix
{
    <#
    .Synopsis
        Gets Awtrix Devices
    .Description
        Gets saved Awtrix Devices
    .Example
        Get-Awtrix
    .LINK
        Connect-Awtrix
    .LINK
        Set-Awtrix
    #>
    [CmdletBinding(DefaultParameterSetName="ListDevices")]
    param(
    # The IP Address for the Awtrix device.
    # This can be discovered thru the phone user interface or by using Find-Awtrix.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('AwtrixIPAddress')]
    [IPAddress[]]
    $IPAddress,

    [Parameter(ParameterSetName='ListEffectName',ValueFromPipelineByPropertyName)]
    [Alias('ListEffectNames')]
    [switch]
    $ListEffectName,
    
    # If set, will clear any cached results.
    [switch]
    $Force
    )

    begin {
        if (-not $script:AwtrixCache) {
            $script:AwtrixCache = @{}
        }

        if (-not $script:AwtrixDataCache -or $force) {
            $script:AwtrixDataCache = @{}
        }
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }
    
    process {
        #region Default to All Devices
        if (-not $IPAddress) { # If no -IPAddress was passed
            if ($home) {
                # Read all .Awtrix.clixml files beneath your LightScript directory.
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.awtrix.clixml -Force |
                    Import-Clixml |
                    ForEach-Object {
                        if (-not $_) { return }
                        $AwtrixConnection = $_                        
                        $script:AwtrixCache["$($AwtrixConnection.IPAddress)"] = $AwtrixConnection
                    }

                $IPAddress = $script:AwtrixCache.Keys # The keys of the device cache become the -IPAddress.
            }
            if (-not $IPAddress) { # If we still have no -IPAddress                
                return #  return.
            }
        }
        #endregion Default to All Devices

        if ($PSCmdlet.ParameterSetName -eq 'ListDevices') {
            return $script:AwtrixCache.Values
        }

        foreach ($ipAddr in $script:AwtrixCache.Keys) {
            switch ($PSCmdlet.ParameterSetName) {
                ListEffectName {
                    Invoke-RestMethod "http://$ipAddr/api/effects"
                }
            }
        }
        
    }
}
