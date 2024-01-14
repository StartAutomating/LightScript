Disconnect-HueBridge
--------------------

### Synopsis
Disconnects a Hue Bridge.

---

### Description

Disconnects a new Hue Bridge and removes connection information.

---

### Related Links
* [Connect-HueBridge](Connect-HueBridge.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Disconnect-HueBridge -HueBridgeIP 1.2.3.4
```

---

### Parameters
#### **HueBridgeIP**
The IP Address of the Hue Bridge

|Type         |Required|Position|PipelineInput        |Aliases  |
|-------------|--------|--------|---------------------|---------|
|`[IPAddress]`|true    |named   |true (ByPropertyName)|IPAddress|

---

### Outputs
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)

* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)

---

### Syntax
```PowerShell
Disconnect-HueBridge [<CommonParameters>]
```
```PowerShell
Disconnect-HueBridge -HueBridgeIP <IPAddress> [<CommonParameters>]
```
