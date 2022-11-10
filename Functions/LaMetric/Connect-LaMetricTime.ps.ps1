function Connect-LaMetricTime
{
    <#
    .SYNOPSIS
        Connects to a LaMetric clock
    .DESCRIPTION
        Connects to a LaMetric clock.

        LaMetric Time devices require a local ApiKey.
        
        Unfortunately, there is no way to get this key automatically.
        
        To Connect-LaMetricTime, you'll need to visit [developer.lametric.com](https://developer.lametric.com) and sign in.

        You will find API Keys for your devices at [developer.lametric.com/user/devices](https://developer.lametric.com/user/devices).
    .EXAMPLE
        Connect-LaMetric -IPAddress $laMetricIP -ApiKey $myApiKey -PassThru
    .LINK
        Get-LaMetricTime
    .LINK
        Disconnect-LaMetricTime
    #>
    [OutputType([Nullable], [PSObject])]
    param(
    # The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.
    [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
    [Alias('LaMetricTimeIPAddress')]
    [IPAddress]
    $IPAddress,

    # The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.
    [Parameter(Mandatory,Position=1,ValueFromPipelineByPropertyName)]
    [Alias('LaMetricTimeApiKey')]
    [string]
    $ApiKey,

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
        $laMetricB64Key = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("dev:$ApiKey")) 
        $ipAndPort      = "${ipAddress}:8080"

        #region Connect to the Device
        $laMetricDevice = 
            http://$ipAndPort/api/v2/device -Headers @{
                Authorization = "Basic $laMetricB64Key"            
            }

        # If we could not connect, return
        if (-not $laMetricDevice) {
            return
        }
        #endregion Connect to the Device
        
        if ($laMetricDevice) {            
            #region Save Device Information
            [decorate(PSTypeName='LaMetric.Time',Clear)]$laMetricDevice

            if ($home -and $laMetricDevice) {
                if (-not (Test-Path $lightScriptRoot)) {
                    $createLightScriptDir = New-Item -ItemType Directory -Path $lightScriptRoot
                    if (-not $createLightScriptDir) { return }
                }


                $laMetricDataFile = Join-Path $lightScriptRoot ".$($laMetricDevice.serial_number).LaMetricTime.clixml"

                $laMetricDevice |
                    Add-Member NoteProperty IpAddress $IPAddress -Force -PassThru |
                    Add-Member NoteProperty ApiKey $laMetricB64Key -Force -PassThru |
                    Export-Clixml -Path $laMetricDataFile
            }
            #endregion Save Device Information
            if ($PassThru) {
                $laMetricDevice
            }
        }
    }
}
