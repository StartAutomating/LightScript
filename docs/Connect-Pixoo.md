Connect-Pixoo
-------------
### Synopsis
Connects to a Pixoo

---
### Description

Connects to a Pixoo over Wifi

---
### Related Links
* [Get-Pixoo](Get-Pixoo.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Find-Pixoo | Connect-Pixoo
```

---
### Parameters
#### **IPAddress**

The IP Address for the Pixoo device.
This can be discovered using Find-Pixoo.



> **Type**: ```[IPAddress]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

If set, will output the connection information.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **DeviceId**

The DeviceID.  This can be provided by Find-Pixoo



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Outputs
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)


* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Connect-Pixoo [-IPAddress] <IPAddress> [-PassThru] [-DeviceId <String>] [<CommonParameters>]
```
---
