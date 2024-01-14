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
> EXAMPLE 1

```PowerShell
Rename-HueLight
```

---

### Parameters
#### **OldName**
The old name of the light.  This can be a wildcard or regular expression.

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[String]`|true    |1       |true (ByPropertyName)|ID     |

#### **NewName**
The new name of the light.  A number sign will be replaced with the match number.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |2       |true (ByPropertyName)|

---

### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)

---

### Syntax
```PowerShell
Rename-HueLight [-OldName] <String> [-NewName] <String> [<CommonParameters>]
```
