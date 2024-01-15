Connect-Awtrix
--------------

### Synopsis
Connects to a Awtrix light controller.

---

### Description

Connects to a Awtrix light controller

---

### Related Links
* [Get-Awtrix](Get-Awtrix.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Connect-Awtrix 192.168.0.160 -PassThru
```

---

### Parameters
#### **IPAddress**
The IP Address for the Awtrix device.
Once you flash the device, this should be displayed on boot and accessible in the web interface.

|Type         |Required|Position|PipelineInput        |Aliases        |
|-------------|--------|--------|---------------------|---------------|
|`[IPAddress]`|true    |1       |true (ByPropertyName)|AwtrixIPAddress|

#### **PassThru**
If set, will output the connection information.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

---

### Outputs
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)

* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)

---

### Syntax
```PowerShell
Connect-Awtrix [-IPAddress] <IPAddress> [-PassThru] [<CommonParameters>]
```
