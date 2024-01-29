function Disconnect-Pixoo
{
    <#
    .Synopsis
        Disconnects a Pixoo
    .Description
        Disconnects a Pixoo, removing stored device info
    .Example
        Disconnect-Pixoo 1.2.3.4
    .Link
        Connect-Pixoo
    #>
    [OutputType([Nullable], [PSObject])]
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='High')]
    param(
    # The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.
    [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
    [Alias('PixooIPAddress')]
    [IPAddress]
    $IPAddress
    )

    begin {
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        @(Get-ChildItem -Filter *.pixoo.clixml -Path $lightScriptRoot) |
            Foreach-Object {
                $file = $_
                $fileInfo = Import-Clixml -LiteralPath $file.FullName
                if ($fileInfo.IPAddress -eq $IPAddress -and $PSCmdlet.ShouldProcess("Remove $($fileInfo.MACAddress)")) {
                    Remove-Item -LiteralPath $file.FullName -Force
                }
            }
    }
}

