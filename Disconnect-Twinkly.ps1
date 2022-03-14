function Disconnect-Twinkly
{
    <#
    .Synopsis
        Disconnects a Twinkly light controller.
    .Description
        Disconnects a Twinkly light controller
    .Example
        Disconnect-Twinkly 192.168.0.144
    .Link
        Connect-Twinkly
    #>
    [OutputType([Nullable], [PSObject])]
    param(
    # The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.
    [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
    [Alias('TwinklyIPAddress')]
    [IPAddress]
    $IPAddress,

    # If set, will output the connection information.
    [switch]
    $PassThru
    )

    begin {
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        if (-not (Test-Path $lightScriptRoot)) {
            $createLightScriptDir = New-Item -ItemType Directory -Path $lightScriptRoot
            if (-not $createLightScriptDir) { return }
        }

        @(Get-ChildItem -Filter *.twinkly.clixml -Path $lightScriptRoot) |
            Foreach-Object {
                $file = $_
                $fileInfo = Import-Clixml -LiteralPath $file.FullName
                if ($fileInfo.IPAddress -eq $IPAddress -and $PSCmdlet.ShouldProcess("Remove $($fileInfo.uuid)")) {
                    Remove-Item -LiteralPath $file.FullName -Force
                }
            }
        
    }
}

