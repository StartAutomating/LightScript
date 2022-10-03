function Get-Pixoo
{
    <#
    .Synopsis
        Gets Pixoo Devices
    .Description
        Gets saved Pixoo Devices
    .Example
        Get-Pixoo
    .LINK
        Connect-Pixoo
    .LINK
        Set-Pixoo
    #>
    [CmdletBinding(DefaultParameterSetName="ListDevices")]
    param(
    # The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('PixooIPAddress')]
    [IPAddress[]]
    $IPAddress
    )

    begin {
        if (-not $script:PixooCache) {
            $script:PixooCache = @{}
        }
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }
    
    process {
        #region Default to All Devices
        if (-not $IPAddress) { # If no -IPAddress was passed
            if ($home) {
                # Read all .twinkly.clixml files beneath your LightScript directory.
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.pixoo.clixml -Force |
                    Import-Clixml |
                    ForEach-Object {
                        if (-not $_) { return }
                        $pixooConnection = $_                        
                        $script:PixooCache["$($pixooConnection.IPAddress)"] = $pixooConnection
                    }

                $IPAddress = $script:PixooCache.Keys # The keys of the device cache become the -IPAddress.
            }
            if (-not $IPAddress) { # If we still have no -IPAddress                
                return #  return.
            }
        }
        #endregion Default to All Devices

        if ($PSCmdlet.ParameterSetName -eq 'ListDevices') {
            return $script:PixooCache.Values
        }
    }
}
