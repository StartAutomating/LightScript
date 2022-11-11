function Set-LaMetricTime {
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
    # If set, will switch the LaMetric Time into clock mode.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('ShowClock')]
    [switch]
    $Clock,
    # If provided, will switch the LaMetric Time into Stopwatch mode, and Stop/Pause, Reset, or Start the StopWatch
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet("Stop", "Pause", "Start", "Reset")]
    [string]
    $Stopwatch,
    # If set, will switch to the previous application on the LaMetric Time.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('LastApp','Last','Prev', 'Previous','PreviousApp', 'PreviousApplication')]
    [switch]
    $LastApplication,
    # If set, will switch to the next application on the LaMetric Time.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('NextApp','Next')]
    [switch]
    $NextApplication,
    
    # Sets a Timer on the LaMetric device, using the built-in Countdown app.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Timespan]
    $Timer,    
    
    # If set, will switch the LaMetric Time into weather forecast mode.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Forecast','ShowForecast', 'ShowWeather')]
    [switch]
    $Weather    
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
                Invoke-RestMethod ('http://',$ipAndPort,'/',$endpoint,'/',$appAndWiget,'' -join '') -Headers @{
                                    Authorization = "Basic $laMetricB64Key"
                                } -Body ([Ordered]@{
                                    id = "countdown.configure"
                                    params = [Ordered]@{
                                        duration  = [int]$timer.TotalSeconds
                                        start_now = $true                    
                                    }
                                    activate = $true
                                } | ConvertTo-Json) -Method 'post'
            }
            #endregion Timer
            #region Stopwatch
            if ($Stopwatch) {
                if ($Stopwatch -eq 'Stop') {
                    $Stopwatch = "Pause"
                }
                $ipAndPort = "${ip}:8080"
                $endpoint  = "api/v2/device/apps"
                $appAndWiget = "com.lametric.stopwatch/widgets/b1166a6059640bf76b9dfe0455ba8062/actions"
                Invoke-RestMethod ('http://',$ipAndPort,'/',$endpoint,'/',$appAndWiget,'' -join '') -Headers @{
                                    Authorization = "Basic $laMetricB64Key"
                                } -Body ([Ordered]@{
                                    id = "stopwatch.$($Stopwatch.ToLower())"
                                    params = [Ordered]@{}
                                    activate = $true
                                } | ConvertTo-Json) -Method 'post'
            }
            #endregion Stopwatch
            #region Weather
            if ($Weather) {
                $ipAndPort = "${ip}:8080"
                $endpoint  = "api/v2/device/apps"
                $appAndWiget = "com.lametric.weather/widgets/380375c4b12c16e3adafb48355ba8061/activate"
                Invoke-RestMethod ('http://',$ipAndPort,'/',$endpoint,'/',$appAndWiget,'' -join '') -Headers @{
                                    Authorization = "Basic $laMetricB64Key"
                                } -Method 'put'
            }
            #endregion Weather
            #region -Clock
            if ($Clock) {
                $ipAndPort = "${ip}:8080"
                $endpoint  = "api/v2/device/apps"
                $appAndWiget = "com.lametric.clock/widgets/08b8eac21074f8f7e5a29f2855ba8060/activate"
                Invoke-RestMethod ('http://',$ipAndPort,'/',$endpoint,'/',$appAndWiget,'' -join '') -Headers @{
                                    Authorization = "Basic $laMetricB64Key"
                                } -Method 'put'
            }
            #endregion Clock
            #region -NextApplication
            if ($NextApplication) {
                $ipAndPort = "${ip}:8080"
                $endpoint  = "api/v2/device/apps/next"
                Invoke-RestMethod ('http://',$ipAndPort,'/',$endpoint,'' -join '') -Headers @{
                                    Authorization = "Basic $laMetricB64Key"
                                } -Method 'put'
            }
            #endregion NextApplication
            #region LastApplication
            if ($LastApplication) {
                $ipAndPort = "${ip}:8080"
                $endpoint  = "api/v2/device/apps/prev"
                Invoke-RestMethod ('http://',$ipAndPort,'/',$endpoint,'' -join '') -Headers @{
                                    Authorization = "Basic $laMetricB64Key"
                                } -Method 'put'
            }
            #endregion LastApplication
        }
    }
}
