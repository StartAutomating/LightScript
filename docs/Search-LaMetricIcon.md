Search-LaMetricIcon
-------------------
### Synopsis
Searchs for LaMetricIcons

---
### Description

Searches for icons for LaMetric Time and other LaMetric devices.

---
### Related Links
* [Get-LaMetricTime](Get-LaMetricTime.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Search-LaMetricIcon "PowerShell"
```

---
### Parameters
#### **IconName**

The name of the icon we are searching for



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Page**

The page count.  By default, zero.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **PageSize**

The page size.  By default, 100.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Search-LaMetricIcon [-IconName] <String> [-Page <Int32>] [-PageSize <Int32>] [<CommonParameters>]
```
---
