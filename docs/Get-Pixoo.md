Get-Pixoo
---------
### Synopsis
Gets Pixoo Devices

---
### Description

Gets saved Pixoo Devices

---
### Related Links
* [Connect-Pixoo](Connect-Pixoo.md)



* [Set-Pixoo](Set-Pixoo.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-Pixoo
```

---
### Parameters
#### **IPAddress**

The IP Address for the Pixoo device.
This can be discovered thru the phone user interface or by using Find-Pixoo.



> **Type**: ```[IPAddress[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Weather**

If set, will get the local weather.



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:false



---
### Syntax
```PowerShell
Get-Pixoo [-IPAddress <IPAddress[]>] [<CommonParameters>]
```
```PowerShell
Get-Pixoo [-IPAddress <IPAddress[]>] -Weather [<CommonParameters>]
```
---
