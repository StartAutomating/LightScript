
Get-HueRoom
-----------
### Synopsis
Gets Hue Groups

---
### Description

Gets Groups from one or more Hue Bridges

---
### Related Links
* [Remove-HueRoom](Remove-HueRoom.md)
* [Get-HueBridge](Get-HueBridge.md)
* [Send-HueBridge](Send-HueBridge.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Get-HueRoom
```

---
### Parameters
#### **Schedule**

If set, will get the schedules defined on the Hue bridge



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Rule**

If set, will get the rules defined on the Hue bridge



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Scene**

If set, will get the scenes defined on the Hue bridge



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Sensor**

If set, will get the sensors defined on the Hue bridge



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Group**

If set, will get the groups (or rooms) defined on the Hue bridge



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Configuration**

If set, will get the device configuration



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Capability**

If set, will get the device capabilities



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Resource**

If set, will get resources defined on the device



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Light**

If set, will get the lights defined on the device



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Name**

If provided, will filter returned items by name



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |1      |true (ByPropertyName)|
---
#### **RegularExpression**

If set, will treat the Name parameter as a regular expression pattern.  By default, Name will be treated as a wildcard



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **ExactMatch**

If set, will treat the Name parameter as a specific match



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **ID**

If provided, will filter returned items by ID



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |named  |true (ByPropertyName)|
---
#### **Detailed**

If set, will requery each returned resource to retreive additional information.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[Switch]```|false   |named  |false        |
---
### Outputs
System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Get-HueRoom [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRoom -Schedule [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRoom -Rule [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRoom -Scene [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRoom -Sensor [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRoom -Group [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRoom -Configuration [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRoom -Capability [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRoom -Resource [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
```PowerShell
Get-HueRoom -Light [[-Name] <String[]>] [-RegularExpression] [-ExactMatch] [-ID <String[]>] [-Detailed] [<CommonParameters>]
```
---


