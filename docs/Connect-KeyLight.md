
Connect-KeyLight
----------------
### Synopsis
Connects to a Elgato Key Lighting

---
### Description

Connects to a Elgato Key Lighting over Wifi

---
### Related Links
* [Get-KeyLight](Get-KeyLight.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Connect-KeyLight 1.2.3.4 -PassThru
```

---
### Parameters
#### **IPAddress**

The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.



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
### Outputs
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)


* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Connect-KeyLight [-IPAddress] <IPAddress> [-PassThru] [<CommonParameters>]
```
---


