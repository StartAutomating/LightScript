function Get-Elgato {
    <#
    .Synopsis
        Gets Elgato Lighting Devices
    .Description
        Gets saved Elgato Lighting Devices
    .Example
        Get-Elgato
    .LINK
        Connect-Elgato
    .LINK
        Set-Elgato
    #>
    [CmdletBinding(DefaultParameterSetName = "ListDevices")]
    param(
        # The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('ElgatoIPAddress')]
        [IPAddress[]]
        $IPAddress
    )

    begin {
        if (-not $script:ElgatoCache) {
            $script:ElgatoCache = @{}
        }
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }
    
    process {
        #region Default to All Devices
        if (-not $IPAddress) {
            # If no -IPAddress was passed
            if ($home) {
                # Read all .twinkly.clixml files beneath your LightScript directory.
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.elgato.clixml -Force |
                Import-Clixml |
                ForEach-Object {
                    if (-not $_) { return }
                    $ElgatoConnection = $_                        
                    $script:ElgatoCache["$($ElgatoConnection.IPAddress)"] = $ElgatoConnection
                }

                $IPAddress = $script:ElgatoCache.Keys # The keys of the device cache become the -IPAddress.
            }
            if (-not $IPAddress) {
                # If we still have no -IPAddress                
                return #  return.
            }
        }
        #endregion Default to All Devices

        if ($PSCmdlet.ParameterSetName -eq 'ListDevices') {
            return $script:ElgatoCache.Values
        }
    }
}
