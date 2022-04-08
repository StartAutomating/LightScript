function Disconnect-KeyLight {
    <#
    .Synopsis
        Disconnects a Elgato Key Lighting
    .Description
        Disconnects a Elgato Key Lighting, removing stored device info
    .Example
        Disconnect-KeyLight 1.2.3.4
    .Link
        Connect-KeyLight
    #>
    [OutputType([Nullable], [PSObject])]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        # The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('KeyLightIPAddress')]
        [IPAddress]
        $IPAddress
    )

    begin {
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        @(Get-ChildItem -Filter *.keylight.clixml -Path $lightScriptRoot) |
        Foreach-Object {
            $file = $_
            $fileInfo = Import-Clixml -LiteralPath $file.FullName
            if ($fileInfo.IPAddress -eq $IPAddress -and $PSCmdlet.ShouldProcess("Remove $($fileInfo.serialNumber)")) {
                Remove-Item -LiteralPath $file.FullName -Force
            }
        }
    }
}

