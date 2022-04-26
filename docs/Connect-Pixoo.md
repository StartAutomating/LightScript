
Connect-Pixoo
-------------
### Synopsis
Connects to a Pixoo

---
### Description

Connects to a Pixoo over Wifi

---
### Related Links
* [](Get-Pixoo.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Connect-Pixoo 1.2.3.4 -PassThru
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
Connect-Pixoo [-IPAddress] <IPAddress> [-PassThru] [<CommonParameters>]
```
---


