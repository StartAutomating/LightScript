
Set-NanoLeaf
------------
### Synopsis
Changes settings on a NanoLeaf.

---
### Description

Changes settings on one or more NanoLeaf controllers.

---
### Related Links
* [Get-NanoLeaf](Get-NanoLeaf.md)
* [Send-NanoLeaf](Send-NanoLeaf.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Set-NanoLeaf -ColorTemperature 1999
```

#### EXAMPLE 2
```PowerShell
Set-NanoLeaf -Hue (Get-Random -Min 0 -Max 360) -Saturation ((Get-Random -Min 0 -Max 1)/100) -Brightness ((Get-Random -Min 0 -Max 1)/100)
```

#### EXAMPLE 3
```PowerShell
Set-NanoLeaf -EffectName Blaze
```

#### EXAMPLE 4
```PowerShell
Set-NanoLeaf -Palette "#fedcba", "#abcdef"  # Fade between two colors
```

#### EXAMPLE 5
```PowerShell
# Flow between two colors
Set-NanoLeaf -Palette "#fedcba", "#abcdef" -PluginName Flow
```

#### EXAMPLE 6
```PowerShell
# Flow downward between two colors
Set-NanoLeaf -Palette "#abcdef", "#890aef" -PluginName Flow -PluginOption @{linDirection="down"}
```

#### EXAMPLE 7
```PowerShell
# Make a color wheel
Set-NanoLeaf -Palette "#012345", "#543210" -PluginName Wheel
```

#### EXAMPLE 8
```PowerShell
# Make a color wheel that rotates as slowly as it can, counter clockwise
Set-NanoLeaf -Palette "#012345", "#543210" -PluginName Wheel -PluginOption @{rotDirection="ccw";delayTime=600;transTime=600}
```

#### EXAMPLE 9
```PowerShell
# Set up a Rhythm based RGB Fireworks
Set-NanoLeaf -Palette "#ff0000", "#000000", "#00ff00", "#000000", "#0000ff", "#000000" -PluginName Fireworks -PluginType Rhythm
```

#### EXAMPLE 10
```PowerShell
# Set up a Rhythm based RGB Fireworks, with a very short flash
Set-NanoLeaf -Palette "#ff0000", "#00ff00", "#0000ff", "#000000" -PluginName Fireworks -PluginType Rhythm -PluginOption @{
    delayTime = 1
    transTime = 1
}
```

#### EXAMPLE 11
```PowerShell
Set-NanoLeaf -Palette "#123456", "#654321", "#abcdef", "#fedcba" -PluginType Rhythm -PluginName 'Dancing Duo'
```

---
### Parameters
#### **Off**

If set, will turn the nanoleaf off



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **On**

If set, will turn the nanoleaf on



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **Hue**

The hue of the NanoLeaf light color.



|Type         |Requried|Postion|PipelineInput|
|-------------|--------|-------|-------------|
|```[Int32]```|false   |1      |false        |
---
#### **HueIncrement**

Increments the hue of the NanoLeaf light color.



|Type         |Requried|Postion|PipelineInput|
|-------------|--------|-------|-------------|
|```[Int32]```|false   |2      |false        |
---
#### **Saturation**

The saturation of the NanoLeaf light color.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Double]```|false   |3      |false        |
---
#### **SaturationIncrement**

Increments the saturation of the NanoLeaf light color.



|Type         |Requried|Postion|PipelineInput|
|-------------|--------|-------|-------------|
|```[Int32]```|false   |4      |false        |
---
#### **Brightness**

The brightness.
If no other parameters are provided, adjusts universal brightness.
If provided with -Hue and -Saturation, sets the color of all panels.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Double]```|false   |5      |true (ByPropertyName)|
---
#### **ColorTemperature**

If set, will change all panels on the nanoleaf to a given color temperature.



|Type         |Requried|Postion|PipelineInput        |
|-------------|--------|-------|---------------------|
|```[Int32]```|false   |6      |true (ByPropertyName)|
---
#### **EffectName**

The name of the effect.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |7      |true (ByPropertyName)|
---
#### **Duration**

The duration to display.  In most contexts, this will be rounded to the nearest second.



|Type            |Requried|Postion|PipelineInput|
|----------------|--------|-------|-------------|
|```[TimeSpan]```|false   |8      |false        |
---
#### **ExternalControl**

If set, will set the NanoLeaf for external control via UDP.
If provided with -Panel, will set panels via UDP.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **PluginName**

The name of the effect plugin.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |9      |true (ByPropertyName)|
---
#### **Palette**

The palette used for an effect.



|Type              |Requried|Postion|PipelineInput        |
|------------------|--------|-------|---------------------|
|```[PSObject[]]```|false   |10     |true (ByPropertyName)|
---
#### **EffectType**

The type of effect.



Valid Values:

* Plugin
* Random
* Flow
* Wheel
* Fade
* Highlight
* Custom
* Static
|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |11     |true (ByPropertyName)|
---
#### **PluginUuid**

The plugin UUID.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |12     |true (ByPropertyName)|
---
#### **PluginType**

The plugin type.



Valid Values:

* Rhythm
* Color
|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |13     |true (ByPropertyName)|
---
#### **Panel**

Detailed colors for each panel.
The key will be the panel ID.
The value will be an RGB color for the panel, followed by an optional timespan.
Timespans will be ignored when sending colors via UDP.



|Type               |Requried|Postion|PipelineInput        |
|-------------------|--------|-------|---------------------|
|```[IDictionary]```|false   |14     |true (ByPropertyName)|
---
#### **EffectOption**

The effect options.

Plugins can use any of the Nanoleaf-approved option types to further control how panels render light.

|Option         | type  | limits               | description                                                               | 
|---------------|-------|----------------------|---------------------------------------------------------------------------|
|transTime      | int   |1-600                 |The time it takes to go from one palette colour to another (tenths/second).|
|loop           | bool  |                      | Indicates whether an animation should loop or not                         |
|linDirection   |string |left, right, up, down | Linear direction, based on user's global orientation                      |
|radDirection   |string |in, out               | Radial direction, based on layout center                                  |
|rotDirection   |string |cw, ccw               | Circular Direction, around the layout center                              |
|delayTime      | int   |0-600                 | How long the plugin will dwell on a palette colour (tenths/second).       |
|nColorsPerFrame|int    |1-50                  | Modifier that indicates how much of a palette is shown on the layout.     |
|mainColorProb  |double |0.0-100.0             | Probability of background colour being used                               |



|Type               |Requried|Postion|PipelineInput        |
|-------------------|--------|-------|---------------------|
|```[IDictionary]```|false   |15     |true (ByPropertyName)|
---
#### **Loop**

If set, will mark the effect to loop.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **AsByteStream**

If set, will set panels using UDP.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **IPAddress**

The IP Address of the NanoLeaf.



|Type             |Requried|Postion|PipelineInput        |
|-----------------|--------|-------|---------------------|
|```[IPAddress]```|false   |16     |true (ByPropertyName)|
---
#### **NanoLeafToken**

The nanoleaf token



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |17     |true (ByPropertyName)|
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
System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Set-NanoLeaf [-Off] [-On] [[-Hue] <Int32>] [[-HueIncrement] <Int32>] [[-Saturation] <Double>] [[-SaturationIncrement] <Int32>] [[-Brightness] <Double>] [[-ColorTemperature] <Int32>] [[-EffectName] <String>] [[-Duration] <TimeSpan>] [-ExternalControl] [[-PluginName] <String>] [[-Palette] <PSObject[]>] [[-EffectType] <String>] [[-PluginUuid] <String>] [[-PluginType] <String>] [[-Panel] <IDictionary>] [[-EffectOption] <IDictionary>] [-Loop] [-AsByteStream] [[-IPAddress] <IPAddress>] [[-NanoLeafToken] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---


