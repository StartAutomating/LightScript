Connect-HueBridge
-----------------

### Synopsis
Connects to a new Hue Bridge.

---

### Description

Connects to a new Hue Bridge and saves connection information for later use.

You must have physical access to the Hue Bridge controller.

To demostrate your access,
hold the link button on the Hue bridge until the lights flash.

Then run this command within the next 30 seconds.

---

### Related Links
* [Find-HueBridge](Find-HueBridge.md)

* [Get-HueBridge](Get-HueBridge.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Find-HueBridge | Connect-HueBridge
```

---

### Parameters
#### **HueBridgeIP**
The IP Address of the Hue Bridge
This can be provided by piping Find-HueBridge to Connect-HueBridge.

|Type         |Required|Position|PipelineInput        |Aliases  |
|-------------|--------|--------|---------------------|---------|
|`[IPAddress]`|true    |named   |true (ByPropertyName)|IPAddress|

#### **DeviceID**
The device identifier.
This can be provided by piping Find-HueBridge to Connect-HueBridge.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

---

### Outputs
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)

* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)

---

### Syntax
```PowerShell
Connect-HueBridge [-DeviceID <String>] [<CommonParameters>]
```
```PowerShell
Connect-HueBridge -HueBridgeIP <IPAddress> [-DeviceID <String>] [<CommonParameters>]
```
