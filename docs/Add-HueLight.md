
Add-HueLight
------------
### Synopsis
Adds lights to Hue

---
### Description

Adds lights to a Hue Bridge.

---
### Related Links
* [Get-HueLight](Get-HueLight.md)
* [Set-HueLight](Set-HueLight.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Add-HueLight # Search for new lights
```

#### EXAMPLE 2
```PowerShell
Add-HueLight -DeviceID $serialNumber # Add a new light by serial number.
```

#### EXAMPLE 3
```PowerShell
Add-HueLight        # Search for new lights
Get-HueLight -New   # Get-HueLight -New will return the new lights
```

---
### Parameters
#### **DeviceID**

One or more Device Identifiers (serial numbers ).
Use this parameter when adding lights that have already been assigned to another bridge.



|Type            |Requried|Postion|PipelineInput|
|----------------|--------|-------|-------------|
|```[String[]]```|false   |1      |false        |
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
### Syntax
```PowerShell
Add-HueLight [[-DeviceID] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---


