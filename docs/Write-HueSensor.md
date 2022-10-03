
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



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **RegularExpression**

If set, will treat the Name parameter as a regular expression pattern.  By default, Name will be treated as a wildcard



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **ExactMatch**

If set, will treat the Name parameter as a specific match



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **ID**

If provided, will filter returned items by ID



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Config**

If set, will write values from to configuration.  By default, values are written to the sensor state.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Data**

The data that will be written to the sensor



> **Type**: ```[PSObject]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByValue)



---
#### **OutputInput**

If set, will output the data that would be sent to the bridge.  This is useful for creating scheudles, routines, and other macros.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Write-HueSensor [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Config] -Data <PSObject> [-OutputInput] [<CommonParameters>]
```
---


