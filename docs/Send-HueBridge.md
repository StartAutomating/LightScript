
Send-HueBridge
--------------
### Synopsis
Sends messages to a HueBridge

---
### Description

Sends messages to a Hue Bridge

---
### Related Links
* [](Get-HueBridge.md)
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



|Type             |Requried|Postion|PipelineInput        |
|-----------------|--------|-------|---------------------|
|```[IPAddress]```|true    |1      |true (ByPropertyName)|
---
#### **HueUserName**

The hue user name



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|true    |2      |true (ByPropertyName)|
---
#### **Command**

The command being sent to the bridge.  This is a partial URI.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |3      |true (ByPropertyName)|
---
#### **Data**

The data being sent to the Hue Bridge.
If this data is not a string, it will be converted to JSON.



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[PSObject]```|false   |4      |true (ByPropertyName)|
---
#### **Method**

The HTTP method.  By default, Get.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |5      |true (ByPropertyName)|
---
#### **OutputInput**

If set, will output the data that would be sent to the bridge.
This is useful for creating scheudles, routines, and other macros.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **PSTypeName**

If provided, will set the .pstypenames on output objects.
This enables the PowerShell types and formatting systems.



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |6      |true (ByPropertyName)|
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
System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Send-HueBridge [-IPAddress] <IPAddress> [-HueUserName] <String> [[-Command] <String>] [[-Data] <PSObject>] [[-Method] <String>] [-OutputInput] [[-PSTypeName] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---


