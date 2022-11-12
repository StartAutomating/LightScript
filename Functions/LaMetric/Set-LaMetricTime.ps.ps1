function Set-LaMetricTime
{
    <#
    .SYNOPSIS
        Sets a LaMetricTime device.
    .DESCRIPTION
        Configures or sends notifications to an LaMetricTime device.
    .EXAMPLE
        Set-LaMetricTime -Clock    # Set LaMetricTime devices into clock mode
    .EXAMPLE
        Set-LaMetricTime -Weather  # Set LaMetricTime devices into weather forecast mode
    .EXAMPLE
        Set-LaMetricTime -NotificationText "Hello World"  # Send a notification to the LaMetric time device.
    .EXAMPLE
        # Find an icon
        Search-LaMetricIcon "PowerShell" | 
            Select-Object -First 1 | # pick the first one
            Set-LaMetricTime -NotificationText "Hello PowerShell" # and display the notification
    .EXAMPLE
        Set-LaMetricTime -Stopwatch start   # Starts a stopwatch
    .EXAMPLE
        Set-LaMetricTime -Stopwatch stop    # Stops a stopwatch
    .EXAMPLE
        Set-LaMetricTime -Stopwatch reset   # Resets a stopwatch
    .EXAMPLE
        Set-LaMetricTime -Timer "00:01:00"  # Sets a timer for a minute
    .EXAMPLE
        Set-LaMetricTime -NextApplication      # Switches to the next application
    .EXAMPLE
        Set-LaMetricTime -PreviousApplication  # Switches to the previous application
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

    # One or more messages of notification text
    [Parameter(ValueFromPipelineByPropertyName)]
    [string[]]
    $NotificationText,

    # One or more notification icons.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('IconID')]
    [string[]]
    $NotificationIcon,

    # The duration of the notification.
    # By default, 15 seconds.
    [Parameter(ValueFromPipelineByPropertyName)]
    [timespan]
    $NotificationDuration = "00:00:15",

    # The number of times to display the notification.
    # Zero or less will be considered an indefinite notification
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('LoopCount')]
    [int]
    $NotificationLoopCount,

    # If set, will indefinitely loop the notification.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Loop')]
    [switch]
    $LoopNotification,

    # If provided, will play a sound with the notification.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet(
        'alarm1','alarm2','alarm3','alarm4','alarm5','alarm6','alarm7',
        'alarm8','alarm9','alarm10','alarm11','alarm12','alarm13',
        'bicycle','car','cash','cat','dog','dog2','energy','knock-knock','letter_email',
        'lose1','lose2','negative1','negative2','negative3','negative4','negative5',
        'notification','notification2','notification3','notification4',
        'open_door','positive1','positive2','positive3','positive4','positive5','positive6',
        'statistic','thunder','water1','water2','win','win2','wind','wind_short'
    )]
    [string]
    $NotificationSound,

    # If provided, will cancel a given notification.
    # If 0 or less is provided, will cancel all notifications.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('NotificationID')]
    [int]
    $CancelNotification,
    
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
            $ipAndPort = "${ip}:8080"
            $headers = @{Authorization = "Basic $laMetricB64Key"}
            #region Timer
            if ($timer.TotalSeconds -ge 1) {                
                $endpoint  = "api/v2/device/apps"
                $appAndWiget = "com.lametric.countdown/widgets/f03ea1ae1ae5f85b390b460f55ba8061/actions"
                post http://$ipAndPort/$endpoint/$appAndWiget -Body ([Ordered]@{
                    id = "countdown.configure"
                    params = [Ordered]@{
                        duration  = [int]$timer.TotalSeconds
                        start_now = $true                    
                    }
                    activate = $true
                } | ConvertTo-Json) -Headers $headers
            }
            #endregion Timer

            #region Stopwatch
            if ($Stopwatch) {
                if ($Stopwatch -eq 'Stop') {
                    $Stopwatch = "Pause"
                }                
                $endpoint  = "api/v2/device/apps"
                $appAndWiget = "com.lametric.stopwatch/widgets/b1166a6059640bf76b9dfe0455ba8062/actions"
                post http://$ipAndPort/$endpoint/$appAndWiget -Body ([Ordered]@{
                    id = "stopwatch.$($Stopwatch.ToLower())"
                    params = [Ordered]@{}
                    activate = $true
                } | ConvertTo-Json) -Headers $headers
            }
            #endregion Stopwatch

            #region Weather
            if ($Weather) {                
                $endpoint  = "api/v2/device/apps"
                $appAndWiget = "com.lametric.weather/widgets/380375c4b12c16e3adafb48355ba8061/activate"
                put http://$ipAndPort/$endpoint/$appAndWiget -Headers $headers
            }
            #endregion Weather

            #region -Clock
            if ($Clock) {                
                $endpoint  = "api/v2/device/apps"
                $appAndWiget = "com.lametric.clock/widgets/08b8eac21074f8f7e5a29f2855ba8060/activate"
                put http://$ipAndPort/$endpoint/$appAndWiget -Headers $headers
            }
            #endregion Clock

            #region -NextApplication
            if ($NextApplication) {                
                $endpoint  = "api/v2/device/apps/next"
                put http://$ipAndPort/$endpoint -Headers $headers
            }
            #endregion NextApplication

            #region LastApplication
            if ($LastApplication) {
                $endpoint  = "api/v2/device/apps/prev"
                put http://$ipAndPort/$endpoint -Headers $headers
            }
            #endregion LastApplication

            #region Notifications
            if ($NotificationText -or $NotificationIcon) {
                $maxFrameCount = [Math]::max($NotificationText.Length, $NotificationIcon.Length)
                $notificationFrames = 
                    @(for ($frameNumber =0 ; $frameNumber -lt $maxFrameCount; $frameNumber++) {
                        $frameInfo = [Ordered]@{}
                        if ($NotificationText -and $NotificationText[$frameNumber]) {
                            if ($NotificationText[$frameNumber] -match '^(?<p>\d+)%$') {
                                $frameInfo.goalData = [Ordered]@{
                                    start = 0
                                    current = [int]$matches.p
                                    end = 100
                                    unit = "%"
                                }
                            } else {
                                $frameInfo.text = $NotificationText[$frameNumber]
                            }                            
                        }
                        if ($NotificationIcon -and $NotificationIcon[$frameNumber]) {
                            $icon = $NotificationIcon[$frameNumber]
                            if ($icon -like 'http*') {

                            }
                            elseif ((($icon -replace '\D') -as [int]) -ge 1) {
                                $frameInfo.icon = $icon
                            }
                            elseif ($icon.Contains([IO.Path]::DirectorySeparatorChar))
                            {
                                $iconItem = Get-Item -Path $icon
                                if (-not $iconItem) {
                                    continue
                                }
                                if ($iconItem.Extension -notin '.gif', '.png') {
                                    Write-Error "Icon '$icon' must be a .gif or .png"
                                    continue
                                }                                            
                                $frameInfo.icon = "image/$($iconItem.Extension.TrimStart('.'));base64,$(
                                    [Convert]::ToBase64String([IO.File]::ReadAllBytes($iconItem.FullName))
                                )"
                            }                                        
                        }
                        $frameInfo 
                    })
                
                $notificationBody = [Ordered]@{                    
                    priority = 'info'
                    icon_type = 'none'
                    lifetime  = 
                        if ($notificationDuration) { [int]$notificationDuration.TotalMilliseconds} else { 10000 }
                    model = 
                        [Ordered]@{            
                            frames = $notificationFrames
                        }
                }

                if ($LoopNotification) {
                    $notificationBody.model.cycles = 0
                }
                if ($NotificationLoopCount) {
                    $notificationBody.model.cycles = [int][math]::min(0, $NotificationLoopCount)
                }

                if ($NotificationSound) {
                    $notificationBody.model.sound = [Ordered]@{}
                    $notificationBody.model.sound.category = 
                        if ($NotificationSound -like 'alarm*') {
                            'alarms'
                        } else {
                            'notifications'
                        }
                    $notificationBody.model.sound.id = $NotificationSound                    
                }

                post http://$ipAndPort/api/v2/device/notifications -body (
                    $notificationBody | ConvertTo-Json -Depth 10
                ) -Headers $headers
            }
            #endregion Notifications

            #region Cancel Notification
            if ($CancelNotification) {
                if ($CancelNotification -le 0) {
                    Get-LaMetricTime -IPAddress $ip -Notification |
                        Set-LaMetricTime
                    continue
                }                
                $endpoint  = "api/v2/device/notifications/$CancelNotification"
                delete http://$ipAndPort/$endpoint -Headers $headers
            }
            #endregion Cancel Notification
        }
    }
}

