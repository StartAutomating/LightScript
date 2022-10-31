Send-NanoLeaf
-------------
### Synopsis
Sends messages to a NanoLeaf

---
### Description

Sends HTTP messages to a NanoLeaf

---
### Related Links
* [Get-NanoLeaf](Get-NanoLeaf.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Send-NanoLeaf -Command effects/effectsList
```

---
### Parameters
#### **IPAddress**

The IP Address of the NanoLeaf.



> **Type**: ```[IPAddress]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Command**

The URI fragment to send to the nanoleaf.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:false



---
#### **Method**

The HTTP method to send.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **Data**

The data to send.  This will be converted into JSON if it is not a string.



> **Type**: ```[PSObject]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **Property**

A set of additional properties to add to an object



> **Type**: ```[IDictionary]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **RemoveProperty**

A list of property names to remove from an object



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 6

> **PipelineInput**:false



---
#### **ExpandProperty**

If provided, will expand a given property returned from the REST api.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 7

> **PipelineInput**:false



---
#### **PSTypeName**

The typename of the results.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 8

> **PipelineInput**:true (ByPropertyName)



---
#### **NanoLeafToken**

The nanoleaf token



> **Type**: ```[String]```

> **Required**: false

> **Position**: 9

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
Send-NanoLeaf [-IPAddress] <IPAddress> [[-Command] <String>] [[-Method] <String>] [[-Data] <PSObject>] [[-Property] <IDictionary>] [[-RemoveProperty] <String[]>] [[-ExpandProperty] <String>] [[-PSTypeName] <String[]>] [[-NanoLeafToken] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---
