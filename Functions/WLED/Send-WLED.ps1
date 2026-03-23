function Send-WLED {
    <#
    .Synopsis
        Sends messages to a WLED device
    .Description
        Sends HTTP messages to a WLED device's JSON API
    .Example
        Send-WLED -IPAddress 192.168.1.100 -Command "state" -Method POST -Data @{on=$true}
    .Example
        Send-WLED -IPAddress 192.168.1.100 -Command "info"
    .Link
        Get-WLED
    .Link
        Set-WLED
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    [OutputType([PSObject])]
    param(
        # The IP Address of the WLED device.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('WLEDIPAddress')]
        [IPAddress]
        $IPAddress,

        # The URI fragment to send to the WLED device (e.g., "state", "info", "eff", "pal").
        [string]
        $Command,

        # The HTTP method to send.
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]
        $Method = 'GET',

        # The data to send.  This will be converted into JSON if it is not a string.
        [Parameter(ValueFromPipelineByPropertyName)]
        [PSObject]
        $Data,

        # The typename of the results.
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]]
        $PSTypeName
    )

    process {
        #region Handle Broadcasting Recursively
        if ($IPAddress -in [IPAddress]::Any, [IPAddress]::Broadcast) {
            $splat = @{} + $PSBoundParameters
            $splat.Remove('IPAddress')
            foreach ($val in $script:WLEDCache.Values) {
                $splat['IPAddress'] = $val.IPAddress
                Send-WLED @splat
            }
            return
        }
        #endregion Handle Broadcasting Recursively

        $uri = "http://$IPAddress/json"
        if ($Command) {
            $uri = "http://$IPAddress/json/$Command"
        }

        $splat = @{
            Uri    = $uri
            Method = $Method
        }

        if ($Data) {
            if ($Data -is [string]) {
                $splat.Body = $Data
            } else {
                $splat.Body = ConvertTo-Json -Compress -Depth 10 -InputObject $Data
            }
            $splat.ContentType = 'application/json'
        }

        if ($WhatIfPreference) {
            return $splat
        }

        if (-not $PSCmdlet.ShouldProcess("$($splat.Method) $($splat.Uri)")) { return }

        Invoke-RestMethod @splat 2>&1 |
            ForEach-Object {
                $in = $_
                if (-not $in -or $in -eq 'null') { return }
                if ($PSTypeName -and $in -isnot [Management.Automation.ErrorRecord]) {
                    $in.PSTypeNames.Clear()
                    foreach ($t in $PSTypeName) {
                        $in.PSTypeNames.Add($t)
                    }
                }
                $in |
                    Add-Member NoteProperty IPAddress $IPAddress -Force -PassThru
            }
    }
}
