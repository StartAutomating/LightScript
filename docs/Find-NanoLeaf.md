
Find-NanoLeaf
-------------
### Synopsis
Finds NanoLeaf controllers

---
### Description

Finds NanoLeaf controllers on your local area network, using SSDP.

---
### Related Links
* [Connect-NanoLeaf](Connect-NanoLeaf.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Find-NanoLeaf | Connect-NanoLeaf
```

---
### Parameters
#### **SearchTimeout**

The search timeout, in seconds.  Increase this number on slower networks.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Force**

If set, will force a rescan of the network.
Otherwise, the most recent cached result will be returned.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **DeviceType**

The type of the device to find.  By default, ssdp:all.
Changing this value is unlikely to find any NanoLeaf controllers, but you can see other devices with -Verbose.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
### Outputs
* Roku.BasicInfo




---
### Syntax
```PowerShell
Find-NanoLeaf [[-SearchTimeout] <Int32>] [-Force] [[-DeviceType] <String>] [<CommonParameters>]
```
---


