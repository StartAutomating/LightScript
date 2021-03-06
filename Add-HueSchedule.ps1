function Add-HueSchedule
{
    <#
    .Synopsis
        Adds a schedule to a Hue Bridge
    .Description
        Adds a new schedule to a Hue Bridge
    .Example
        Add-HueSchedule -Daily -Name "Shift to Sunset" -Description "Shift to warmer and brighter as the day draws to a close" -Command (Set-Light -ColorTemperature 400 -Luminance 1 -TransitionTime '01:30:00' -OutputInput) -LocalTime "3:00 PM"
    .Link
        Get-HueSchedule
    .Link
        Get-HueBridge
    #>
    [OutputType([PSObject])]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("Test-ForParameterSetAmbiguity", "", Justification="Ambiguity desired")]
    param(
    # The name of the schedule
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Name,

    # A description for the schedule
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Description,

    # The command that will be run
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [PSObject]
    $Command,

    # The time of the command
    [Parameter(Mandatory,ParameterSetName='LocalTime',Position=0,ValueFromPipelineByPropertyName)]
    [Alias('At')]
    [DateTime]
    $LocalTime,

    # If set, will run daily
    [Parameter(ParameterSetName='LocalTime',Position=1,ValueFromPipelineByPropertyName)]
    [switch]
    $Daily,

    # The days of the week the schedule will be executed (1 is Sunday, 7 is Saturday).
    [Parameter(ParameterSetName='LocalTime',Position=2,ValueFromPipelineByPropertyName)]
    [ValidateRange(1,7)]
    [byte[]]
    $DayOfWeek,

    # The time the schedule should last
    [Parameter(ParameterSetName='LocalTime',Position=3,ValueFromPipelineByPropertyName)]
    [Alias('ForTimeframe','ForTimespan')]
    [Timespan]
    $For,


    # Sets a countdown timer.  This timer will occur once, in a given timespan.
    [Parameter(Mandatory=$true,Position=0,ParameterSetName='InTimespan',ValueFromPipelineByPropertyName)]
    [Alias('InTime', 'InTimespan')]
    [Timespan]
    $In,

    # If set, will repeat every N timeframe
    [Parameter(Mandatory=$true,Position=0,ParameterSetName='EveryTimespan',ValueFromPipelineByPropertyName)]
    [Alias('EveryTime', 'EveryTimespan')]
    [Timespan]
    $Every,

    # If provided, the schedule will execute at a random time within the provided timespan.
    [Parameter(ParameterSetName='LocalTime',Position=4,ValueFromPipelineByPropertyName)]
    [Parameter(ParameterSetName='InTimespan',Position=1,ValueFromPipelineByPropertyName)]
    [Alias('Jitter', 'Around')]
    [Timespan]
    $Within,

    # If provided, the schedule will only run on the bridge with a particular device ID
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $DeviceID,

    # If provided, the schedule will only run on the bridge found at the provided IP address
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('IP')]
    [IPAddress]
    $IPAddress
    )

    begin {
        $dayBits = @{
            1 = 1    # Sunday
            2 = 64   # Monday
            3 = 32   # Tuesday
            4 = 16   # Wednesday
            5 = 8    # Thursday
            6 = 4    # Friday
            7 = 2    # Saturday
        }
    }

    process {

        $restIn = @{}
        if ($Name) {
            $restIn.name = $Name
        }
        if ($Description) {
            $restIn.description = $Description
        }


        $restIn.command =
            if ($Command -is [Collections.IDictionary]) {
                [PSCustomObject]$Command
            } else {
                $Command
            }

        $timeparts = @(
            if ($PSCmdlet.ParameterSetName -eq 'LocalTime') {
                #region Weekly Schedules
                if ($DayOfWeek)
                {
                    # If we want a day of week,
                    # We'll have to mask some bits.
                    $dayMask = 0
                    foreach ($d in $DayOfWeek) { # Just walk thru the days
                        $daymask = $daymask -bxor $dayBits[$d -as [int]] # And XOR the 2^(d-1)
                    }
                    "W$daymask"  # Then we take the day mask
                    'T{0:d2}:{1:d2}:{2:d2}' -f # and append the time.
                    $LocalTime.Hour, $LocalTime.Minute, $LocalTime.Second
                    if ($For) {
                        $until = $LocalTime + $For
                        'T{0:d2}:{1:d2}:{2:d2}' -f # and append the time.
                        $Until.Hour, $Until.Minute, $Until.Second +
                        $(if ($Within) {"A$($Within)" })
                    }
                }
                #endregion Weekly Schedules
                #region Daily Schedules
                elseif ($Daily)
                {
                    # If we're running every day,
                    'W127'  # the date part goes away,
                    'T{0:d2}:{1:d2}:{2:d2}' -f # and the time is formatted after.
                    $LocalTime.Hour, $LocalTime.Minute, $LocalTime.Second +
                    $(if ($Within) {
                        "A$($Within)"
                    })
                    if ($For) {
                        $until = $LocalTime + $For
                        'T{0:d2}:{1:d2}:{2:d2}' -f # and append the time.
                        $Until.Hour, $Until.Minute, $Until.Second +
                        $(if ($Within) {"A$($Within)" })
                    }
                }
                #endregion Daily Schedules
                elseif ($for)
                {
                    'T{0:d2}:{1:d2}:{2:d2}' -f # and the time is formatted after.
                    $LocalTime.Hour, $LocalTime.Minute, $LocalTime.Second
                    if ($For) {
                        $until = $LocalTime + $For
                        'T{0:d2}:{1:d2}:{2:d2}' -f # and append the time.
                        $Until.Hour, $Until.Minute, $Until.Second +
                        $(if ($Within) {"A$($Within)" })
                    }
                } else
                {
                    # If they really only want this once, life is easy
                    $LocalTime.ToString('s') + $(if ($Within) {
                        "A$($Within)"
                    })
                }
            }
            elseif ($PSCmdlet.ParameterSetName -eq 'InTimespan')
            {
                "PT$In" + $(if ($Within) { "A$($Within)" })
            }
            elseif ($PSCmdlet.ParameterSetName -eq 'EveryTimespan')
            {
                "R/PT$Every" + $(if ($Within) { "A$($Within)" })
            }
        )


        # $restin = & $SetLightScheduleInput
        $restin.localtime = $timeparts -join '/'
        $restin.recycle = $false

        $scheduleExists = Get-HueSchedule -Name $Name -ExactMatch

        $httpVerb = 'POST'
        $httpCommand = 'schedules'

        if ($scheduleExists) {
            $httpVerb = 'PUT'
            $httpCommand = "schedules/$($scheduleExists.ID)"
            $restin.Remove('Recycle')
        }

        if (-not $restin.status) {
            $restin.status = 'enabled'
        }

        Get-HueBridge |
            Where-Object {
                if ($DeviceID -and $_.DeviceID -ne $DeviceID) { return $false }
                if ($IPAddress -and $_.IPAddress -ne $IPAddress) { return $false }
                $true
            } |
            Send-HueBridge -Command $httpCommand -Method $httpVerb -Data $restIn
    }
}