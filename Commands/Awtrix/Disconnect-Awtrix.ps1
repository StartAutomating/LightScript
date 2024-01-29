function Disconnect-Awtrix
{
    <#
    .Synopsis
        Disconnects an Awtrix clock.
    .Description
        Disconnects an Ulzani Smart Clock using an Awtrix controller
    .Example
        Disconnect-Awtrix 192.168.0.160
    .Link
        Connect-Awrtrix
    #>
    [OutputType([Nullable], [PSObject])]
    param(
    # The IP Address for the Awtrix device.
    # Once you flash the device, this should be displayed on boot and accessible in the web interface.
    [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
    [Alias('AwtrixIPAddress')]
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

        @(Get-ChildItem -Filter *.awtrix.clixml -Path $lightScriptRoot) |
            Foreach-Object {
                $file = $_
                $fileInfo = Import-Clixml -LiteralPath $file.FullName
                if ($fileInfo.IPAddress -eq $IPAddress -and $PSCmdlet.ShouldProcess("Remove $($fileInfo.uid)")) {                    
                    Remove-Item -LiteralPath $file.FullName -Force
                    if ($PassThru) {
                        $FileInfo
                    }
                }
            }
        
    }
}

