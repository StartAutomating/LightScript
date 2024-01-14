Set-KeyLight
------------

### Synopsis
Sets Elgato Key Lighting

---

### Description

Changes Elgato Key Lighting

---

### Related Links
* [Get-KeyLight](Get-KeyLight.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Set-KeyLight -Brightness .5
```

---

### Parameters
#### **IPAddress**
One or more IP Addresses of Elgato Key Lighting devices.

|Type           |Required|Position|PipelineInput        |Aliases          |
|---------------|--------|--------|---------------------|-----------------|
|`[IPAddress[]]`|false   |1       |true (ByPropertyName)|KeyLightIPAddress|

#### **Brightness**
Sets the brightness of all lights in a fixture
When passed with -Hue and -Saturation, sets the color
When passed with no other parameters, adjusts the absolute brightness

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[Single]`|false   |2       |true (ByPropertyName)|Luminance|

#### **On**
If set, will turn the light on.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Off**
If set, will turn the light on.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **ColorTemperature**
The color temperature as a Mired value.

|Type     |Required|Position|PipelineInput        |Aliases                |
|---------|--------|--------|---------------------|-----------------------|
|`[Int32]`|false   |3       |true (ByPropertyName)|CT<br/>TemperatureMired|

#### **WhatIf**
-WhatIf is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-WhatIf is used to see what would happen, or return operations without executing them
#### **Confirm**
-Confirm is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-Confirm is used to -Confirm each operation.

If you pass ```-Confirm:$false``` you will not be prompted.

If the command sets a ```[ConfirmImpact("Medium")]``` which is lower than ```$confirmImpactPreference```, you will not be prompted unless -Confirm is passed.

---

### Syntax
```PowerShell
Set-KeyLight [[-IPAddress] <IPAddress[]>] [[-Brightness] <Single>] [-On] [-Off] [[-ColorTemperature] <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
