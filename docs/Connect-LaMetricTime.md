Connect-LaMetricTime
--------------------

### Synopsis
Connects to a LaMetric clock

---

### Description

Connects to a LaMetric clock.

LaMetric Time devices require a local ApiKey.

Unfortunately, there is no way to get this key automatically.

To Connect-LaMetricTime, you'll need to visit [developer.lametric.com](https://developer.lametric.com) and sign in.

You will find API Keys for your devices at [developer.lametric.com/user/devices](https://developer.lametric.com/user/devices).

---

### Related Links
* [Get-LaMetricTime](Get-LaMetricTime.md)

* [Disconnect-LaMetricTime](Disconnect-LaMetricTime.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Connect-LaMetric -IPAddress $laMetricIP -ApiKey $myApiKey -PassThru
```

---

### Parameters
#### **IPAddress**
The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.

|Type         |Required|Position|PipelineInput        |Aliases              |
|-------------|--------|--------|---------------------|---------------------|
|`[IPAddress]`|true    |1       |true (ByPropertyName)|LaMetricTimeIPAddress|

#### **ApiKey**
The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.

|Type      |Required|Position|PipelineInput        |Aliases           |
|----------|--------|--------|---------------------|------------------|
|`[String]`|true    |2       |true (ByPropertyName)|LaMetricTimeApiKey|

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
Connect-LaMetricTime [-IPAddress] <IPAddress> [-ApiKey] <String> [-PassThru] [<CommonParameters>]
```
