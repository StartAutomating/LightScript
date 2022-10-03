
Add-HueRoom
-----------
### Synopsis
Adds rooms or groups to a Hue Bridge.

---
### Description

Adds Hue rooms, groups, or entertainment areas to a Hue Bridge.

---
### Related Links
* [Get-HueRoom](Get-HueRoom.md)



* [Remove-HueRoom](Remove-HueRoom.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Add-HueRoom -Name Office -Light "Office Lightstrip", "Office Desk Light 1", "Office Desk Light 2" -RoomType Office
```

---
### Parameters
#### **Name**

The name of the Room or Light Group.



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Light**

The name of the lights that will be added to the room



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **LightID**

One or more identifiers for lights



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **AutoGroup**

If set, will automatically group lights with a similar name as the room.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **RoomType**

The type of the room



Valid Values:

* Bathroom
* Bedroom
* Carport
* Driveway
* Dining
* Front door
* Garage
* Garden
* Gym
* Hallway
* Kids bedroom
* Kitchen
* Living room
* Office
* Other
* Nursery
* Recreation
* Terrace
* Toilet



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **GroupType**

The type of the group, either Room of LightGroup (by default, Room).
Rooms cannot share lights with other rooms, while light groups can contain lights already in a room.



Valid Values:

* Room
* LightGroup
* Entertainment
* Zone



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Add-HueRoom [-Name] <String> [-Light <String[]>] [-LightID <String[]>] [-AutoGroup] [-RoomType <String>] [-GroupType <String>] [<CommonParameters>]
```
---


