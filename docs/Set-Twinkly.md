
Set-Twinkly
-----------
### Synopsis
Sets Twinkly Lights

---
### Description

Sets Twinkly Lights.  Changes colors, mode of operation

---
### Related Links
* [](Get-Twinkly.md)
* [](Connect-Twinkly.md)
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



|Type               |Requried|Postion|PipelineInput        |
|-------------------|--------|-------|---------------------|
|```[IPAddress[]]```|false   |1      |true (ByPropertyName)|
---
#### **Hue**

Sets the hue of all lights in a fixture



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Double]```|false   |2      |true (ByPropertyName)|
---
#### **Saturation**

Sets the saturation of all lights in a fixture



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Double]```|false   |3      |true (ByPropertyName)|
---
#### **Brightness**

Sets the brightness of all lights in a fixture
When passed with -Hue and -Saturation, sets the color
When passed with no other parameters, adjusts the absolute brightness



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Double]```|false   |4      |true (ByPropertyName)|
---
#### **Red**

Sets the red part of a color



|Type        |Requried|Postion|PipelineInput        |
|------------|--------|-------|---------------------|
|```[Byte]```|false   |5      |true (ByPropertyName)|
---
#### **Green**

Sets the green part of a color



|Type        |Requried|Postion|PipelineInput        |
|------------|--------|-------|---------------------|
|```[Byte]```|false   |6      |true (ByPropertyName)|
---
#### **Blue**

Sets the blue part of a color



|Type        |Requried|Postion|PipelineInput        |
|------------|--------|-------|---------------------|
|```[Byte]```|false   |7      |true (ByPropertyName)|
---
#### **RGBColor**

Sets lights to an RGB color.
If one color is provided, this will set the Twinkly color mode
If more than one RGB Color is provided, this will create a movie where each light alternates between each color
If -MovieFrameRate and



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |8      |true (ByPropertyName)|
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



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |9      |true (ByPropertyName)|
---
#### **DeviceName**

If provided, will set the device name.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |10     |true (ByPropertyName)|
---
#### **RestartPlaylist**

If provided, will restart the playlist



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Switch]```|false   |named  |true (ByPropertyName)|
---
#### **MovieName**

The name of a movie.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[String]```|false   |11     |true (ByPropertyName)|
---
#### **MovieFramerate**

The movie framerate



|Type         |Requried|Postion|PipelineInput        |
|-------------|--------|-------|---------------------|
|```[Int32]```|false   |12     |true (ByPropertyName)|
---
#### **MovieLEDCount**

The movie LED



|Type         |Requried|Postion|PipelineInput        |
|-------------|--------|-------|---------------------|
|```[Int32]```|false   |13     |true (ByPropertyName)|
---
#### **MovieFrameCount**

The number of frames in the movie.



|Type         |Requried|Postion|PipelineInput        |
|-------------|--------|-------|---------------------|
|```[Int32]```|false   |14     |true (ByPropertyName)|
---
#### **MovieData**

A byte array of movie data.
Each sequence of 3-4 bytes represents a light color
Each sequence of colors represents a frame
Each sequence of frames represents a movie.



|Type          |Requried|Postion|PipelineInput        |
|--------------|--------|-------|---------------------|
|```[Byte[]]```|false   |15     |true (ByPropertyName)|
---
#### **MovieBlockSize**

The size of each block within a movie.  By default, 3.



|Type        |Requried|Postion|PipelineInput        |
|------------|--------|-------|---------------------|
|```[Byte]```|false   |16     |true (ByPropertyName)|
---
### Outputs
System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Set-Twinkly [[-IPAddress] <IPAddress[]>] [[-Hue] <Double>] [[-Saturation] <Double>] [[-Brightness] <Double>] [[-Red] <Byte>] [[-Green] <Byte>] [[-Blue] <Byte>] [[-RGBColor] <String[]>] [[-Mode] <String>] [[-DeviceName] <String>] [-RestartPlaylist] [[-MovieName] <String>] [[-MovieFramerate] <Int32>] [[-MovieLEDCount] <Int32>] [[-MovieFrameCount] <Int32>] [[-MovieData] <Byte[]>] [[-MovieBlockSize] <Byte>] [<CommonParameters>]
```
---


