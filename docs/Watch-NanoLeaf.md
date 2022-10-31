Watch-NanoLeaf
--------------
### Synopsis
Watches a NanoLeaf for touch events

---
### Description

Watches a NanoLeaf for touch events.


A background job is launched to monitor for UDP messages from a given Nanoleaf.

These messages are unpacked and translated into PowerShell events:

* NanoLeaf.Touch.Hover
* NanoLeaf.Touch.Hold
* NanoLeaf.Touch.Down
* NanoLeaf.Touch.Up
* NanoLeaf.Touch.Swipe

---
### Related Links
* [Get-NanoLeaf](Get-NanoLeaf.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Watch-NanoLeaf
```

---
### Parameters
#### **IPAddress**

The IP Address of the NanoLeaf.



> **Type**: ```[IPAddress]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **NanoLeafToken**

The nanoleaf token



> **Type**: ```[String]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **TouchEventsPort**

The UDP port used for TouchStreamData



> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
### Outputs
* [Management.Automation.Job](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.Job)




---
### Syntax
```PowerShell
Watch-NanoLeaf [[-IPAddress] <IPAddress>] [[-NanoLeafToken] <String>] [[-TouchEventsPort] <String>] [<CommonParameters>]
```
---
