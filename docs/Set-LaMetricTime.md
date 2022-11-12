Set-LaMetricTime
----------------
### Synopsis
Sets a LaMetricTime device.

---
### Description

Configures or sends notifications to an LaMetricTime device.

---
### Related Links
* [Get-LaMetricTime](Get-LaMetricTime.md)



* [Connect-LaMetrictime](Connect-LaMetrictime.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Set-LaMetricTime -Clock    # Set LaMetricTime devices into clock mode
```

#### EXAMPLE 2
```PowerShell
Set-LaMetricTime -Weather  # Set LaMetricTime devices into weather forecast mode
```

#### EXAMPLE 3
```PowerShell
Set-LaMetricTime -NotificationText "Hello World"  # Send a notification to the LaMetric time device.
```

#### EXAMPLE 4
```PowerShell
Set-LaMetricTime -NotificationText "$" -NotificationSound cash
```

#### EXAMPLE 5
```PowerShell
# Find an icon
Search-LaMetricIcon "PowerShell" | 
    Select-Object -First 1 | # pick the first one
    Set-LaMetricTime -NotificationText "Hello PowerShell" # and display the notification
```

#### EXAMPLE 6
```PowerShell
Set-LaMetricTime -Stopwatch start   # Starts a stopwatch
```

#### EXAMPLE 7
```PowerShell
Set-LaMetricTime -Stopwatch stop    # Stops a stopwatch
```

#### EXAMPLE 8
```PowerShell
Set-LaMetricTime -Stopwatch reset   # Resets a stopwatch
```

#### EXAMPLE 9
```PowerShell
Set-LaMetricTime -Timer "00:01:00"  # Sets a timer for a minute
```

#### EXAMPLE 10
```PowerShell
Set-LaMetricTime -NextApplication      # Switches to the next application
```

#### EXAMPLE 11
```PowerShell
Set-LaMetricTime -PreviousApplication  # Switches to the previous application
```

---
### Parameters
#### **IPAddress**

One or more IP Addresses of LaMetricTime devices.
If no IP Addresses are provided, the change will apply to all devices.



> **Type**: ```[IPAddress[]]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Clock**

If set, will switch the LaMetric Time into clock mode.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Stopwatch**

If provided, will switch the LaMetric Time into Stopwatch mode, and Stop/Pause, Reset, or Start the StopWatch



Valid Values:

* Stop
* Pause
* Start
* Reset



> **Type**: ```[String]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **LastApplication**

If set, will switch to the previous application on the LaMetric Time.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **NextApplication**

If set, will switch to the next application on the LaMetric Time.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **NotificationText**

One or more messages of notification text



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **NotificationIcon**

One or more notification icons.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **NotificationDuration**

The duration of the notification.
By default, 15 seconds.



> **Type**: ```[TimeSpan]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **NotificationLoopCount**

The number of times to display the notification.
Zero or less will be considered an indefinite notification



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 6

> **PipelineInput**:true (ByPropertyName)



---
#### **LoopNotification**

If set, will indefinitely loop the notification.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **NotificationSound**

If provided, will play a sound with the notification.



Valid Values:

* alarm1
* alarm2
* alarm3
* alarm4
* alarm5
* alarm6
* alarm7
* alarm8
* alarm9
* alarm10
* alarm11
* alarm12
* alarm13
* bicycle
* car
* cash
* cat
* dog
* dog2
* energy
* knock-knock
* letter_email
* lose1
* lose2
* negative1
* negative2
* negative3
* negative4
* negative5
* notification
* notification2
* notification3
* notification4
* open_door
* positive1
* positive2
* positive3
* positive4
* positive5
* positive6
* statistic
* thunder
* water1
* water2
* win
* win2
* wind
* wind_short



> **Type**: ```[String]```

> **Required**: false

> **Position**: 7

> **PipelineInput**:true (ByPropertyName)



---
#### **CancelNotification**

If provided, will cancel a given notification.
If 0 or less is provided, will cancel all notifications.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 8

> **PipelineInput**:true (ByPropertyName)



---
#### **Timer**

Sets a Timer on the LaMetric device, using the built-in Countdown app.



> **Type**: ```[TimeSpan]```

> **Required**: false

> **Position**: 9

> **PipelineInput**:true (ByPropertyName)



---
#### **Weather**

If set, will switch the LaMetric Time into weather forecast mode.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-LaMetricTime [[-IPAddress] <IPAddress[]>] [-Clock] [[-Stopwatch] <String>] [-LastApplication] [-NextApplication] [[-NotificationText] <String[]>] [[-NotificationIcon] <String[]>] [[-NotificationDuration] <TimeSpan>] [[-NotificationLoopCount] <Int32>] [-LoopNotification] [[-NotificationSound] <String>] [[-CancelNotification] <Int32>] [[-Timer] <TimeSpan>] [-Weather] [<CommonParameters>]
```
---
