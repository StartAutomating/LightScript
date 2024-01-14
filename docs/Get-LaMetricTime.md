Get-LaMetricTime
----------------

### Synopsis
Gets LaMetricTime

---

### Description

Gets LaMetricTime devices.

---

### Related Links
* [Connect-LaMetricTime](Connect-LaMetricTime.md)

* [Set-LaMetricTime](Set-LaMetricTime.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-LaMetricTime
```
> EXAMPLE 2

```PowerShell
Get-LaMetricTime -Audio         # Gets audio settings
```
> EXAMPLE 3

```PowerShell
Get-LaMetricTime -Bluetooth     # Gets bluetooth settings
```
> EXAMPLE 4

```PowerShell
Get-LaMetricTime -Notification  # Gets notifications (there may be none)
```
> EXAMPLE 5

```PowerShell
Get-LaMetricTime -Audio         # Gets audio settings
```

---

### Parameters
#### **IPAddress**
One or more IP Addresses of LaMetricTime devices.

|Type           |Required|Position|PipelineInput        |Aliases              |
|---------------|--------|--------|---------------------|---------------------|
|`[IPAddress[]]`|false   |named   |true (ByPropertyName)|LaMetricTimeIPAddress|

#### **Application**
If set, will get apps from an LaMetric device.

|Type      |Required|Position|PipelineInput|Aliases                      |
|----------|--------|--------|-------------|-----------------------------|
|`[Switch]`|true    |named   |false        |App<br/>Apps<br/>Applications|

#### **Audio**
If set, will get audio settings of an LaMetric Time device

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|true    |named   |false        |

#### **Bluetooth**
If set, will get bluetooth settings of an LaMetric Time device

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|true    |named   |false        |

#### **Display**
If set, will get display settings of an LaMetric Time device

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|true    |named   |false        |

#### **Notification**
If set, will get LaMetric Time notifications

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[Switch]`|true    |named   |false        |Notifications|

#### **Package**
If set, will get details about a particular package of an LaMetric Time device.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |named   |true (ByPropertyName)|

#### **WiFi**
If set, will get wifi settings of an LaMetric Time device

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|true    |named   |false        |

---

### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)

---

### Syntax
```PowerShell
Get-LaMetricTime [-IPAddress <IPAddress[]>] [<CommonParameters>]
```
```PowerShell
Get-LaMetricTime [-IPAddress <IPAddress[]>] -Application [<CommonParameters>]
```
```PowerShell
Get-LaMetricTime [-IPAddress <IPAddress[]>] -Audio [<CommonParameters>]
```
```PowerShell
Get-LaMetricTime [-IPAddress <IPAddress[]>] -Bluetooth [<CommonParameters>]
```
```PowerShell
Get-LaMetricTime [-IPAddress <IPAddress[]>] -Display [<CommonParameters>]
```
```PowerShell
Get-LaMetricTime [-IPAddress <IPAddress[]>] -Notification [<CommonParameters>]
```
```PowerShell
Get-LaMetricTime [-IPAddress <IPAddress[]>] -Package <String> [<CommonParameters>]
```
```PowerShell
Get-LaMetricTime [-IPAddress <IPAddress[]>] -WiFi [<CommonParameters>]
```
