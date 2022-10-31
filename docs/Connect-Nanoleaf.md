Connect-Nanoleaf
----------------
### Synopsis
Connects to a new Nanoleaf controller.

---
### Description

Connects to a new Nanoleaf controller and saves connection information for later use.

This will return "Unauthorized" unless you have physical access to the nanoleaf controller.

To demostrate your access, hold the power button down on the controller until the
nanoleaf controller lights flash in sequence.  Then run this command within the next 30 seconds.

---
### Related Links
* [Find-NanoLeaf](Find-NanoLeaf.md)



* [Get-NanoLeaf](Get-NanoLeaf.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Find-NanoLeaf | Connect-NanoLeaf
```

---
### Parameters
#### **NanoLeafIP**

The IP Address of the Nanoleaf



> **Type**: ```[IPAddress]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Outputs
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)


* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Connect-Nanoleaf [<CommonParameters>]
```
```PowerShell
Connect-Nanoleaf -NanoLeafIP <IPAddress> [<CommonParameters>]
```
---
