function Connect-Nanoleaf
{
    <#
    .Synopsis
        Connects to a new Nanoleaf controller.
    .Description
        Connects to a new Nanoleaf controller and saves connection information for later use.

        This will return "Unauthorized" unless you have physical access to the nanoleaf controller.

        To demostrate your access, hold the power button down on the controller until the
        nanoleaf controller lights flash in sequence.  Then run this command within the next 30 seconds.
    .Example
        Find-NanoLeaf | Connect-NanoLeaf
    .Link
        Find-NanoLeaf
    .Link
        Get-NanoLeaf
    #>
    [CmdletBinding(DefaultParameterSetName='ExistingConnection')]
    [OutputType([Nullable], [PSObject])]
    param(
    # The IP Address of the Nanoleaf
    [Parameter(Mandatory,ParameterSetName='NewConnection',ValueFromPipelineByPropertyName)]
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
        #region Create New Connection
        if ($PSCmdlet.ParameterSetName -eq 'NewConnection') {
            $authResult = Invoke-RestMethod -Uri "http://${NanoLeafIP}:16021/api/v1/new" -Method Post

            if (-not $authResult) { return }
            $authToken = $authResult.auth_token
            $nanoLeafInfo = Get-NanoLeaf -NanoLeafIP $NanoLeafIP -NanoLeafToken $authToken
            if (-not $nanoLeafInfo) { return }

            if ($home) {
                if (-not (Test-Path $lightScriptRoot)) {
                    $createLightScriptDir = New-Item -ItemType Directory -Path $lightScriptRoot
                    if (-not $createLightScriptDir) { return }
                }

                $nanoLeafDataFile = Join-Path $lightScriptRoot ".$($nanoLeafInfo.serialNo).nanoleaf.clixml"

                [PSCustomObject]@{IPAddress=$NanoLeafIP;NanoLeafToken=$authToken} |
                    Export-Clixml -Path $nanoLeafDataFile
            }

            $nanoLeafInfo


        }
        #endregion Create New Connection
        #region Return Existing Connections
        elseif ($PSCmdlet.ParameterSetName -eq 'ExistingConnection') {
            Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.nanoleaf.clixml -Force |
                Import-Clixml |
                Get-NanoLeaf
        }
        #endregion Return Existing Connections





    }
}
