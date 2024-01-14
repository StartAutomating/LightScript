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
Watch for events every minute

```PowerShell
Watch-HueSensor -Interval "00:01:00"
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
```

---

### Parameters
#### **Interval**
The interval hue sensors will be polled.  By default, every 2.5 seconds.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[TimeSpan]`|false   |1       |true (ByPropertyName)|

---

### Outputs
* [Management.Automation.Job](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.Job)

---

### Syntax
```PowerShell
Watch-HueSensor [[-Interval] <TimeSpan>] [<CommonParameters>]
```
