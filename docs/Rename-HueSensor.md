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
> EXAMPLE 1

```PowerShell
Rename-HueSensor
```

---

### Parameters
#### **OldName**
The old name of the Sensor.  This can be a wildcard or regular expression.

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[String]`|true    |1       |true (ByPropertyName)|ID     |

#### **NewName**
The new name of the Sensor.  A number sign will be replaced with the match number.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |2       |true (ByPropertyName)|

---

### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)

---

### Syntax
```PowerShell
Rename-HueSensor [-OldName] <String> [-NewName] <String> [<CommonParameters>]
```
