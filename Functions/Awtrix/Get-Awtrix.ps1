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

    # If set, will list the effects supported by the Awtrix device. 
    [Parameter(ParameterSetName='api/effects',ValueFromPipelineByPropertyName)]
    [Alias('ListEffectNames')]
    [switch]
    $ListEffectName,

    # If set, will output the application loop on the Awtrix device. 
    [Parameter(ParameterSetName='api/loop',ValueFromPipelineByPropertyName)]
    [Alias('AppLoop')]
    [switch]
    $ApplicationLoop,
    
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
            foreach ($restOut in Invoke-RestMethod "http://$ipAddr/$($PSCmdlet.ParameterSetName)") {
                $restOut.pstypenames.clear()
                $restOut.pstypenames.add(($PSCmdlet.ParameterSetName -replace '/','.' -replace '$api', 'Awtrix'))
                $restOut
            }
        }
        
    }
}
