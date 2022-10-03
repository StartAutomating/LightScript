
Get-HueResource
---------------
### Synopsis
Gets Hue ResourceLinks

---
### Description

Gets ResourceLinks from one or more Hue Bridges

---
### Related Links
* [Remove-HueResource](Remove-HueResource.md)



* [Get-HueBridge](Get-HueBridge.md)



* [Send-HueBridge](Send-HueBridge.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-HueResource
```

---
### Parameters
#### **Schedule**

If set, will get the schedules defined on the Hue bridge



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Rule**

If set, will get the rules defined on the Hue bridge



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Scene**

If set, will get the scenes defined on the Hue bridge



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Sensor**

If set, will get the sensors defined on the Hue bridge



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Group**

If set, will get the groups (or rooms) defined on the Hue bridge



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Configuration**

If set, will get the device configuration



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Capability**

If set, will get the device capabilities



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Resource**

If set, will get resources defined on the device



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Light**

If set, will get the lights defined on the device



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
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
#### **Detailed**

If set, will requery each returned resource to retreive additional information.



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
Get-HueResource [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueResource -Schedule [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueResource -Rule [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueResource -Scene [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueResource -Sensor [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueResource -Group [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueResource -Configuration [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueResource -Capability [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueResource -Resource [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueResource -Light [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
---


