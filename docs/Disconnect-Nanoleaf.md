Disconnect-Nanoleaf
-------------------
### Synopsis
Disconnects a new Nanoleaf controller.

---
### Description

Disconnnects a new Nanoleaf controller and removes connection information.

---
### Related Links
* [Connect-NanoLeaf](Connect-NanoLeaf.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Disconnect-NanoLeaf -IPAddress 1.2.3.4
```

---
### Parameters
#### **NanoLeafIP**

The IP Address of the Nanoleaf



> **Type**: ```[IPAddress]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **WhatIf**
-WhatIf is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-WhatIf is used to see what would happen, or return operations without executing them
#### **Confirm**
-Confirm is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-Confirm is used to -Confirm each operation.
    
If you pass ```-Confirm:$false``` you will not be prompted.
    
    
If the command sets a ```[ConfirmImpact("Medium")]``` which is lower than ```$confirmImpactPreference```, you will not be prompted unless -Confirm is passed.

---
### Outputs
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)


* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Disconnect-Nanoleaf [-NanoLeafIP] <IPAddress> [-WhatIf] [-Confirm] [<CommonParameters>]
```
---
