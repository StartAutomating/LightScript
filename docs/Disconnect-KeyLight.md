
Disconnect-KeyLight
-------------------
### Synopsis
Disconnects a Elgato Key Lighting

---
### Description

Disconnects a Elgato Key Lighting, removing stored device info

---
### Related Links
* [Connect-KeyLight](Connect-KeyLight.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Disconnect-KeyLight 1.2.3.4
```

---
### Parameters
#### **IPAddress**

The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.



|Type             |Requried|Postion|PipelineInput        |
|-----------------|--------|-------|---------------------|
|```[IPAddress]```|true    |1      |true (ByPropertyName)|
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
System.Nullable


System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Disconnect-KeyLight [-IPAddress] <IPAddress> [-WhatIf] [-Confirm] [<CommonParameters>]
```
---


