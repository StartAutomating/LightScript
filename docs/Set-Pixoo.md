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
Set-Pixoo -Brightness 1
```

#### EXAMPLE 2
```PowerShell
# Set the pixoo to the 3rd visualizer (a nice frequency graph)
Set-Pixoo -Visualizer 3
```

#### EXAMPLE 3
```PowerShell
# The timer will elapse after 30 seconds.
Set-Pixoo -Timer "00:00:30"
```

---
### Parameters
#### **IPAddress**

One or more IP Addresses of Twinkly devices.



> **Type**: ```[IPAddress[]]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Brightness**

Sets the brightness of all lights in a fixture
When passed with -Hue and -Saturation, sets the color
When passed with no other parameters, adjusts the absolute brightness



> **Type**: ```[Single]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **Hue**

Sets the hue of all lights in a fixture



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **Saturation**

Sets the saturation of all lights in a fixture



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **On**

If set, will turn a Pixoo screen on.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Off**

If set, will turn a Pixoo screen off.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Visualizer**

If provided, will switch the Pixoo to a given numbered visualizer



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **CustomPlaylist**

If provided, will switch the Pixoo custom playlist



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 6

> **PipelineInput**:true (ByPropertyName)



---
#### **CloudChannel**

If provided, will switch the Pixoo's current Cloud Channel.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 7

> **PipelineInput**:true (ByPropertyName)



---
#### **Channel**

If provided, will switch the Pixoo channel.



Valid Values:

* Clock
* Cloud
* Visualizer
* Custom



> **Type**: ```[String]```

> **Required**: false

> **Position**: 8

> **PipelineInput**:true (ByPropertyName)



---
#### **Stopwatch**

If provided, will switch the Pixoo into Stopwatch mode, and Stop, Reset, or Start the StopWatch



Valid Values:

* Stop
* Start
* Reset



> **Type**: ```[String]```

> **Required**: false

> **Position**: 9

> **PipelineInput**:true (ByPropertyName)



---
#### **Timer**

If provided, will switch the Pixoo into a Timer, with the given timespan.
(hours and subseconds will be ignored)



> **Type**: ```[TimeSpan]```

> **Required**: false

> **Position**: 10

> **PipelineInput**:true (ByPropertyName)



---
#### **NoiseMeter**

If set, will display a noise meter.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **RedScore**

If provided, will switch the Pixoo into a Scoreboard.
-RedScore is the score for the Red Team
-BlueScore is the score for the Blue Team



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 11

> **PipelineInput**:true (ByPropertyName)



---
#### **BlueScore**

If provided, will switch the Pixoo into a Scoreboard.
-RedScore is the score for the Red Team
-BlueScore is the score for the Blue Team



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 12

> **PipelineInput**:true (ByPropertyName)



---
#### **RGBColor**

If provided, will change the Pixoo into a single RGB color.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 13

> **PipelineInput**:true (ByPropertyName)



---
#### **Latitude**

The latitude for the device.  Must be provided with -Longitude



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 14

> **PipelineInput**:true (ByPropertyName)



---
#### **Longitude**

The longitude for the device.  Must be provided with -Latitude



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 15

> **PipelineInput**:true (ByPropertyName)



---
#### **Rotation**

Set the device rotation.



Valid Values:

* 0
* 90
* 180
* 270



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 16

> **PipelineInput**:true (ByPropertyName)



---
#### **Mirror**

If set, will put the Pixoo device into mirroring mode.
This can be nice if you have two Pixoos side by side.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



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
Set-Pixoo [[-IPAddress] <IPAddress[]>] [[-Brightness] <Single>] [[-Hue] <Double>] [[-Saturation] <Double>] [-On] [-Off] [[-Visualizer] <Int32>] [[-CustomPlaylist] <Int32>] [[-CloudChannel] <Int32>] [[-Channel] <String>] [[-Stopwatch] <String>] [[-Timer] <TimeSpan>] [-NoiseMeter] [[-RedScore] <Int32>] [[-BlueScore] <Int32>] [[-RGBColor] <String>] [[-Latitude] <Double>] [[-Longitude] <Double>] [[-Rotation] <Int32>] [-Mirror] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---
