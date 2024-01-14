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
> EXAMPLE 1

```PowerShell
Set-LaMetricTime -Clock    # Set LaMetricTime devices into clock mode
```
> EXAMPLE 2

```PowerShell
Set-LaMetricTime -Weather  # Set LaMetricTime devices into weather forecast mode
```
> EXAMPLE 3

```PowerShell
Set-LaMetricTime -NotificationText "Hello World"  # Send a notification to the LaMetric time device.
```
> EXAMPLE 4

```PowerShell
Set-LaMetricTime -NotificationText "$" -NotificationSound cash
```
Find an icon

```PowerShell
Search-LaMetricIcon "PowerShell" | 
    Select-Object -First 1 | # pick the first one
    Set-LaMetricTime -NotificationText "Hello PowerShell" # and display the notification
```
> EXAMPLE 6

```PowerShell
Set-LaMetricTime -Stopwatch start   # Starts a stopwatch
```
> EXAMPLE 7

```PowerShell
Set-LaMetricTime -Stopwatch stop    # Stops a stopwatch
```
> EXAMPLE 8

```PowerShell
Set-LaMetricTime -Stopwatch reset   # Resets a stopwatch
```
> EXAMPLE 9

```PowerShell
Set-LaMetricTime -Timer "00:01:00"  # Sets a timer for a minute
```
> EXAMPLE 10

```PowerShell
Set-LaMetricTime -NextApplication      # Switches to the next application
```
> EXAMPLE 11

```PowerShell
Set-LaMetricTime -PreviousApplication  # Switches to the previous application
```

---

### Parameters
#### **IPAddress**
One or more IP Addresses of LaMetricTime devices.
If no IP Addresses are provided, the change will apply to all devices.

|Type           |Required|Position|PipelineInput        |Aliases              |
|---------------|--------|--------|---------------------|---------------------|
|`[IPAddress[]]`|false   |1       |true (ByPropertyName)|LaMetricTimeIPAddress|

#### **Clock**
If set, will switch the LaMetric Time into clock mode.

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[Switch]`|false   |named   |true (ByPropertyName)|ShowClock|

#### **Stopwatch**
If provided, will switch the LaMetric Time into Stopwatch mode, and Stop/Pause, Reset, or Start the StopWatch
Valid Values:

* Stop
* Pause
* Start
* Reset

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **LastApplication**
If set, will switch to the previous application on the LaMetric Time.

|Type      |Required|Position|PipelineInput        |Aliases                                                                       |
|----------|--------|--------|---------------------|------------------------------------------------------------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|LastApp<br/>Last<br/>Prev<br/>Previous<br/>PreviousApp<br/>PreviousApplication|

#### **NextApplication**
If set, will switch to the next application on the LaMetric Time.

|Type      |Required|Position|PipelineInput        |Aliases         |
|----------|--------|--------|---------------------|----------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|NextApp<br/>Next|

#### **NotificationText**
One or more messages of notification text

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|false   |3       |true (ByPropertyName)|

#### **NotificationIcon**
One or more notification icons.

|Type        |Required|Position|PipelineInput        |Aliases|
|------------|--------|--------|---------------------|-------|
|`[String[]]`|false   |4       |true (ByPropertyName)|IconID |

#### **NotificationDuration**
The duration of the notification.
By default, 15 seconds.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[TimeSpan]`|false   |5       |true (ByPropertyName)|

#### **NotificationLoopCount**
The number of times to display the notification.
Zero or less will be considered an indefinite notification

|Type     |Required|Position|PipelineInput        |Aliases  |
|---------|--------|--------|---------------------|---------|
|`[Int32]`|false   |6       |true (ByPropertyName)|LoopCount|

#### **LoopNotification**
If set, will indefinitely loop the notification.

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Switch]`|false   |named   |true (ByPropertyName)|Loop   |

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

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |7       |true (ByPropertyName)|

#### **CancelNotification**
If provided, will cancel a given notification.
If 0 or less is provided, will cancel all notifications.

|Type     |Required|Position|PipelineInput        |Aliases       |
|---------|--------|--------|---------------------|--------------|
|`[Int32]`|false   |8       |true (ByPropertyName)|NotificationID|

#### **Timer**
Sets a Timer on the LaMetric device, using the built-in Countdown app.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[TimeSpan]`|false   |9       |true (ByPropertyName)|

#### **Weather**
If set, will switch the LaMetric Time into weather forecast mode.

|Type      |Required|Position|PipelineInput        |Aliases                                  |
|----------|--------|--------|---------------------|-----------------------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|Forecast<br/>ShowForecast<br/>ShowWeather|

#### **Volume**
Sets the volume of an LaMetric Time device.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |10      |true (ByPropertyName)|

#### **Package**
If set, will switch to a given app.
If -Widget is not provided, the first widget will be used.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |11      |true (ByPropertyName)|

#### **WidgetID**
The widget of a given application that should be activated.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |12      |true (ByPropertyName)|

#### **WidgetActionId**
The name of the widget action id.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |13      |true (ByPropertyName)|

#### **WidgetProperty**
A set of properties to pass to a given widget.
Must be provided with -WidgetSetting
If no properties are provided, the widget will be activated.

|Type        |Required|Position|PipelineInput        |Aliases                         |
|------------|--------|--------|---------------------|--------------------------------|
|`[PSObject]`|false   |14      |true (ByPropertyName)|WidgetParameter<br/>WidgetParams|

---

### Syntax
```PowerShell
Set-LaMetricTime [[-IPAddress] <IPAddress[]>] [-Clock] [[-Stopwatch] <String>] [-LastApplication] [-NextApplication] [[-NotificationText] <String[]>] [[-NotificationIcon] <String[]>] [[-NotificationDuration] <TimeSpan>] [[-NotificationLoopCount] <Int32>] [-LoopNotification] [[-NotificationSound] <String>] [[-CancelNotification] <Int32>] [[-Timer] <TimeSpan>] [-Weather] [[-Volume] <Int32>] [[-Package] <String>] [[-WidgetID] <String>] [[-WidgetActionId] <String>] [[-WidgetProperty] <PSObject>] [<CommonParameters>]
```
