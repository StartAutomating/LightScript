Get-HueRule
-----------

### Synopsis
Gets Hue Rules

---

### Description

Gets Rules from one or more Hue Bridges

---

### Related Links
* [Remove-HueRule](Remove-HueRule.md)

* [Get-HueBridge](Get-HueBridge.md)

* [Send-HueBridge](Send-HueBridge.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-HueRule
```

---

### Parameters
#### **Schedule**
If set, will get the schedules defined on the Hue bridge

|Type      |Required|Position|PipelineInput        |Aliases                       |
|----------|--------|--------|---------------------|------------------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|Schedules<br/>Timer<br/>Timers|

#### **Rule**
If set, will get the rules defined on the Hue bridge

|Type      |Required|Position|PipelineInput        |Aliases                       |
|----------|--------|--------|---------------------|------------------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|Rules<br/>Trigger<br/>Triggers|

#### **Scene**
If set, will get the scenes defined on the Hue bridge

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Switch]`|true    |named   |true (ByPropertyName)|Scenes |

#### **Sensor**
If set, will get the sensors defined on the Hue bridge

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Switch]`|true    |named   |true (ByPropertyName)|Sensors|

#### **Group**
If set, will get the groups (or rooms) defined on the Hue bridge

|Type      |Required|Position|PipelineInput        |Aliases                  |
|----------|--------|--------|---------------------|-------------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|Groups<br/>Room<br/>Rooms|

#### **Configuration**
If set, will get the device configuration

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

#### **Capability**
If set, will get the device capabilities

|Type      |Required|Position|PipelineInput        |Aliases     |
|----------|--------|--------|---------------------|------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|Capabilities|

#### **Resource**
If set, will get resources defined on the device

|Type      |Required|Position|PipelineInput        |Aliases                                     |
|----------|--------|--------|---------------------|--------------------------------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|Resources<br/>ResourceLink<br/>ResourceLinks|

#### **Light**
If set, will get the lights defined on the device

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Switch]`|true    |named   |true (ByPropertyName)|Lights |

#### **Name**
If provided, will filter returned items by name

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|false   |1       |true (ByPropertyName)|

#### **RegularExpression**
If set, will treat the Name parameter as a regular expression pattern.  By default, Name will be treated as a wildcard

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **ExactMatch**
If set, will treat the Name parameter as a specific match

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **ID**
If provided, will filter returned items by ID

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|false   |named   |true (ByPropertyName)|

#### **Detailed**
If set, will requery each returned resource to retreive additional information.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

---

### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)

---

### Syntax
```PowerShell
Get-HueRule [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRule -Schedule [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRule -Rule [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRule -Scene [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRule -Sensor [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRule -Group [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRule -Configuration [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRule -Capability [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRule -Resource [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRule -Light [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
