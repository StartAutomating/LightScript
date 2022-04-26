
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



|Type             |Requried|Postion|PipelineInput        |
|-----------------|--------|-------|---------------------|
|```[IPAddress]```|false   |1      |true (ByPropertyName)|
---
#### **NanoLeafToken**

The nanoleaf token



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |2      |true (ByPropertyName)|
---
#### **TouchEventsPort**

The UDP port used for TouchStreamData



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |3      |true (ByPropertyName)|
---
### Outputs
System.Management.Automation.Job


---
### Syntax
```PowerShell
Watch-NanoLeaf [[-IPAddress] <IPAddress>] [[-NanoLeafToken] <String>] [[-TouchEventsPort] <String>] [<CommonParameters>]
```
---


