
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



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|true    |1      |true (ByPropertyName)|
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
|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|true    |2      |true (ByPropertyName)|
---
#### **ModelID**

The sensor ModelID



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |3      |true (ByPropertyName)|
---
#### **Manufacturer**

The sensor manufacturer



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |3      |true (ByPropertyName)|
---
#### **UniqueID**

The sensor unique ID.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |4      |true (ByPropertyName)|
---
#### **Version**

The sensor version.



|Type           |Requried|Postion|PipelineInput        |
|---------------|--------|-------|---------------------|
|```[Version]```|false   |5      |true (ByPropertyName)|
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
System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Add-HueSensor [-Name] <String> [-SensorType] <String> [[-ModelID] <String>] [[-Manufacturer] <String>] [[-UniqueID] <String>] [[-Version] <Version>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---


