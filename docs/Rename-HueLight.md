Rename-HueLight
---------------
### Synopsis
Renames Hue Lights

---
### Description

Renames one or more Hue lights.

---
### Related Links
* [Get-HueBridge](Get-HueBridge.md)



* [Get-HueLight](Get-HueLight.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Rename-HueLight
```

---
### Parameters
#### **OldName**

The old name of the light.  This can be a wildcard or regular expression.



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **NewName**

The new name of the light.  A number sign will be replaced with the match number.



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Rename-HueLight [-OldName] <String> [-NewName] <String> [<CommonParameters>]
```
---
