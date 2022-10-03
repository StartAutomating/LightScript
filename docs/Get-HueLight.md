
Get-HueLight
------------
### Synopsis
Gets Hue lights

---
### Description

Gets Hue lights from the Hue Bridge.

---
### Related Links
* [Get-HueBridge](Get-HueBridge.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-HueLight
```

---
### Parameters
#### **Name**

The name of the light



> **Type**: ```[String[]]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:false



---
#### **RegularExpression**

If set, will match patterns as regular expressions



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **ExactMatch**

If set, will only match exact text



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Room**

The name of the room.



> **Type**: ```[String[]]```

> **Required**: true

> **Position**: named

> **PipelineInput**:false



---
#### **LightID**

The light ID.



> **Type**: ```[Int32]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **New**

If set, will get recently added lights.



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Get-HueLight [-RegularExpression] [-ExactMatch] [<CommonParameters>]
```
```PowerShell
Get-HueLight [-Name] <String[]> [-RegularExpression] [-ExactMatch] [<CommonParameters>]
```
```PowerShell
Get-HueLight [-RegularExpression] [-ExactMatch] -Room <String[]> [<CommonParameters>]
```
```PowerShell
Get-HueLight [-RegularExpression] [-ExactMatch] -LightID <Int32> [<CommonParameters>]
```
```PowerShell
Get-HueLight [-RegularExpression] [-ExactMatch] -New [<CommonParameters>]
```
---


