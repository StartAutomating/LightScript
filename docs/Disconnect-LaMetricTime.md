Disconnect-LaMetricTime
-----------------------

### Synopsis
Disconnects a LaMetricTime

---

### Description

Disconnects a LaMetricTime, removing stored device info

---

### Related Links
* [Connect-LaMetricTime](Connect-LaMetricTime.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Disconnect-LaMetricTime 1.2.3.4
```

---

### Parameters
#### **IPAddress**
The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.

|Type         |Required|Position|PipelineInput        |Aliases              |
|-------------|--------|--------|---------------------|---------------------|
|`[IPAddress]`|true    |1       |true (ByPropertyName)|LaMetricTimeIPAddress|

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
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)

* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)

---

### Syntax
```PowerShell
Disconnect-LaMetricTime [-IPAddress] <IPAddress> [-WhatIf] [-Confirm] [<CommonParameters>]
```
