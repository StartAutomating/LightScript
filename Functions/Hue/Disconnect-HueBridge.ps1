function Disconnect-HueBridge
{
    <#
    .Synopsis
        Disconnects a Hue Bridge.
    .Description
        Disconnects a new Hue Bridge and removes connection information.
    .Link
        Connect-HueBridge
    .Example
        Disconnect-HueBridge -HueBridgeIP 1.2.3.4
    #>
    [CmdletBinding(DefaultParameterSetName='ExistingConnection')]
    [OutputType([Nullable], [PSObject])]
    param(
    # The IP Address of the Hue Bridge
    [Parameter(Mandatory,ParameterSetName='NewConnection',ValueFromPipelineByPropertyName)]
    [Alias('IPAddress')]
    [IPAddress]
    $HueBridgeIP
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
        $files = @(Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.huebridge.clixml -Force) 
        $files |
            ForEach-Object {
                $file = $_
                $fileInfo = Import-Clixml -LiteralPath $file.FullName
                if ($fileInfo.IPAddress -eq $HueBridgeIP -and $PSCmdlet.ShouldProcess("Remove $($fileInfo.DeviceID)")) {
                    Remove-Item -LiteralPath $file.FullName -Force
                }
            }                    
        #endregion Find and Remove Connection        
    }
}

