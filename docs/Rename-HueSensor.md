Rename-HueSensor
----------------
### Synopsis
Renames Hue Sensors

---
### Description

Renames one or more Hue Sensors.

---
### Related Links
* [Get-HueBridge](Get-HueBridge.md)



* [Get-HueSensor](Get-HueSensor.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Rename-HueSensor
```

---
### Parameters
#### **OldName**

The old name of the Sensor.  This can be a wildcard or regular expression.



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **NewName**

The new name of the Sensor.  A number sign will be replaced with the match number.



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
Rename-HueSensor [-OldName] <String> [-NewName] <String> [<CommonParameters>]
```
---
