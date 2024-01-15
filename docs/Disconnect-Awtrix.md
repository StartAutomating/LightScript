Disconnect-Awtrix
-----------------

### Synopsis
Disconnects an Awtrix clock.

---

### Description

Disconnects an Ulzani Smart Clock using an Awtrix controller

---

### Related Links
* [Connect-Awrtrix](Connect-Awrtrix.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Disconnect-Awtrix 192.168.0.160
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
Disconnect-Awtrix [-IPAddress] <IPAddress> [-PassThru] [<CommonParameters>]
```
