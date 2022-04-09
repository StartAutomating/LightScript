function Get-KeyLight {
    <#
    .Synopsis
        Gets Elgato Key Lighting Devices
    .Description
        Gets saved Elgato Key Lighting Devices
    .Example
        Get-KeyLight
    .LINK
        Connect-KeyLight
    .LINK
        Set-KeyLight
    #>
    [CmdletBinding(DefaultParameterSetName = "ListDevices")]
    param(
        # The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('KeyLightIPAddress')]
        [IPAddress[]]
        $IPAddress
    )

    begin {
        if (-not $script:KeyLightCache) {
            $script:KeyLightCache = @{}
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
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.keylight.clixml -Force |
                Import-Clixml |
                ForEach-Object {
                    if (-not $_) { return }
                    $KeyLightConnection = $_                        
                    $script:KeyLightCache["$($KeyLightConnection.IPAddress)"] = $KeyLightConnection
                }

                $IPAddress = $script:KeyLightCache.Keys # The keys of the device cache become the -IPAddress.
            }
            if (-not $IPAddress) {
                # If we still have no -IPAddress                
                return #  return.
            }
        }
        #endregion Default to All Devices

        if ($PSCmdlet.ParameterSetName -eq 'ListDevices') {
            return $script:KeyLightCache.Values
        }
    }
}
