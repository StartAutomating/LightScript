
Disconnect-HueBridge
--------------------
### Synopsis
Disconnects a Hue Bridge.

---
### Description

Disconnects a new Hue Bridge and removes connection information.

---
### Related Links
* [Connect-HueBridge](Connect-HueBridge.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Disconnect-HueBridge -HueBridgeIP 1.2.3.4
```

---
### Parameters
#### **HueBridgeIP**

The IP Address of the Hue Bridge



|Type             |Requried|Postion|PipelineInput        |
|-----------------|--------|-------|---------------------|
|```[IPAddress]```|true    |named  |true (ByPropertyName)|
---
### Outputs
System.Nullable


System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Disconnect-HueBridge [<CommonParameters>]
```
```PowerShell
Disconnect-HueBridge -HueBridgeIP <IPAddress> [<CommonParameters>]
```
---


