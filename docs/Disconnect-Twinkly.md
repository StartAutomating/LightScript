Disconnect-Twinkly
------------------
### Synopsis
Disconnects a Twinkly light controller.

---
### Description

Disconnects a Twinkly light controller

---
### Related Links
* [Connect-Twinkly](Connect-Twinkly.md)



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
Disconnect-Twinkly [-IPAddress] <IPAddress> [-PassThru] [<CommonParameters>]
```
---
