
Write-HueSensor
---------------
### Synopsis
Write Hue Sensors

---
### Description

Writes data to sensors on the Hue Bridge

---
### Related Links
* [Read-HueSensor](Read-HueSensor.md)
* [Get-HueSensor](Get-HueSensor.md)
* [Get-HueBridge](Get-HueBridge.md)
* [Add-HueSensor](Add-HueSensor.md)
* [Remove-HueSensor](Remove-HueSensor.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Write-HueSensor -Name ChaseStatus1 -Data @{status=0}
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

If set, will write values from to configuration.  By default, values are written to the sensor state.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **Data**

The data that will be written to the sensor



|Type            |Requried|Postion|PipelineInput |
|----------------|--------|-------|--------------|
|```[PSObject]```|true    |named  |true (ByValue)|
---
#### **OutputInput**

If set, will output the data that would be sent to the bridge.  This is useful for creating scheudles, routines, and other macros.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
### Outputs
System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Write-HueSensor [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Config] -Data <PSObject> [-OutputInput] [<CommonParameters>]
```
---


