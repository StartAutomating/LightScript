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
> EXAMPLE 1

```PowerShell
Get-HueBridge | Send-HueBridge -Command lights
```

---

### Parameters
#### **IPAddress**
The IP address of the hue bridge.

|Type         |Required|Position|PipelineInput        |
|-------------|--------|--------|---------------------|
|`[IPAddress]`|true    |1       |true (ByPropertyName)|

#### **HueUserName**
The hue user name

|Type      |Required|Position|PipelineInput        |Aliases               |
|----------|--------|--------|---------------------|----------------------|
|`[String]`|true    |2       |true (ByPropertyName)|UserName<br/>AuthToken|

#### **Command**
The command being sent to the bridge.  This is a partial URI.

|Type      |Required|Position|PipelineInput        |Aliases    |
|----------|--------|--------|---------------------|-----------|
|`[String]`|false   |3       |true (ByPropertyName)|Uri<br/>Url|

#### **Body**
The data being sent to the Hue Bridge.
If this data is not a string, it will be converted to JSON.

|Type        |Required|Position|PipelineInput        |Aliases|
|------------|--------|--------|---------------------|-------|
|`[PSObject]`|false   |4       |true (ByPropertyName)|Data   |

#### **Method**
The HTTP method.  By default, Get.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |5       |true (ByPropertyName)|

#### **OutputInput**
If set, will output the data that would be sent to the bridge.
This is useful for creating scheudles, routines, and other macros.

|Type      |Required|Position|PipelineInput        |Aliases                                                                    |
|----------|--------|--------|---------------------|---------------------------------------------------------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputParameter<br/>OutputParameters<br/>OutputArgument<br/>OutputArguments|

#### **PSTypeName**
If provided, will set the .pstypenames on output objects.
This enables the PowerShell types and formatting systems.

|Type        |Required|Position|PipelineInput        |Aliases |
|------------|--------|--------|---------------------|--------|
|`[String[]]`|false   |6       |true (ByPropertyName)|Decorate|

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
