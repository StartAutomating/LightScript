Set-Pixoo
---------

### Synopsis
Sets Pixoo Frames

---

### Description

Changes Pixoo Frames

---

### Related Links
* [Get-Pixoo](Get-Pixoo.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Set-Pixoo -Brightness 1
```
Set the pixoo to the 3rd visualizer (a nice frequency graph)

```PowerShell
Set-Pixoo -Visualizer 3
```
The timer will elapse after 30 seconds.

```PowerShell
Set-Pixoo -Timer "00:00:30"
```

---

### Parameters
#### **IPAddress**
One or more IP Addresses of Pixoo devices.

|Type           |Required|Position|PipelineInput        |Aliases       |
|---------------|--------|--------|---------------------|--------------|
|`[IPAddress[]]`|false   |1       |true (ByPropertyName)|PixooIPAddress|

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
If set, will turn a Pixoo screen on.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Off**
If set, will turn a Pixoo screen off.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Visualizer**
If provided, will switch the Pixoo to a given numbered visualizer

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |5       |true (ByPropertyName)|

#### **CustomPlaylist**
If provided, will switch the Pixoo custom playlist

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |6       |true (ByPropertyName)|

#### **CloudChannel**
If provided, will switch the Pixoo's current Cloud Channel.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |7       |true (ByPropertyName)|

#### **Channel**
If provided, will switch the Pixoo channel.
Valid Values:

* Clock
* Cloud
* Visualizer
* Custom

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |8       |true (ByPropertyName)|

#### **Stopwatch**
If provided, will switch the Pixoo into Stopwatch mode, and Stop, Reset, or Start the StopWatch
Valid Values:

* Stop
* Start
* Reset

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |9       |true (ByPropertyName)|

#### **Timer**
If provided, will switch the Pixoo into a Timer, with the given timespan.
(hours and subseconds will be ignored)

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[TimeSpan]`|false   |10      |true (ByPropertyName)|

#### **NoiseMeter**
If set, will display a noise meter.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **RedScore**
If provided, will switch the Pixoo into a Scoreboard.
-RedScore is the score for the Red Team
-BlueScore is the score for the Blue Team

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |11      |true (ByPropertyName)|

#### **BlueScore**
If provided, will switch the Pixoo into a Scoreboard.
-RedScore is the score for the Red Team
-BlueScore is the score for the Blue Team

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |12      |true (ByPropertyName)|

#### **RGBColor**
If provided, will change the Pixoo into a single RGB color.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |13      |true (ByPropertyName)|

#### **Latitude**
The latitude for the device.  Must be provided with -Longitude

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Double]`|false   |14      |true (ByPropertyName)|Lat    |

#### **Longitude**
The longitude for the device.  Must be provided with -Latitude

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Double]`|false   |15      |true (ByPropertyName)|Long   |

#### **Rotation**
Set the device rotation.
Valid Values:

* 0
* 90
* 180
* 270

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |16      |true (ByPropertyName)|

#### **Mirror**
If set, will put the Pixoo device into mirroring mode.
This can be nice if you have two Pixoos side by side.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Beep**
If set, the Pixoo will beep.
-BeepTime controls how long a -Beep will last

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Switch]`|false   |named   |true (ByPropertyName)|Beeps  |

#### **BeepTime**
-BeepTime controls how long a -Beep will last

|Type        |Required|Position|PipelineInput        |Aliases|
|------------|--------|--------|---------------------|-------|
|`[TimeSpan]`|false   |17      |true (ByPropertyName)|BeepFor|

#### **BeepPause**
-BeepPause controls how long to wait between -Beeps

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[TimeSpan]`|false   |18      |true (ByPropertyName)|

#### **BeepCount**
-BeepCount controls the number of -Beeps

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |19      |true (ByPropertyName)|

#### **FileID**
A file identifier of an upload or liked file.
These can be retreived by using Get-Pixoo -Upload.
Note: File IDs are unique to each Pixoo device

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |20      |true (ByPropertyName)|

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
Set-Pixoo [[-IPAddress] <IPAddress[]>] [[-Brightness] <Single>] [[-Hue] <Double>] [[-Saturation] <Double>] [-On] [-Off] [[-Visualizer] <Int32>] [[-CustomPlaylist] <Int32>] [[-CloudChannel] <Int32>] [[-Channel] <String>] [[-Stopwatch] <String>] [[-Timer] <TimeSpan>] [-NoiseMeter] [[-RedScore] <Int32>] [[-BlueScore] <Int32>] [[-RGBColor] <String>] [[-Latitude] <Double>] [[-Longitude] <Double>] [[-Rotation] <Int32>] [-Mirror] [-Beep] [[-BeepTime] <TimeSpan>] [[-BeepPause] <TimeSpan>] [[-BeepCount] <Int32>] [[-FileID] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
