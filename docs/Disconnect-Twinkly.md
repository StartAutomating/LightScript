
Disconnect-Twinkly
------------------
### Synopsis
Disconnects a Twinkly light controller.

---
### Description

Disconnects a Twinkly light controller

---
### Related Links
* [](Connect-Twinkly.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Disconnect-Twinkly 192.168.0.144
```

---
### Parameters
#### **IPAddress**

The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.



|Type             |Requried|Postion|PipelineInput        |
|-----------------|--------|-------|---------------------|
|```[IPAddress]```|true    |1      |true (ByPropertyName)|
---
#### **PassThru**

If set, will output the connection information.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
### Outputs
System.Nullable


System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Disconnect-Twinkly [-IPAddress] <IPAddress> [-PassThru] [<CommonParameters>]
```
---


