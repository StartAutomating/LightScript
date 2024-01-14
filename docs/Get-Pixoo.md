Get-Pixoo
---------

### Synopsis
Gets Pixoo Devices

---

### Description

Gets saved Pixoo Devices

---

### Related Links
* [Connect-Pixoo](Connect-Pixoo.md)

* [Set-Pixoo](Set-Pixoo.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-Pixoo
```

---

### Parameters
#### **IPAddress**
The IP Address for the Pixoo device.
This can be discovered thru the phone user interface or by using Find-Pixoo.

|Type           |Required|Position|PipelineInput        |Aliases       |
|---------------|--------|--------|---------------------|--------------|
|`[IPAddress[]]`|false   |named   |true (ByPropertyName)|PixooIPAddress|

#### **Weather**
If set, will get the local weather.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|true    |named   |false        |

#### **Upload**
If set, will get uploads.

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[Switch]`|true    |named   |false        |Uploads|

#### **Liked**
If set, will get liked images.

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[Switch]`|true    |named   |false        |Likes  |

#### **Font**
If set, will get fonts that can be used on the Pixoo.

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[Switch]`|true    |named   |false        |Fonts  |

#### **Force**
If set, will clear any cached results.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

---

### Syntax
```PowerShell
Get-Pixoo [-IPAddress <IPAddress[]>] [-Force] [<CommonParameters>]
```
```PowerShell
Get-Pixoo [-IPAddress <IPAddress[]>] -Weather [-Force] [<CommonParameters>]
```
```PowerShell
Get-Pixoo [-IPAddress <IPAddress[]>] -Upload [-Force] [<CommonParameters>]
```
```PowerShell
Get-Pixoo [-IPAddress <IPAddress[]>] -Liked [-Force] [<CommonParameters>]
```
```PowerShell
Get-Pixoo [-IPAddress <IPAddress[]>] -Font [-Force] [<CommonParameters>]
```
