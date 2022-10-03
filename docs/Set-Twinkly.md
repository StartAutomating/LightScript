
Set-Twinkly
-----------
### Synopsis
Sets Twinkly Lights

---
### Description

Sets Twinkly Lights.  Changes colors, mode of operation

---
### Related Links
* [Get-Twinkly](Get-Twinkly.md)



* [Connect-Twinkly](Connect-Twinkly.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Set-Twinkly -Hue 360 -Saturation 100 -Luminance 1
```

---
### Parameters
#### **IPAddress**

One or more IP Addresses of Twinkly devices.



> **Type**: ```[IPAddress[]]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Hue**

Sets the hue of all lights in a fixture



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **Saturation**

Sets the saturation of all lights in a fixture



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **Brightness**

Sets the brightness of all lights in a fixture
When passed with -Hue and -Saturation, sets the color
When passed with no other parameters, adjusts the absolute brightness



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **Red**

Sets the red part of a color



> **Type**: ```[Byte]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **Green**

Sets the green part of a color



> **Type**: ```[Byte]```

> **Required**: false

> **Position**: 6

> **PipelineInput**:true (ByPropertyName)



---
#### **Blue**

Sets the blue part of a color



> **Type**: ```[Byte]```

> **Required**: false

> **Position**: 7

> **PipelineInput**:true (ByPropertyName)



---
#### **RGBColor**

Sets lights to an RGB color.
If one color is provided, this will set the Twinkly color mode
If more than one RGB Color is provided, this will create a movie where each light alternates between each color
If -MovieFrameRate and



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 8

> **PipelineInput**:true (ByPropertyName)



---
#### **Mode**

Will change the mode. Can be:

* Off
* Color
* Demo
* Effect
* Movie
* Playlist
* RT

Many operations require the mode to be set before they take effect.

For instance, if you use -RGBColor, you will not see the changes if the mode is not set to 'color'.



Valid Values:

* off
* color
* demo
* effect
* movie
* playlist
* rt



> **Type**: ```[String]```

> **Required**: false

> **Position**: 9

> **PipelineInput**:true (ByPropertyName)



---
#### **DeviceName**

If provided, will set the device name.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 10

> **PipelineInput**:true (ByPropertyName)



---
#### **RestartPlaylist**

If provided, will restart the playlist



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **MovieName**

The name of a movie.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 11

> **PipelineInput**:true (ByPropertyName)



---
#### **MovieFramerate**

The movie framerate



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 12

> **PipelineInput**:true (ByPropertyName)



---
#### **MovieLEDCount**

The movie LED



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 13

> **PipelineInput**:true (ByPropertyName)



---
#### **MovieFrameCount**

The number of frames in the movie.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 14

> **PipelineInput**:true (ByPropertyName)



---
#### **MovieData**

A byte array of movie data.
Each sequence of 3-4 bytes represents a light color
Each sequence of colors represents a frame
Each sequence of frames represents a movie.



> **Type**: ```[Byte[]]```

> **Required**: false

> **Position**: 15

> **PipelineInput**:true (ByPropertyName)



---
#### **MovieBlockSize**

The size of each block within a movie.  By default, 3.



> **Type**: ```[Byte]```

> **Required**: false

> **Position**: 16

> **PipelineInput**:true (ByPropertyName)



---
### Outputs
* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Set-Twinkly [[-IPAddress] <IPAddress[]>] [[-Hue] <Double>] [[-Saturation] <Double>] [[-Brightness] <Double>] [[-Red] <Byte>] [[-Green] <Byte>] [[-Blue] <Byte>] [[-RGBColor] <String[]>] [[-Mode] <String>] [[-DeviceName] <String>] [-RestartPlaylist] [[-MovieName] <String>] [[-MovieFramerate] <Int32>] [[-MovieLEDCount] <Int32>] [[-MovieFrameCount] <Int32>] [[-MovieData] <Byte[]>] [[-MovieBlockSize] <Byte>] [<CommonParameters>]
```
---


