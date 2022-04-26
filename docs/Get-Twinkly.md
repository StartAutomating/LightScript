
Get-Twinkly
-----------
### Synopsis
Gets Twinkly

---
### Description

Gets Twinkly lights.

---
### Related Links
* [Connect-Twinkly](Connect-Twinkly.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Get-Twinkly
```

---
### Parameters
#### **IPAddress**

One or more IP Addresses of Twinkly devices.



|Type               |Requried|Postion|PipelineInput        |
|-------------------|--------|-------|---------------------|
|```[IPAddress[]]```|false   |named  |true (ByPropertyName)|
---
#### **OperationMode**

If set, will get the operation mode



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Layout**

If set, will get the layout of the Twinkly lights.  This may take a bit.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **CurrentColor**

If set, will get the color displayed when the Twinkly lights are in color mode.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **ListEffect**

If set, will list the available effects.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **CurrentEffect**

If set, will show the current effect.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Configuration**

If set, will list the configuration of each LED.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Brightness**

If set, will output the brightness levels.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Saturation**

If set, will output the saturation levels.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **ListMovie**

If set, will output the list of movies.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **CurrentMovie**

If set, will output the list of movies.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **MovieConfiguration**

If set, will output movie configuration.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Playlist**

If set, will output the playlists.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **CurrentPlaylistItem**

If set, will output the current playlist item.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **MQTTConfiguration**

If set, will output the MQTT configuration.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Summary**

If set, will output the summary.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **NetworkStatus**

If set, will output the network status.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **FirmwareVersion**

If set, will output the network status.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
#### **Timer**

If set, will output timers associated with each device.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|true    |named  |true (ByPropertyName)|
---
### Outputs
System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -OperationMode [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -Layout [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -CurrentColor [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -ListEffect [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -CurrentEffect [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -Configuration [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -Brightness [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -Saturation [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -ListMovie [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -CurrentMovie [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -MovieConfiguration [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -Playlist [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -CurrentPlaylistItem [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -MQTTConfiguration [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -Summary [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -NetworkStatus [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -FirmwareVersion [<CommonParameters>]
```
```PowerShell
Get-Twinkly [-IPAddress <IPAddress[]>] -Timer [<CommonParameters>]
```
---


