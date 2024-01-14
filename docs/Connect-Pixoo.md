Connect-Pixoo
-------------

### Synopsis
Connects to a Pixoo

---

### Description

Connects to a Pixoo over Wifi

---

### Related Links
* [Get-Pixoo](Get-Pixoo.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Find-Pixoo | Connect-Pixoo
```

---

### Parameters
#### **IPAddress**
The IP Address for the Pixoo device.
This can be discovered using Find-Pixoo.

|Type         |Required|Position|PipelineInput        |Aliases                           |
|-------------|--------|--------|---------------------|----------------------------------|
|`[IPAddress]`|true    |1       |true (ByPropertyName)|PixooIPAddress<br/>DevicePrivateIP|

#### **PassThru**
If set, will output the connection information.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **DeviceId**
The DeviceID.  This can be provided by Find-Pixoo

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
Connect-Pixoo [-IPAddress] <IPAddress> [-PassThru] [-DeviceId <String>] [<CommonParameters>]
```
