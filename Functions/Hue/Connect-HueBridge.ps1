function Connect-HueBridge
{
    <#
    .Synopsis
        Connects to a new Hue Bridge.
    .Description
        Connects to a new Hue Bridge and saves connection information for later use.

        You must have physical access to the Hue Bridge controller.

        To demostrate your access,
        hold the link button on the Hue bridge until the lights flash.

        Then run this command within the next 30 seconds.
    .Link
        Find-HueBridge
    .Link
        Get-HueBridge
    .Example
        Find-HueBridge | Connect-HueBridge
    #>
    [CmdletBinding(DefaultParameterSetName='ExistingConnection')]
    [OutputType([Nullable], [PSObject])]
    param(
    # The IP Address of the Hue Bridge
    # This can be provided by piping Find-HueBridge to Connect-HueBridge.
    [Parameter(Mandatory,ParameterSetName='NewConnection',ValueFromPipelineByPropertyName)]
    [Alias('IPAddress')]
    [IPAddress]
    $HueBridgeIP,

    # The device identifier.
    # This can be provided by piping Find-HueBridge to Connect-HueBridge.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $DeviceID
    )

    begin {
        if ($home) {
            $lightScriptRoot = Join-Path $home -ChildPath LightScript
        }
    }

    process {
        #region Create New Connection
        if ($PSCmdlet.ParameterSetName -eq 'NewConnection') {
            if ($DeviceId) {

                $DeviceId = $DeviceId.ToUpper()
                $bridgeDataFile = Join-Path $lightScriptRoot ".$($DeviceId).huebridge.clixml"

                if (Test-Path $bridgeDataFile) {
                    $bridgeData = Import-Clixml -Path $bridgeDataFile
                    $bridgeData.IPAddress = "$HueBridgeIP"
                    $bridgeData | Export-Clixml -Path $bridgeDataFile
                    return    
                }
            }

            $DeviceType = 'LightScript'
            $userName = Get-Random
            $hueResult = Invoke-RestMethod -Uri "http://$HueBridgeIP/api" -Method POST -Body (
                ConvertTo-Json -InputObject ([PSCustomObject]@{devicetype="${DeviceType}#$UserName"})
            )

            if ($hueResult.error) {
                Write-Error -Message $hueResult.error.description -ErrorId $hueResult.error.type
                return
            }

            if (-not $hueResult) { return }
            $hueUserName = $hueResult.success.username
            $bridgeInfo = Send-HueBridge -IPAddress $HueBridgeIP -HueUserName $hueUserName -Command config
            if (-not $bridgeInfo) { return }

            if ($home) {
                if (-not (Test-Path $lightScriptRoot)) {
                    $createLightScriptDir = New-Item -ItemType Directory -Path $lightScriptRoot
                    if (-not $createLightScriptDir) { return }
                }


                $bridgeDataFile = Join-Path $lightScriptRoot ".$($bridgeInfo.bridgeid).huebridge.clixml"

                [PSCustomObject]@{IPAddress=$HueBridgeIP;DeviceID=$($bridgeInfo.bridgeid);HueUserName=$hueUserName} |
                    Export-Clixml -Path $bridgeDataFile
            }

            $bridgeInfo


        }
        #endregion Create New Connection
        #region Return Existing Connections
        elseif ($PSCmdlet.ParameterSetName -eq 'ExistingConnection') {
            Get-ChildItem -Path $lightScriptRoot -ErrorAction SilentlyContinue -Filter *.huebridge.clixml -Force |
                Import-Clixml |
                Get-HueBridge
        }
        #endregion Return Existing Connections
    }
}
