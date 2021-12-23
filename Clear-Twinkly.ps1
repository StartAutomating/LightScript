function Clear-Twinkly
{
    <#
    .Synopsis
        Clears Twinkly devices
    .Description
        The Twinkly API does not allow for the deletion of specific storage items, and is limited to 16 movies.

        This clears the stored movies and playlists
    .Example
        Clear-Twinkly
    .Link
        Get-Twinkly
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([Nullable], [PSObject])]
    param(
    # One or more IP Addresses of Twinkly devices.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('TwinklyIPAddress')]
    [IPAddress[]]
    $IPAddress
    )

    begin {
        if (-not $script:TwinklyCache) {
            $script:TwinklyCache = @{}
        }
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        #region Discover Twinklys
        if (-not $IPAddress) {
            if ($home) {
                Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.twinkly.clixml -Force |
                    Import-Clixml |
                    ForEach-Object {
                        if (-not $_) { return }
                        $twinklyConnection = $_
                        if ([DateTime]::Now -ge $twinklyConnection.Authentication_ExpiresAt) {
                            $twinklyConnection = Connect-Twinkly -IPAddress $twinklyConnection.IPAddress -PassThru
                        }
                        $script:TwinklyCache["$($twinklyConnection.IPAddress)"] = $twinklyConnection
                    }

                $IPAddress = $script:TwinklyCache.Keys
            }
            if (-not $IPAddress) {
                Write-Warning "No -IPAddress provided and no cached devices found"
                return
            }
        }
        #region Discover Twinklys

        #region Clear Twinklys
        foreach ($ip in $IPAddress) {
            $Splat = @{
                Headers= @{"X-Auth-Token" =$script:TwinklyCache["$ip"].Authentication_Token}
                Method = 'DELETE'
            }
            if ($PSCmdlet.ShouldProcess("Clear Twinkly Device @ $ip")) {
                Invoke-RestMethod -Uri "http://$ip/xled/v1/playlist" @Splat
                Invoke-RestMethod -Uri "http://$ip/xled/v1/movies" @Splat
            }
        }
        #endregion Clear Twinklys
    }
}
