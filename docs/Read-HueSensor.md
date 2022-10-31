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

If set, will read values from the configuration.  By default, values are read from the sensor state.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Read-HueSensor [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Config] [<CommonParameters>]
```
---
