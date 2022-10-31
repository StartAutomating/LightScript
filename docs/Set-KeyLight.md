Set-KeyLight
------------
### Synopsis
Sets Elgato Key Lighting

---
### Description

Changes Elgato Key Lighting

---
### Related Links
* [Get-KeyLight](Get-KeyLight.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Set-KeyLight -Brightness .5
```

---
### Parameters
#### **IPAddress**

One or more IP Addresses of Elgato Key Lighting devices.



> **Type**: ```[IPAddress[]]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Brightness**

Sets the brightness of all lights in a fixture
When passed with -Hue and -Saturation, sets the color
When passed with no other parameters, adjusts the absolute brightness



> **Type**: ```[Single]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **On**

If set, will turn the light on.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Off**

If set, will turn the light on.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **ColorTemperature**

The color temperature as a Mired value.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 3

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
### Syntax
```PowerShell
Set-KeyLight [[-IPAddress] <IPAddress[]>] [[-Brightness] <Single>] [-On] [-Off] [[-ColorTemperature] <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---
