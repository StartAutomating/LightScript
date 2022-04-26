
Set-HueRule
-----------
### Synopsis
Sets a Hue Rule

---
### Description

Sets a Hue Rule.  Hue Rules are used to automatically change your Hue Lights and devices when conditions occur.

---
### Related Links
* [Get-HueRule](Get-HueRule.md)
* [Remove-HueRule](Remove-HueRule.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Set-HueRule -Condition {
    "/sensors/55/state/status" -eq "1"
} -Action {
    Set-HueLight -Name "Sunroom*" -ColorTemperature 420
} -Name BrightenRoom
```

---
### Parameters
#### **Name**

The name of the rule.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[String]```|true    |1      |false        |
---
#### **Condition**

The condition.
If the value is a ScriptBlock, only operators and their surrounding conext will be accepted.



|Type              |Requried|Postion|PipelineInput|
|------------------|--------|-------|-------------|
|```[PSObject[]]```|true    |2      |false        |
---
#### **Action**

The action.
If this value is a Script Block, only commands from this module that have the parameter -OutputInput may be called.
If the input is a ScriptBlock
and has no command expressions
find all commands.
Ensure each command
comes from this module
and has the -OutputInput parameter.
Otherwise, check for the required properties.



|Type              |Requried|Postion|PipelineInput|
|------------------|--------|-------|-------------|
|```[PSObject[]]```|true    |3      |false        |
---
#### **DeviceID**

If provided, the schedule will only run on the bridge with a particular device ID



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |named  |true (ByPropertyName)|
---
#### **IPAddress**

If provided, the schedule will only run on the bridge found at the provided IP address



|Type             |Requried|Postion|PipelineInput        |
|-----------------|--------|-------|---------------------|
|```[IPAddress]```|false   |named  |true (ByPropertyName)|
---
#### **Disable**

If set, will disable the rule.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
### Outputs
System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Set-HueRule [-Name] <String> [-Condition] <PSObject[]> [-Action] <PSObject[]> [-DeviceID <String>] [-IPAddress <IPAddress>] [-Disable] [<CommonParameters>]
```
---


