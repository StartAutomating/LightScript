
Get-NanoLeaf
------------
### Synopsis
Gets Nanoleaf controllers.

---
### Description

Gets connected Nanoleaf controllers on the local area network.

Can also get effects

---
### Related Links
* [Connect-NanoLeaf](Connect-NanoLeaf.md)
* [Set-NanoLeaf](Set-NanoLeaf.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Get-NanoLeaf
```

---
### Parameters
#### **IPAddress**

The IP Address of the NanoLeaf controller.



|Type             |Requried|Postion|PipelineInput        |
|-----------------|--------|-------|---------------------|
|```[IPAddress]```|true    |named  |true (ByPropertyName)|
---
#### **NanoLeafToken**

The nanoleaf authorization token.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |named  |true (ByPropertyName)|
---
#### **Panel**

If set, will get information about NanoLeaf panels.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **Layout**

If set, will get information about NanoLeaf layout.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **EffectName**

If provided, will get information about a particular NanoLeaf effect



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |named  |true (ByPropertyName)|
---
#### **ListPlugin**

If provided, will get information about the plugins available to use in Nanoleaf effects.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **PluginType**

If provided, will filter out plugins of a particular type.
Valid for plugins and effects.



Valid Values:

* Rhythm
* Color



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[String]```|false   |named  |false        |
---
#### **ListEffectName**

If set, will return a string list of effect names.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **ListEffect**

If set, will return a string list of effect names.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **CurrentEffect**

If set, will display information about the current effect.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **Force**

If set, will refresh connections to all nanoleafs



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
### Outputs
System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Get-NanoLeaf [-NanoLeafToken <String>] [-Panel] [-Layout] [-EffectName <String>] [-ListPlugin] [-PluginType <String>] [-ListEffectName] [-ListEffect] [-CurrentEffect] [-Force] [<CommonParameters>]
```
```PowerShell
Get-NanoLeaf -IPAddress <IPAddress> [-NanoLeafToken <String>] [-Panel] [-Layout] [-EffectName <String>] [-ListPlugin] [-PluginType <String>] [-ListEffectName] [-ListEffect] [-CurrentEffect] [-Force] [<CommonParameters>]
```
---


