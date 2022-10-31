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

#### EXAMPLE 2
```PowerShell
# Set a rule that when 
Set-HueRule -Condition {
    "/sensors/61/state/buttonevent" -eq "4002"
} -Action {
    Set-HueLight -RoomName "Sunroom" -Brightness 0.01
} -Name SunroomDimmerTap
```

#### EXAMPLE 3
```PowerShell
Set-HueRule -Condition {
    "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "4003"
} -Action {
    Set-HueLight -RoomName "Sunroom" -Off
} -Name SunroomDimmerHoldDownToTurnOff
```

#### EXAMPLE 4
```PowerShell
Set-HueRule -Condition {
    "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "1003"
} -Action {
    Set-HueLight -RoomName "Sunroom" -On
} -Name SunroomDimmerHoldUpToTurnOn
```

#### EXAMPLE 5
```PowerShell
Set-HueRule -Condition {
    "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "1002"
} -Action {
    Set-HueLight -RoomName "Sunroom" -On -Brightness .8
} -Name SunroomDimmerTapOn
```

#### EXAMPLE 6
```PowerShell
Set-HueRule -Condition {
    "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "2003"
} -Action {
    Set-HueLight -RoomName "Sunroom" -BrightnessIncrement .1
} -Name SunroomDimmerHoldBright
```

#### EXAMPLE 7
```PowerShell
Set-HueRule -Condition {
    "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "2002"
} -Action {
    Set-HueLight -RoomName "Sunroom" -BrightnessIncrement .05
} -Name SunroomDimmerTapBright
```

#### EXAMPLE 8
```PowerShell
Set-HueRule -Condition {
    "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "3002"
} -Action {
    Set-HueLight -RoomName "Sunroom" -BrightnessIncrement -.05
} -Name SunroomDimmerTapDarken
```

#### EXAMPLE 9
```PowerShell
Set-HueRule -Condition {
    "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "3003"
} -Action {
    Set-HueLight -RoomName "Sunroom" -BrightnessIncrement -.1
} -Name SunroomDimmerHoldDarken
```

---
### Parameters
#### **Name**

The name of the rule.



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:false



---
#### **Condition**

The condition.
If the value is a ScriptBlock, only operators and their surrounding conext will be accepted.
Each condition should take the form: `"/resource/id/restOfAddress" -operator "value"`.
Rules may have more than one condition.
If the address is not a resource followed by a digit, the resource will be looked up by name.



> **Type**: ```[PSObject[]]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:false



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



> **Type**: ```[PSObject[]]```

> **Required**: true

> **Position**: 3

> **PipelineInput**:false



---
#### **DeviceID**

If provided, the schedule will only run on the bridge with a particular device ID



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **IPAddress**

If provided, the schedule will only run on the bridge found at the provided IP address



> **Type**: ```[IPAddress]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Disable**

If set, will disable the rule.



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
Set-HueRule [-Name] <String> [-Condition] <PSObject[]> [-Action] <PSObject[]> [-DeviceID <String>] [-IPAddress <IPAddress>] [-Disable] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---
