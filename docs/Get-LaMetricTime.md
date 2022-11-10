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



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-LaMetricTime
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
#### **Package**

> **Type**: ```[String]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



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
Get-LaMetricTime [-IPAddress <IPAddress[]>] -Package <String> [<CommonParameters>]
```
---
