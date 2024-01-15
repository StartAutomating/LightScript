Get-Awtrix
----------

### Synopsis
Gets Awtrix Devices

---

### Description

Gets saved Awtrix Devices

---

### Related Links
* [Connect-Awtrix](Connect-Awtrix.md)

* [Set-Awtrix](Set-Awtrix.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-Awtrix
```

---

### Parameters
#### **IPAddress**
The IP Address for the Awtrix device.
This can be discovered thru the phone user interface or by using Find-Awtrix.

|Type           |Required|Position|PipelineInput        |Aliases        |
|---------------|--------|--------|---------------------|---------------|
|`[IPAddress[]]`|false   |1       |true (ByPropertyName)|AwtrixIPAddress|

#### **Force**
If set, will clear any cached results.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

---

### Syntax
```PowerShell
Get-Awtrix [[-IPAddress] <IPAddress[]>] [-Force] [<CommonParameters>]
```
