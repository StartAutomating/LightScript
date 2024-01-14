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
> EXAMPLE 1

```PowerShell
Get-HueLight
```

---

### Parameters
#### **Name**
The name of the light

|Type        |Required|Position|PipelineInput|Aliases  |
|------------|--------|--------|-------------|---------|
|`[String[]]`|true    |1       |false        |LightName|

#### **RegularExpression**
If set, will match patterns as regular expressions

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **ExactMatch**
If set, will only match exact text

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **Room**
The name of the room.

|Type        |Required|Position|PipelineInput|Aliases |
|------------|--------|--------|-------------|--------|
|`[String[]]`|true    |named   |false        |RoomName|

#### **LightID**
The light ID.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|true    |named   |true (ByPropertyName)|

#### **New**
If set, will get recently added lights.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

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
