function Disconnect-WLED {
    <#
    .Synopsis
        Disconnects a WLED device
    .Description
        Disconnects a WLED device, removing stored device info
    .Example
        Disconnect-WLED 192.168.1.100
    .Link
        Connect-WLED
    #>
    [OutputType([Nullable], [PSObject])]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        # The IP Address for the WLED device.
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('WLEDIPAddress')]
        [IPAddress]
        $IPAddress
    )

    begin {
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        @(Get-ChildItem -Filter *.wled.clixml -Path $lightScriptRoot -ErrorAction SilentlyContinue) |
            ForEach-Object {
                $file = $_
                $fileInfo = Import-Clixml -LiteralPath $file.FullName
                if ("$($fileInfo.IPAddress)" -eq "$IPAddress" -and $PSCmdlet.ShouldProcess("Remove WLED device '$($fileInfo.Name)' ($($fileInfo.IPAddress))")) {
                    Remove-Item -LiteralPath $file.FullName -Force
                    if ($script:WLEDCache) {
                        $script:WLEDCache.Remove("$IPAddress")
                    }
                }
            }
    }
}
