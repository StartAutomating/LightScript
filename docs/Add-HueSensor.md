
Add-HueSensor
-------------
### Synopsis
Adds a sensor to a Hue Bridge.

---
### Description

Adds sensors to a Hue Bridge.
Sensors can be physical sensors, such as a motion detector, or virtual sensors, such as GenericFlag.

---
### Related Links
* [Get-HueSensor](Get-HueSensor.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Add-HueSensor -Name "ChaseStatus1" -SensorType GenericStatus
```

---
### Parameters
#### **Name**

The name of the sensor.



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **SensorType**

The sensor type.

Sensors can be:

    * Switches
    * OpenClose
    * Presence (motion detectors)
    * Temperature
    * Humidity
    * LightLevel
    * GenericFlag (used for virtual sensors)
    * GenericStatus (used for virtual sensors)



Valid Values:

* Switch
* OpenClose
* Presence
* Temperature
* Humidity
* LightLevel
* GenericFlag
* GenericStatus



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **ModelID**

The sensor ModelID



> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **Manufacturer**

The sensor manufacturer



> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **UniqueID**

The sensor unique ID.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **Version**

The sensor version.



> **Type**: ```[Version]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **New**

If set, will search for new sensors to add.



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:false



---
#### **WhatIf**
-WhatIf is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-WhatIf is used to see what would happen, or return operations without executing them
#### **Confirm**
-Confirm is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-Confirm is used to -Confirm each operation.
    
If you pass ```-Confirm:$false``` you will not be prompted.
    
    
If the command sets a ```[ConfirmImpact("Medium")]``` which is lower than ```$confirmImpactPreference```, you will not be prompted unless -Confirm is passed.

---
### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Add-HueSensor [-Name] <String> [-SensorType] <String> [[-ModelID] <String>] [[-Manufacturer] <String>] [[-UniqueID] <String>] [[-Version] <Version>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
```PowerShell
Add-HueSensor -New [-WhatIf] [-Confirm] [<CommonParameters>]
```
---


