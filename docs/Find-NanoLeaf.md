
Find-NanoLeaf
-------------
### Synopsis
Finds NanoLeaf controllers

---
### Description

Finds NanoLeaf controllers on your local area network, using SSDP.

---
### Related Links
* [](Connect-NanoLeaf.md)
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



|Type         |Requried|Postion|PipelineInput        |
|-------------|--------|-------|---------------------|
|```[Int32]```|false   |1      |true (ByPropertyName)|
---
#### **Force**

If set, will force a rescan of the network.
Otherwise, the most recent cached result will be returned.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **DeviceType**

The type of the device to find.  By default, ssdp:all.
Changing this value is unlikely to find any NanoLeaf controllers, but you can see other devices with -Verbose.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |2      |true (ByPropertyName)|
---
### Outputs
Roku.BasicInfo


---
### Syntax
```PowerShell
Find-NanoLeaf [[-SearchTimeout] <Int32>] [-Force] [[-DeviceType] <String>] [<CommonParameters>]
```
---


