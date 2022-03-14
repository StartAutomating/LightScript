function Disconnect-Nanoleaf
{
    <#
    .Synopsis
        Disconnects a new Nanoleaf controller.
    .Description
        Disconnnects a new Nanoleaf controller and removes connection information.
    .Example
        Disconnect-NanoLeaf -IPAddress 1.2.3.4
    .Link
        Connect-NanoLeaf
    #>
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='High')]
    [OutputType([Nullable], [PSObject])]
    param(
    # The IP Address of the Nanoleaf
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [Alias('IPAddress')]
    [IPAddress]
    $NanoLeafIP
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
        
        #region Find and Remove Connection
        $files = @(Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.nanoleaf.clixml -Force) 
        $files |
            ForEach-Object {
                $file = $_
                $fileInfo = Import-Clixml -LiteralPath $file.FullName
                if ($fileInfo.IPAddress -eq $NanoLeafIP -and $PSCmdlet.ShouldProcess("Remove $($fileInfo.DeviceName)")) {
                    Remove-Item -LiteralPath $file.FullName -Force
                }
            }
                
        
        #endregion Find and Remove Connection
    }
}
