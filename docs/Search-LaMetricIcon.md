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
> EXAMPLE 1

```PowerShell
Search-LaMetricIcon "PowerShell"
```

---

### Parameters
#### **IconName**
The name of the icon we are searching for

|Type      |Required|Position|PipelineInput        |Aliases                 |
|----------|--------|--------|---------------------|------------------------|
|`[String]`|true    |1       |true (ByPropertyName)|Title<br/>Query<br/>Name|

#### **Page**
The page count.  By default, zero.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |named   |true (ByPropertyName)|

#### **PageSize**
The page size.  By default, 100.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |named   |true (ByPropertyName)|

---

### Syntax
```PowerShell
Search-LaMetricIcon [-IconName] <String> [-Page <Int32>] [-PageSize <Int32>] [<CommonParameters>]
```
