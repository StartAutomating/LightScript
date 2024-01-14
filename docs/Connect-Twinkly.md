Connect-Twinkly
---------------

### Synopsis
Connects to a Twinkly light controller.

---

### Description

Connects to a Twinkly light controller

---

### Related Links
* [Get-Twinkly](Get-Twinkly.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Connect-Twinkly 192.168.0.144 -PassThru
```

---

### Parameters
#### **IPAddress**
The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.

|Type         |Required|Position|PipelineInput        |Aliases         |
|-------------|--------|--------|---------------------|----------------|
|`[IPAddress]`|true    |1       |true (ByPropertyName)|TwinklyIPAddress|

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
Connect-Twinkly [-IPAddress] <IPAddress> [-PassThru] [<CommonParameters>]
```
