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
> EXAMPLE 1

```PowerShell
Get-Twinkly
```

---

### Parameters
#### **IPAddress**
One or more IP Addresses of Twinkly devices.

|Type           |Required|Position|PipelineInput        |Aliases         |
|---------------|--------|--------|---------------------|----------------|
|`[IPAddress[]]`|false   |named   |true (ByPropertyName)|TwinklyIPAddress|

#### **OperationMode**
If set, will get the operation mode

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

#### **Layout**
If set, will get the layout of the Twinkly lights.  This may take a bit.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

#### **CurrentColor**
If set, will get the color displayed when the Twinkly lights are in color mode.

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|CurrentColour|

#### **ListEffect**
If set, will list the available effects.

|Type      |Required|Position|PipelineInput        |Aliases    |
|----------|--------|--------|---------------------|-----------|
|`[Switch]`|true    |named   |true (ByPropertyName)|ListEffects|

#### **CurrentEffect**
If set, will show the current effect.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

#### **Configuration**
If set, will list the configuration of each LED.

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Switch]`|true    |named   |true (ByPropertyName)|Config |

#### **Brightness**
If set, will output the brightness levels.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

#### **Saturation**
If set, will output the saturation levels.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

#### **ListMovie**
If set, will output the list of movies.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

#### **CurrentMovie**
If set, will output the list of movies.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

#### **MovieConfiguration**
If set, will output movie configuration.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

#### **Playlist**
If set, will output the playlists.

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[Switch]`|true    |named   |true (ByPropertyName)|Playlists|

#### **CurrentPlaylistItem**
If set, will output the current playlist item.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

#### **MQTTConfiguration**
If set, will output the MQTT configuration.

|Type      |Required|Position|PipelineInput        |Aliases   |
|----------|--------|--------|---------------------|----------|
|`[Switch]`|true    |named   |true (ByPropertyName)|MQTTConfig|

#### **Summary**
If set, will output the summary.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

#### **NetworkStatus**
If set, will output the network status.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

#### **FirmwareVersion**
If set, will output the network status.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

#### **Timer**
If set, will output timers associated with each device.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

---

### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)

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
