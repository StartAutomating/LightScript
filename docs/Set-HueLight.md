Set-HueLight
------------
### Synopsis
Sets Hue light state

---
### Description

Changes the state of one or more Hue lights

---
### Related Links
* [Get-HueLight](Get-HueLight.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Set-HueLight -Name *Lightstrip* -Luminance 0.05 # Set any Hue lights named Hue lightstrip to be very dim
```

#### EXAMPLE 2
```PowerShell
LivingRoom -On -ColorTemperature 500 -Brightness .1
# Room names and light names are automatically aliased to Set-HueLight.
# This gives all lights in the living room a warm glow.
```

#### EXAMPLE 3
```PowerShell
Set-HueLight -Alert select       # Make all of the lights blink once
```

#### EXAMPLE 4
```PowerShell
Set-HueLight -Effect colorloop   # Set all lights to color loop
```

#### EXAMPLE 5
```PowerShell
Set-HueLight -Effect none        # Make all of the lights stop looping color
```

#### EXAMPLE 6
```PowerShell
Set-HueLight -RGBColor "#ff0000" # Make all lights red
```

#### EXAMPLE 7
```PowerShell
Set-HueLight -Hue 120 -Saturation .8 -Brightness .6 # Make all lights green
```

#### EXAMPLE 8
```PowerShell
Set-HueLight -HueIncrement 60    # Move the hue of all lights
```

---
### Parameters
#### **Name**

The name of the Hue light



> **Type**: ```[String[]]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **RoomName**

The name of the Hue room



> **Type**: ```[String[]]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:false



---
#### **LightID**

The identifier of the Hue light



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **GroupID**

The identifier of the Hue group



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:false



---
#### **TransitionTime**

The transition time.  This is how long it will take light to change from it's current state to the one you've set



> **Type**: ```[TimeSpan]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **On**

If set, will switch the light on



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Off**

If set, will switch the light off



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **RGBColor**

Sets lights to an RGB color



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Hue**

The desired hue (ranged 0-360)



> **Type**: ```[Single]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Saturation**

The desired saturation (ranged 0-1)



> **Type**: ```[Single]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Brightness**

The desired brightness (ranged 0-1)



> **Type**: ```[Single]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Effect**

The effect



Valid Values:

* colorloop
* none



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Alert**

The alert



Valid Values:

* select
* lselect
* none



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **ColorTemperature**

The color temperature as a Mired value.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **XY**

The color, in XY coordinates.



> **Type**: ```[Single[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **SaturationIncrement**

The increment in saturation.  This will adjust the intensity of the color.



> **Type**: ```[Single]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **BrightnessIncrement**

An increment in luminance.  This will adjust the brightness of the light.



> **Type**: ```[Single]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **HueIncrement**

An increment in hue.  This will adjust the hue



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **ColorTemperatureIncrement**

A change in the color temperature.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **OutputInput**

If set, will output the data that would be sent to the bridge.  This is useful for creating scheudles, routines, and other macros.



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
### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Set-HueLight [[-TransitionTime] <TimeSpan>] [-On] [-Off] [-RGBColor <String>] [-Hue <Single>] [-Saturation <Single>] [-Brightness <Single>] [-Effect <String>] [-Alert <String>] [-ColorTemperature <Int32>] [-XY <Single[]>] [-SaturationIncrement <Single>] [-BrightnessIncrement <Single>] [-HueIncrement <Int32>] [-ColorTemperatureIncrement <Int32>] [-OutputInput] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Set-HueLight [-Name] <String[]> [[-TransitionTime] <TimeSpan>] [-On] [-Off] [-RGBColor <String>] [-Hue <Single>] [-Saturation <Single>] [-Brightness <Single>] [-Effect <String>] [-Alert <String>] [-ColorTemperature <Int32>] [-XY <Single[]>] [-SaturationIncrement <Single>] [-BrightnessIncrement <Single>] [-HueIncrement <Int32>] [-ColorTemperatureIncrement <Int32>] [-OutputInput] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Set-HueLight [-RoomName] <String[]> [[-TransitionTime] <TimeSpan>] [-On] [-Off] [-RGBColor <String>] [-Hue <Single>] [-Saturation <Single>] [-Brightness <Single>] [-Effect <String>] [-Alert <String>] [-ColorTemperature <Int32>] [-XY <Single[]>] [-SaturationIncrement <Single>] [-BrightnessIncrement <Single>] [-HueIncrement <Int32>] [-ColorTemperatureIncrement <Int32>] [-OutputInput] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Set-HueLight [-LightID] <String> [[-TransitionTime] <TimeSpan>] [-On] [-Off] [-RGBColor <String>] [-Hue <Single>] [-Saturation <Single>] [-Brightness <Single>] [-Effect <String>] [-Alert <String>] [-ColorTemperature <Int32>] [-XY <Single[]>] [-SaturationIncrement <Single>] [-BrightnessIncrement <Single>] [-HueIncrement <Int32>] [-ColorTemperatureIncrement <Int32>] [-OutputInput] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Set-HueLight [-GroupID] <String> [[-TransitionTime] <TimeSpan>] [-On] [-Off] [-RGBColor <String>] [-Hue <Single>] [-Saturation <Single>] [-Brightness <Single>] [-Effect <String>] [-Alert <String>] [-ColorTemperature <Int32>] [-XY <Single[]>] [-SaturationIncrement <Single>] [-BrightnessIncrement <Single>] [-HueIncrement <Int32>] [-ColorTemperatureIncrement <Int32>] [-OutputInput] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---
