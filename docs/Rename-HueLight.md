
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



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|true    |1      |true (ByPropertyName)|
---
#### **NewName**

The new name of the light.  A number sign will be replaced with the match number.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|true    |2      |true (ByPropertyName)|
---
### Outputs
System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Rename-HueLight [-OldName] <String> [-NewName] <String> [<CommonParameters>]
```
---


