Get-HueBridge
-------------
### Synopsis
Gets Hue Bridges

---
### Description

Gets Hue Bridges registered on the system, and gets Hue bridge resources.

---
### Related Links
* [Find-HueBridge](Find-HueBridge.md)



* [Join-HueBridge](Join-HueBridge.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-HueBridge
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
#### **WhatIf**
-WhatIf is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-WhatIf is used to see what would happen, or return operations without executing them
#### **Confirm**
-Confirm is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-Confirm is used to -Confirm each operation.
    
If you pass ```-Confirm:$false``` you will not be prompted.
    
    
If the command sets a ```[ConfirmImpact("Medium")]``` which is lower than ```$confirmImpactPreference```, you will not be prompted unless -Confirm is passed.

---
### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Get-HueBridge [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Get-HueBridge -Schedule [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Get-HueBridge -Rule [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Get-HueBridge -Scene [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Get-HueBridge -Sensor [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Get-HueBridge -Group [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Get-HueBridge -Configuration [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Get-HueBridge -Capability [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Get-HueBridge -Resource [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Get-HueBridge -Light [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---
