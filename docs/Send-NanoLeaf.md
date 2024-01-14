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
> EXAMPLE 1

```PowerShell
Send-NanoLeaf -Command effects/effectsList
```

---

### Parameters
#### **IPAddress**
The IP Address of the NanoLeaf.

|Type         |Required|Position|PipelineInput        |
|-------------|--------|--------|---------------------|
|`[IPAddress]`|true    |1       |true (ByPropertyName)|

#### **Command**
The URI fragment to send to the nanoleaf.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |2       |false        |

#### **Method**
The HTTP method to send.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|

#### **Data**
The data to send.  This will be converted into JSON if it is not a string.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|false   |4       |true (ByPropertyName)|

#### **Property**
A set of additional properties to add to an object

|Type           |Required|Position|PipelineInput        |
|---------------|--------|--------|---------------------|
|`[IDictionary]`|false   |5       |true (ByPropertyName)|

#### **RemoveProperty**
A list of property names to remove from an object

|Type        |Required|Position|PipelineInput|
|------------|--------|--------|-------------|
|`[String[]]`|false   |6       |false        |

#### **ExpandProperty**
If provided, will expand a given property returned from the REST api.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |7       |false        |

#### **PSTypeName**
The typename of the results.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|false   |8       |true (ByPropertyName)|

#### **NanoLeafToken**
The nanoleaf token

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |9       |true (ByPropertyName)|

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
