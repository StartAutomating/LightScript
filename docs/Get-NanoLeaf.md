
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



> **Type**: ```[IPAddress]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **NanoLeafToken**

The nanoleaf authorization token.



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Panel**

If set, will get information about NanoLeaf panels.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Layout**

If set, will get information about NanoLeaf layout.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **EffectName**

If provided, will get information about a particular NanoLeaf effect



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **ListPlugin**

If provided, will get information about the plugins available to use in Nanoleaf effects.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **PluginType**

If provided, will filter out plugins of a particular type.
Valid for plugins and effects.



Valid Values:

* Rhythm
* Color



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **ListEffectName**

If set, will return a string list of effect names.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **ListEffect**

If set, will return a string list of effect names.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **CurrentEffect**

If set, will display information about the current effect.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Force**

If set, will refresh connections to all nanoleafs



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Get-NanoLeaf [-NanoLeafToken <String>] [-Panel] [-Layout] [-EffectName <String>] [-ListPlugin] [-PluginType <String>] [-ListEffectName] [-ListEffect] [-CurrentEffect] [-Force] [<CommonParameters>]
```
```PowerShell
Get-NanoLeaf -IPAddress <IPAddress> [-NanoLeafToken <String>] [-Panel] [-Layout] [-EffectName <String>] [-ListPlugin] [-PluginType <String>] [-ListEffectName] [-ListEffect] [-CurrentEffect] [-Force] [<CommonParameters>]
```
---


