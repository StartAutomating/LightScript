
Clear-Twinkly
-------------
### Synopsis
Clears Twinkly devices

---
### Description

The Twinkly API does not allow for the deletion of specific storage items, and is limited to 16 movies.

This clears the stored movies and playlists

---
### Related Links
* [Get-Twinkly](Get-Twinkly.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Clear-Twinkly
```

---
### Parameters
#### **IPAddress**

One or more IP Addresses of Twinkly devices.



|Type               |Requried|Postion|PipelineInput        |
|-------------------|--------|-------|---------------------|
|```[IPAddress[]]```|false   |1      |true (ByPropertyName)|
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
Clear-Twinkly [[-IPAddress] <IPAddress[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---


