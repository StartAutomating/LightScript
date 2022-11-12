Connect-LaMetricTime
--------------------
### Synopsis
Connects to a LaMetric clock

---
### Description

Connects to a LaMetric clock.
LaMetric Time devices require a local ApiKey.

Unfortunately, there is no way to get this key automatically.

To Connect-LaMetricTime, you'll need to visit [developer.lametric.com](https://developer.lametric.com) and sign in.
You will find API Keys for your devices at [developer.lametric.com/user/devices](https://developer.lametric.com/user/devices).

---
### Related Links
* [Get-LaMetricTime](Get-LaMetricTime.md)



* [Disconnect-LaMetricTime](Disconnect-LaMetricTime.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Connect-LaMetric -IPAddress $laMetricIP -ApiKey $myApiKey -PassThru
```

---
### Parameters
#### **IPAddress**

The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.



> **Type**: ```[IPAddress]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **ApiKey**

The IP Address for the Twinkly device.  This can be discovered thru the phone user interface.



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

If set, will output the connection information.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
### Outputs
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)


* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Connect-LaMetricTime [-IPAddress] <IPAddress> [-ApiKey] <String> [-PassThru] [<CommonParameters>]
```
---
