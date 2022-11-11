function Set-LaMetricTime
{
    <#
    .SYNOPSIS
        Sets a LaMetricTime device.
    .DESCRIPTION
        Configures or sends notifications to an LaMetricTime device.
    .EXAMPLE

    .LINK
        Get-LaMetricTime
    .LINK
        Connect-LaMetrictime
    #>
    param(
    # One or more IP Addresses of LaMetricTime devices.
    # If no IP Addresses are provided, the change will apply to all devices.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('LaMetricTimeIPAddress')]
    [IPAddress[]]
    $IPAddress,

    # Sets a Timer on the LaMetric device, using the built-in Countdown app.
    [Parameter(ValueFromPipelineByPropertyName)]
    [timespan]
    $Timer,

    # If provided, will switch the LaMetric Time into Stopwatch mode, and Stop, Reset, or Start the StopWatch
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet("Stop", "Start", "Reset")]
    [string]
    $Stopwatch
    )

    process {
        if (-not $IPAddress) {
            if ($home) {
                $null = Get-LaMetricTime
                $IPAddress = $script:LaMetricTimeCache.Keys
            }
            if (-not $IPAddress) {
                Write-Warning "No -IPAddress provided and no cached devices found"
                return
            }
        }

        foreach ($ip in $IPAddress) {
            $laMetricB64Key = $script:LaMetricTimeCache["$ip"].ApiKey
            #region Timer
            if ($timer.TotalSeconds -ge 1) {
                $ipAndPort = "${ip}:8080"
                $endpoint  = "api/v2/device/apps"
                $appAndWiget = "com.lametric.countdown/widgets/f03ea1ae1ae5f85b390b460f55ba8061/actions"
                post http://$ipAndPort/$endpoint/$appAndWiget -Headers @{
                    Authorization = "Basic $laMetricB64Key"
                } -Body ([Ordered]@{
                    id = "countdown.configure"
                    params = [Ordered]@{
                        duration  = [int]$timer.TotalSeconds
                        start_now = $true                    
                    }
                    activate = $true
                } | ConvertTo-Json)
            }
            #endregion Timer

            #region Stopwatch
            $ipAndPort = "${ip}:8080"
            $endpoint  = "api/v2/device/apps"
            $appAndWiget = "com.lametric.stopwatch/widgets/b1166a6059640bf76b9dfe0455ba8062=/actions"
            post http://$ipAndPort/$endpoint/$appAndWiget -Headers @{
                Authorization = "Basic $laMetricB64Key"
            } -Body ([Ordered]@{
                id = "stopwatch.$($Stopwatch.ToLower())"
                params = [Ordered]@{}
                activate = $true
            } | ConvertTo-Json)
            #endregion Stopwatch
        }
    }
}