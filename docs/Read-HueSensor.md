
Read-HueSensor
--------------
### Synopsis
Reads Hue Sensors

---
### Description

Reads Sensors values from the Hue Bridge

---
### Related Links
* [Write-HueSensor](Write-HueSensor.md)
* [Get-HueSensor](Get-HueSensor.md)
* [Get-HueBridge](Get-HueBridge.md)
* [Add-HueSensor](Add-HueSensor.md)
* [Remove-HueSensor](Remove-HueSensor.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Read-HueSensor -Name Daylight
```

---
### Parameters
#### **Name**

If provided, will filter returned items by name



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |1      |true (ByPropertyName)|
---
#### **RegularExpression**

If set, will treat the Name parameter as a regular expression pattern.  By default, Name will be treated as a wildcard



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **ExactMatch**

If set, will treat the Name parameter as a specific match



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **ID**

If provided, will filter returned items by ID



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |named  |true (ByPropertyName)|
---
#### **Config**

If set, will read values from the configuration.  By default, values are read from the sensor state.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
### Outputs
System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Read-HueSensor [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Config] [<CommonParameters>]
```
---


