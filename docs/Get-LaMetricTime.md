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
#### EXAMPLE 1
```PowerShell
Get-LaMetricTime
```

#### EXAMPLE 2
```PowerShell
Get-LaMetricTime -Audio         # Gets audio settings
```

#### EXAMPLE 3
```PowerShell
Get-LaMetricTime -Bluetooth     # Gets bluetooth settings
```

#### EXAMPLE 4
```PowerShell
Get-LaMetricTime -Notification  # Gets notifications (there may be none)
```

#### EXAMPLE 5
```PowerShell
Get-LaMetricTime -Audio         # Gets audio settings
```

---
### Parameters
#### **IPAddress**

One or more IP Addresses of LaMetricTime devices.



> **Type**: ```[IPAddress[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Application**

If set, will get apps from an LaMetric device.



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:false



---
#### **Audio**

If set, will get audio settings of an LaMetric Time device



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:false



---
#### **Bluetooth**

If set, will get bluetooth settings of an LaMetric Time device



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:false



---
#### **Display**

If set, will get display settings of an LaMetric Time device



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:false



---
#### **Notification**

If set, will get LaMetric Time notifications



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:false



---
#### **Package**

If set, will get details about a particular package of an LaMetric Time device.



> **Type**: ```[String]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **WiFi**

If set, will get wifi settings of an LaMetric Time device



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:false



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
---
