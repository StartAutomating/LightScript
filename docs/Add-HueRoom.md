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
> EXAMPLE 1

```PowerShell
Add-HueRoom -Name Office -Light "Office Lightstrip", "Office Desk Light 1", "Office Desk Light 2" -RoomType Office
```

---

### Parameters
#### **Name**
The name of the Room or Light Group.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|

#### **Light**
The name of the lights that will be added to the room

|Type        |Required|Position|PipelineInput        |Aliases  |
|------------|--------|--------|---------------------|---------|
|`[String[]]`|false   |named   |true (ByPropertyName)|LightName|

#### **LightID**
One or more identifiers for lights

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|false   |named   |true (ByPropertyName)|

#### **AutoGroup**
If set, will automatically group lights with a similar name as the room.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

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

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

#### **GroupType**
The type of the group, either Room of LightGroup (by default, Room).
Rooms cannot share lights with other rooms, while light groups can contain lights already in a room.
Valid Values:

* Room
* LightGroup
* Entertainment
* Zone

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

---

### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)

---

### Syntax
```PowerShell
Add-HueRoom [-Name] <String> [-Light <String[]>] [-LightID <String[]>] [-AutoGroup] [-RoomType <String>] [-GroupType <String>] [<CommonParameters>]
```
