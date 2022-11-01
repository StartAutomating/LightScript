function Watch-HueSensor
{
    <#
    .SYNOPSIS
        Watches Hue Sensors for changes
    .DESCRIPTION
        Watches Hue Sensors for changes.
        
        An event will be generated whenever a sensor changes.
    .LINK
        Get-HueSensor
    .EXAMPLE
        # Watch for events every minute
        Watch-HueSensor -Interval "00:01:00"

        # Whenever daylight changes
        Register-EngineEvent -SourceIdentifier Daylight.Changed -Action {
            if ($event.MessageData.state.Daylight) {
                Set-HueLight -Brightness 0.5
                Set-NanoLeaf -Brightness 0.5
            } else {
                Set-HueLight -Brightness 1
                Set-NanoLeaf -Brightness 1
            }
        }
    #>
    [OutputType([Management.Automation.Job])]
    param(
    # The interval hue sensors will be polled.  By default, every 2.5 seconds.
    [Parameter(ValueFromPipelineByPropertyName)]
    [timespan]
    $Interval = '00:00:02.5'
    )

    process {
        #region Define Background Job
        $watchJob = [scriptblock]::Create((@"
Import-Module '$($MyInvocation.MyCommand.Module.Path -replace '\.psm1$', '.psd1')'
`$sleepInterval = [Timespan]'$interval'
`$lastSensorCheck = [DateTime]::UTCNow
do {
"@) + {
    Register-EngineEvent -Forward -SourceIdentifier Hue.Sensor.Changed
    foreach ($sensor in @(Get-HueSensor)) {
        if (($sensor.State.lastUpdated -eq 'none') -or (
            $sensor.State.lastUpdated -lt $LastSensorCheck
        )) { 
            continue
        }
        
        New-Event -SourceIdentifier "Hue.Sensor.Changed" -MessageData $sensor
        $eventName = "$($sensor.Name -replace '\s').Changed"
        Register-EngineEvent -Forward -SourceIdentifier $eventName
        New-Event -SourceIdentifier $eventName -MessageData $sensor
    }
    $LastSensorCheck = [datetime]::UtcNow
    Start-Sleep -Milliseconds $sleepInterval.TotalMilliseconds
} + "
} while (`$true)")

        #endregion Define Background Job
        
        #region Launch Job
        $jobExists = Get-Job | Where-Object Name -EQ Watch-HueSensor 
        if ($jobExists -and $jobExists.Interval -gt $Interval) { 
            $jobExists | Remove-Job -Force
        }
        Start-Job -ScriptBlock $watchJob -Name 'Watch-HueSensor' | 
            Add-Member NoteProperty Interval $Interval -Force -PassThru
        #endregion Launch Job
    }
}