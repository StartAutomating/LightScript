
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
#### EXAMPLE 1
```PowerShell
Get-HueLight
```

---
### Parameters
#### **Name**

The name of the light



|Type            |Requried|Postion|PipelineInput|
|----------------|--------|-------|-------------|
|```[String[]]```|true    |1      |false        |
---
#### **RegularExpression**

If set, will match patterns as regular expressions



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **ExactMatch**

If set, will only match exact text



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
#### **Room**

The name of the room.



|Type            |Requried|Postion|PipelineInput|
|----------------|--------|-------|-------------|
|```[String[]]```|true    |named  |false        |
---
#### **LightID**

The light ID.



|Type         |Requried|Postion|PipelineInput        |
|-------------|--------|-------|---------------------|
|```[Int32]```|true    |named  |true (ByPropertyName)|
---
#### **New**

If set, will get recently added lights.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
### Outputs
System.Management.Automation.PSObject


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
---


