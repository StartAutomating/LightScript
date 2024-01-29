Set-Awtrix
----------

### Synopsis
Sets Awtrix

---

### Description

Changes Awtrix devices

---

### Related Links
* [Get-Awtrix](Get-Awtrix.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Set-Awtrix -Brightness 1
```
> EXAMPLE 2

```PowerShell
Set-Awtrix -RGBColor "#4488ff" # Sets the Awtrix to a blue moodlight
```
> EXAMPLE 3

```PowerShell
Set-Awtrix -NotificationText "Hello World"
```
> EXAMPLE 4

```PowerShell
Set-Awtrix -Hue 180 -Saturation .5 -Brightness .25
```

---

### Parameters
#### **IPAddress**
One or more IP Addresses of Awtrix devices.

|Type           |Required|Position|PipelineInput        |Aliases        |
|---------------|--------|--------|---------------------|---------------|
|`[IPAddress[]]`|false   |1       |true (ByPropertyName)|AwtrixIPAddress|

#### **Brightness**
Sets the brightness of all lights in a fixture
When passed with -Hue and -Saturation, sets the color
When passed with no other parameters, adjusts the absolute brightness

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[Single]`|false   |2       |true (ByPropertyName)|Luminance|

#### **Hue**
Sets the hue of all lights in a fixture

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |3       |true (ByPropertyName)|

#### **Saturation**
Sets the saturation of all lights in a fixture

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |4       |true (ByPropertyName)|

#### **On**
If set, will turn a Awtrix screen on.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Off**
If set, will turn a Awtrix screen off.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Reboot**
If set, will reboot an Awtrix device.

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Switch]`|false   |named   |true (ByPropertyName)|Reset  |

#### **RGBColor**
If provided, will change the Awtrix into a single RGB color.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |5       |true (ByPropertyName)|

#### **ColorTemperature**
If set, will change the Awtrix into a given color temperature.

|Type     |Required|Position|PipelineInput        |Aliases                 |
|---------|--------|--------|---------------------|------------------------|
|`[Int32]`|false   |6       |true (ByPropertyName)|CT<br/>TemperatureKelvin|

#### **ApplicationName**
The name of the application on the device.
This is used when sending custom notifications, and when -SwitchTo is passed.

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[String]`|false   |7       |true (ByPropertyName)|AppName|

#### **SwitchTo**
If set, will switch to a specific application (provided by `-ApplicationName`) or the next item.

|Type      |Required|Position|PipelineInput|Aliases    |
|----------|--------|--------|-------------|-----------|
|`[Switch]`|false   |named   |false        |SwitchingTo|

#### **LastApplication**
If set, will switch to the previous application on the Awtrix.

|Type      |Required|Position|PipelineInput        |Aliases                                                                       |
|----------|--------|--------|---------------------|------------------------------------------------------------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|LastApp<br/>Last<br/>Prev<br/>Previous<br/>PreviousApp<br/>PreviousApplication|

#### **NextApplication**
If set, will switch to the next application on the Awtrix.

|Type      |Required|Position|PipelineInput        |Aliases         |
|----------|--------|--------|---------------------|----------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|NextApp<br/>Next|

#### **NotificationText**
One or more messages of notification text

|Type        |Required|Position|PipelineInput        |Aliases |
|------------|--------|--------|---------------------|--------|
|`[String[]]`|false   |8       |true (ByPropertyName)|Activity|

#### **PercentComplete**
If provided, will display a progress bar within a notification.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |9       |true (ByPropertyName)|

#### **Completed**
If set, will clear a progress bar within a notification.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **NotificationDuration**
The duration of the notification (rounded to the nearest second).
By default, 15 seconds.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[TimeSpan]`|false   |10      |true (ByPropertyName)|

#### **NotificationLoopCount**
The number of times to display the notification.

|Type     |Required|Position|PipelineInput        |Aliases                  |
|---------|--------|--------|---------------------|-------------------------|
|`[Int32]`|false   |11      |true (ByPropertyName)|LoopCount<br/>RepeatCount|

#### **HoldNotification**
If set, will hold a notification, instead of displaying it for a duration.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **EffectName**
The name of the effect.

|Type      |Required|Position|PipelineInput        |Aliases |
|----------|--------|--------|---------------------|--------|
|`[String]`|false   |12      |true (ByPropertyName)|animName|

#### **EffectOption**
Any options for the effect

|Type        |Required|Position|PipelineInput        |Aliases                                               |
|------------|--------|--------|---------------------|------------------------------------------------------|
|`[PSObject]`|false   |13      |true (ByPropertyName)|EffectOptions<br/>EffectParameter<br/>EffectParameters|

#### **EffectSpeed**
The speed of the effect

|Type     |Required|Position|PipelineInput        |Aliases     |
|---------|--------|--------|---------------------|------------|
|`[Int32]`|false   |14      |true (ByPropertyName)|EffectSpeeds|

#### **NotificationOption**
Any options related to the notification.

|Type        |Required|Position|PipelineInput        |Aliases                                                                 |
|------------|--------|--------|---------------------|------------------------------------------------------------------------|
|`[PSObject]`|false   |15      |true (ByPropertyName)|NotificationOptions<br/>NotificationParameter<br/>NotificationParameters|

#### **WhatIf**
-WhatIf is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-WhatIf is used to see what would happen, or return operations without executing them
#### **Confirm**
-Confirm is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-Confirm is used to -Confirm each operation.

If you pass ```-Confirm:$false``` you will not be prompted.

If the command sets a ```[ConfirmImpact("Medium")]``` which is lower than ```$confirmImpactPreference```, you will not be prompted unless -Confirm is passed.

---

### Syntax
```PowerShell
Set-Awtrix [[-IPAddress] <IPAddress[]>] [[-Brightness] <Single>] [[-Hue] <Double>] [[-Saturation] <Double>] [-On] [-Off] [-Reboot] [[-RGBColor] <String>] [[-ColorTemperature] <Int32>] [[-ApplicationName] <String>] [-SwitchTo] [-LastApplication] [-NextApplication] [[-NotificationText] <String[]>] [[-PercentComplete] <Int32>] [-Completed] [[-NotificationDuration] <TimeSpan>] [[-NotificationLoopCount] <Int32>] [-HoldNotification] [[-EffectName] <String>] [[-EffectOption] <PSObject>] [[-EffectSpeed] <Int32>] [[-NotificationOption] <PSObject>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
