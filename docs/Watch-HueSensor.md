Watch-HueSensor
---------------
### Synopsis
Watches Hue Sensors for changes

---
### Description

Watches Hue Sensors for changes.

An event will be generated whenever a sensor changes.

---
### Related Links
* [Get-HueSensor](Get-HueSensor.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
# Watch for events every minute
Watch-HueSensor -Interval "00:01:00"
```
# Whenever daylight changes
Register-EngineEvent -SourceIdentifier Daylight.Changed -Action {
    if ($event.MessageData.state.Daylight) {
        Set-HueLight -Brightness 0.5
        Set-NanoLeaf -Brightness 0.5
    } else {
        Set-HueLight -Brightness 1
        Set-NanoLeaf -Brightness 1
    }
}
---
### Parameters
#### **Interval**

The interval hue sensors will be polled.  By default, every 2.5 seconds.



> **Type**: ```[TimeSpan]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
### Outputs
* [Management.Automation.Job](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.Job)




---
### Syntax
```PowerShell
Watch-HueSensor [[-Interval] <TimeSpan>] [<CommonParameters>]
```
---
