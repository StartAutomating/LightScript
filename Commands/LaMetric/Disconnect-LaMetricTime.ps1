function Disconnect-LaMetricTime
{
    <#
    .Synopsis
        Disconnects a LaMetricTime
    .Description
        Disconnects a LaMetricTime, removing stored device info
    .Example
        Disconnect-LaMetricTime 1.2.3.4
    .Link
        Connect-LaMetricTime
    #>
    [OutputType([Nullable], [PSObject])]
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='High')]
    param(
    # The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.
    [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
    [Alias('LaMetricTimeIPAddress')]
    [IPAddress]
    $IPAddress
    )

    begin {
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        @(Get-ChildItem -Filter *.LaMetricTime.clixml -Path $lightScriptRoot) |
            Foreach-Object {
                $file = $_
                $fileInfo = Import-Clixml -LiteralPath $file.FullName
                if ($fileInfo.IPAddress -eq $IPAddress -and $PSCmdlet.ShouldProcess("Remove $($fileInfo.name)")) {
                    Remove-Item -LiteralPath $file.FullName -Force
                }
            }
    }
}

