Set-LaMetricTime
----------------
### Synopsis
Sets a LaMetricTime device.

---
### Description

Configures or sends notifications to an LaMetricTime device.

---
### Related Links
* [Get-LaMetricTime](Get-LaMetricTime.md)



* [Connect-LaMetrictime](Connect-LaMetrictime.md)



---
### Examples
#### EXAMPLE 1

---
### Parameters
#### **IPAddress**

One or more IP Addresses of LaMetricTime devices.
If no IP Addresses are provided, the change will apply to all devices.



> **Type**: ```[IPAddress[]]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Timer**

Sets a Timer on the LaMetric device, using the built-in Countdown app.



> **Type**: ```[TimeSpan]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **Stopwatch**

If provided, will switch the LaMetric Time into Stopwatch mode, and Stop/Pause, Reset, or Start the StopWatch



Valid Values:

* Stop
* Pause
* Start
* Reset



> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **Weather**

If set, will switch the LaMetric Time into weather forecast mode.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-LaMetricTime [[-IPAddress] <IPAddress[]>] [[-Timer] <TimeSpan>] [[-Stopwatch] <String>] [-Weather] [<CommonParameters>]
```
---
