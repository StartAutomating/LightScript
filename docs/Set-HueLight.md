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
> EXAMPLE 1

```PowerShell
Set-HueLight -Name *Lightstrip* -Luminance 0.05 # Set any Hue lights named Hue lightstrip to be very dim
```
> EXAMPLE 2

```PowerShell
LivingRoom -On -ColorTemperature 500 -Brightness .1
# Room names and light names are automatically aliased to Set-HueLight.
# This gives all lights in the living room a warm glow.
```
> EXAMPLE 3

```PowerShell
Set-HueLight -Alert select       # Make all of the lights blink once
```
> EXAMPLE 4

```PowerShell
Set-HueLight -Effect colorloop   # Set all lights to color loop
```
> EXAMPLE 5

```PowerShell
Set-HueLight -Effect none        # Make all of the lights stop looping color
```
> EXAMPLE 6

```PowerShell
Set-HueLight -RGBColor "#ff0000" # Make all lights red
```
> EXAMPLE 7

```PowerShell
Set-HueLight -Hue 120 -Saturation .8 -Brightness .6 # Make all lights green
```
> EXAMPLE 8

```PowerShell
Set-HueLight -HueIncrement 60    # Move the hue of all lights
```

---

### Parameters
#### **Name**
The name of the Hue light

|Type        |Required|Position|PipelineInput        |Aliases  |
|------------|--------|--------|---------------------|---------|
|`[String[]]`|true    |1       |true (ByPropertyName)|LightName|

#### **RoomName**
The name of the Hue room

|Type        |Required|Position|PipelineInput|Aliases                     |
|------------|--------|--------|-------------|----------------------------|
|`[String[]]`|true    |1       |false        |Group<br/>GroupName<br/>Room|

#### **LightID**
The identifier of the Hue light

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|

#### **GroupID**
The identifier of the Hue group

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|true    |1       |false        |

#### **TransitionTime**
The transition time.  This is how long it will take light to change from it's current state to the one you've set

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[TimeSpan]`|false   |2       |true (ByPropertyName)|

#### **On**
If set, will switch the light on

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Off**
If set, will switch the light off

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **RGBColor**
Sets lights to an RGB color

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

#### **Hue**
The desired hue (ranged 0-360)

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Single]`|false   |named   |true (ByPropertyName)|H      |

#### **Saturation**
The desired saturation (ranged 0-1)

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Single]`|false   |named   |true (ByPropertyName)|S      |

#### **Brightness**
The desired brightness (ranged 0-1)

|Type      |Required|Position|PipelineInput        |Aliases                       |
|----------|--------|--------|---------------------|------------------------------|
|`[Single]`|false   |named   |true (ByPropertyName)|B<br/>L<br/>Luminance<br/>.bri|

#### **Effect**
The effect
Valid Values:

* colorloop
* none

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

#### **Alert**
The alert
Valid Values:

* select
* lselect
* none

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

#### **ColorTemperature**
The color temperature as a Mired value.

|Type     |Required|Position|PipelineInput        |Aliases                |
|---------|--------|--------|---------------------|-----------------------|
|`[Int32]`|false   |named   |true (ByPropertyName)|CT<br/>TemperatureMired|

#### **XY**
The color, in XY coordinates.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[Single[]]`|false   |named   |true (ByPropertyName)|

#### **SaturationIncrement**
The increment in saturation.  This will adjust the intensity of the color.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Single]`|false   |named   |true (ByPropertyName)|

#### **BrightnessIncrement**
An increment in luminance.  This will adjust the brightness of the light.

|Type      |Required|Position|PipelineInput        |Aliases           |
|----------|--------|--------|---------------------|------------------|
|`[Single]`|false   |named   |true (ByPropertyName)|LuminanceIncrement|

#### **HueIncrement**
An increment in hue.  This will adjust the hue

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |named   |true (ByPropertyName)|

#### **ColorTemperatureIncrement**
A change in the color temperature.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |named   |true (ByPropertyName)|

#### **OutputInput**
If set, will output the data that would be sent to the bridge.  This is useful for creating scheudles, routines, and other macros.

|Type      |Required|Position|PipelineInput        |Aliases                                                                    |
|----------|--------|--------|---------------------|---------------------------------------------------------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputParameter<br/>OutputParameters<br/>OutputArgument<br/>OutputArguments|

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
