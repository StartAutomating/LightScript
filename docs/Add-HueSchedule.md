Add-HueSchedule
---------------

### Synopsis
Adds a schedule to a Hue Bridge

---

### Description

Adds a new schedule to a Hue Bridge

---

### Related Links
* [Get-HueSchedule](Get-HueSchedule.md)

* [Get-HueBridge](Get-HueBridge.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Add-HueSchedule -Daily -Name "Shift to Sunset" -Description "Shift to warmer and brighter as the day draws to a close" -Command (Set-Light -ColorTemperature 400 -Luminance 1 -TransitionTime '01:30:00' -OutputInput) -LocalTime "3:00 PM"
```

---

### Parameters
#### **Name**
The name of the schedule

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

#### **Description**
A description for the schedule

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

#### **Command**
The command that will be run

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|true    |named   |true (ByPropertyName)|

#### **LocalTime**
The time of the command

|Type        |Required|Position|PipelineInput        |Aliases|
|------------|--------|--------|---------------------|-------|
|`[DateTime]`|true    |1       |true (ByPropertyName)|At     |

#### **Daily**
If set, will run daily

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |2       |true (ByPropertyName)|

#### **DayOfWeek**
The days of the week the schedule will be executed (1 is Sunday, 7 is Saturday).

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Byte[]]`|false   |3       |true (ByPropertyName)|

#### **For**
The time the schedule should last

|Type        |Required|Position|PipelineInput        |Aliases                     |
|------------|--------|--------|---------------------|----------------------------|
|`[TimeSpan]`|false   |4       |true (ByPropertyName)|ForTimeframe<br/>ForTimespan|

#### **In**
Sets a countdown timer.  This timer will occur once, in a given timespan.

|Type        |Required|Position|PipelineInput        |Aliases              |
|------------|--------|--------|---------------------|---------------------|
|`[TimeSpan]`|true    |1       |true (ByPropertyName)|InTime<br/>InTimespan|

#### **Every**
If set, will repeat every N timeframe

|Type        |Required|Position|PipelineInput        |Aliases                    |
|------------|--------|--------|---------------------|---------------------------|
|`[TimeSpan]`|true    |1       |true (ByPropertyName)|EveryTime<br/>EveryTimespan|

#### **Within**
If provided, the schedule will execute at a random time within the provided timespan.

|Type        |Required|Position|PipelineInput        |Aliases          |
|------------|--------|--------|---------------------|-----------------|
|`[TimeSpan]`|false   |5       |true (ByPropertyName)|Jitter<br/>Around|

#### **DeviceID**
If provided, the schedule will only run on the bridge with a particular device ID

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

#### **IPAddress**
If provided, the schedule will only run on the bridge found at the provided IP address

|Type         |Required|Position|PipelineInput        |Aliases|
|-------------|--------|--------|---------------------|-------|
|`[IPAddress]`|false   |named   |true (ByPropertyName)|IP     |

---

### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)

---

### Syntax
```PowerShell
Add-HueSchedule [-Name <String>] [-Description <String>] -Command <PSObject> [-LocalTime] <DateTime> [[-Daily]] [[-DayOfWeek] <Byte[]>] [[-For] <TimeSpan>] [[-Within] <TimeSpan>] [-DeviceID <String>] [-IPAddress <IPAddress>] [<CommonParameters>]
```
```PowerShell
Add-HueSchedule [-Name <String>] [-Description <String>] -Command <PSObject> [-In] <TimeSpan> [[-Within] <TimeSpan>] [-DeviceID <String>] [-IPAddress <IPAddress>] [<CommonParameters>]
```
```PowerShell
Add-HueSchedule [-Name <String>] [-Description <String>] -Command <PSObject> [-Every] <TimeSpan> [-DeviceID <String>] [-IPAddress <IPAddress>] [<CommonParameters>]
```
