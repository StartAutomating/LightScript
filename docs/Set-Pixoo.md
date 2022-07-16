
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
#### EXAMPLE 1
```PowerShell
Set-Pixoo -Brightness .5
```

---
### Parameters
#### **IPAddress**

One or more IP Addresses of Twinkly devices.



|Type               |Requried|Postion|PipelineInput        |
|-------------------|--------|-------|---------------------|
|```[IPAddress[]]```|false   |1      |true (ByPropertyName)|
---
#### **Brightness**

Sets the brightness of all lights in a fixture
When passed with -Hue and -Saturation, sets the color
When passed with no other parameters, adjusts the absolute brightness



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Single]```|false   |2      |true (ByPropertyName)|
---
#### **Hue**

Sets the hue of all lights in a fixture



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Double]```|false   |3      |true (ByPropertyName)|
---
#### **Saturation**

Sets the saturation of all lights in a fixture



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Double]```|false   |4      |true (ByPropertyName)|
---
#### **On**

If set, will turn a Pixoo screen on.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **Off**

If set, will turn a Pixoo screen off.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **Visualizer**

If provided, will switch the Pixoo to a given numbered visualizer



|Type         |Requried|Postion|PipelineInput        |
|-------------|--------|-------|---------------------|
|```[Int32]```|false   |5      |true (ByPropertyName)|
---
#### **CustomPlaylist**

If provided, will switch the Pixoo custom playlist



|Type         |Requried|Postion|PipelineInput        |
|-------------|--------|-------|---------------------|
|```[Int32]```|false   |6      |true (ByPropertyName)|
---
#### **CloudChannel**

If provided, will switch the Pixoo's current Cloud Channel.



|Type         |Requried|Postion|PipelineInput        |
|-------------|--------|-------|---------------------|
|```[Int32]```|false   |7      |true (ByPropertyName)|
---
#### **Channel**

If provided, will switch the Pixoo channel.



Valid Values:

* Clock
* Cloud
* Visualizer
* Custom
|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |8      |true (ByPropertyName)|
---
#### **Stopwatch**

If provided, will switch the Pixoo into Stopwatch mode, and Stop, Reset, or Start the StopWatch



Valid Values:

* Stop
* Start
* Reset
|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |9      |true (ByPropertyName)|
---
#### **Timer**

If provided, will switch the Pixoo into a Timer, with the given timespan.
(hours and subseconds will be ignored)



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[TimeSpan]```|false   |10     |true (ByPropertyName)|
---
#### **NoiseMeter**

If set, will display a noise meter.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **RedScore**

If provided, will switch the Pixoo into a Scoreboard.
-RedScore is the score for the Red Team
-BlueScore is the score for the Blue Team



|Type         |Requried|Postion|PipelineInput        |
|-------------|--------|-------|---------------------|
|```[Int32]```|false   |11     |true (ByPropertyName)|
---
#### **BlueScore**

If provided, will switch the Pixoo into a Scoreboard.
-RedScore is the score for the Red Team
-BlueScore is the score for the Blue Team



|Type         |Requried|Postion|PipelineInput        |
|-------------|--------|-------|---------------------|
|```[Int32]```|false   |12     |true (ByPropertyName)|
---
#### **RGBColor**

If provided, will change the Pixoo into a single RGB color.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |13     |true (ByPropertyName)|
---
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
Set-Pixoo [[-IPAddress] <IPAddress[]>] [[-Brightness] <Single>] [[-Hue] <Double>] [[-Saturation] <Double>] [-On] [-Off] [[-Visualizer] <Int32>] [[-CustomPlaylist] <Int32>] [[-CloudChannel] <Int32>] [[-Channel] <String>] [[-Stopwatch] <String>] [[-Timer] <TimeSpan>] [-NoiseMeter] [[-RedScore] <Int32>] [[-BlueScore] <Int32>] [[-RGBColor] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---


