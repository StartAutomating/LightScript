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
### Syntax
```PowerShell
Set-LaMetricTime [[-IPAddress] <IPAddress[]>] [[-Timer] <TimeSpan>] [<CommonParameters>]
```
---
