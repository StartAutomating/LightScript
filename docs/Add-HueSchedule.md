
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
#### EXAMPLE 1
```PowerShell
Add-HueSchedule -Daily -Name "Shift to Sunset" -Description "Shift to warmer and brighter as the day draws to a close" -Command (Set-Light -ColorTemperature 400 -Luminance 1 -TransitionTime '01:30:00' -OutputInput) -LocalTime "3:00 PM"
```

---
### Parameters
#### **Name**

The name of the schedule



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Description**

A description for the schedule



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Command**

The command that will be run



> **Type**: ```[PSObject]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **LocalTime**

The time of the command



> **Type**: ```[DateTime]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Daily**

If set, will run daily



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **DayOfWeek**

The days of the week the schedule will be executed (1 is Sunday, 7 is Saturday).



> **Type**: ```[Byte[]]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **For**

The time the schedule should last



> **Type**: ```[TimeSpan]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **In**

Sets a countdown timer.  This timer will occur once, in a given timespan.



> **Type**: ```[TimeSpan]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Every**

If set, will repeat every N timeframe



> **Type**: ```[TimeSpan]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Within**

If provided, the schedule will execute at a random time within the provided timespan.



> **Type**: ```[TimeSpan]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **DeviceID**

If provided, the schedule will only run on the bridge with a particular device ID



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **IPAddress**

If provided, the schedule will only run on the bridge found at the provided IP address



> **Type**: ```[IPAddress]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



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
---


