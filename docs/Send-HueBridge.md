Send-HueBridge
--------------
### Synopsis
Sends messages to a HueBridge

---
### Description

Sends messages to a Hue Bridge

---
### Related Links
* [Get-HueBridge](Get-HueBridge.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-HueBridge | Send-HueBridge -Command lights
```

---
### Parameters
#### **IPAddress**

The IP address of the hue bridge.



> **Type**: ```[IPAddress]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **HueUserName**

The hue user name



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **Command**

The command being sent to the bridge.  This is a partial URI.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **Body**

The data being sent to the Hue Bridge.
If this data is not a string, it will be converted to JSON.



> **Type**: ```[PSObject]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **Method**

The HTTP method.  By default, Get.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **OutputInput**

If set, will output the data that would be sent to the bridge.
This is useful for creating scheudles, routines, and other macros.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **PSTypeName**

If provided, will set the .pstypenames on output objects.
This enables the PowerShell types and formatting systems.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 6

> **PipelineInput**:true (ByPropertyName)



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
Send-HueBridge [-IPAddress] <IPAddress> [-HueUserName] <String> [[-Command] <String>] [[-Body] <PSObject>] [[-Method] <String>] [-OutputInput] [[-PSTypeName] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---
