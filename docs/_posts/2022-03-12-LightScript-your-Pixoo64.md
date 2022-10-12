---

title: LightScript your Pixoo64
author: StartAutomating
sourceURL: https://github.com/StartAutomating/LightScript/issues/4
tag: enhancement
---
Divoom's Pixoo64 is an interesting device.  It's a "PixelArt" frame with a 64x64 resolution with a number of interesting bells and whistles.

LightScript makes these bells and whistles easier than ever to access.

Here's a brief run thru of what you can do:

The Pixoo App will let you know the device's IP address.

Once you have that, you can use Connect-Pixoo to connect to the device:

~~~PowerShell
Connect-Pixoo -IPAddress 1.2.3.4
~~~

To list connected devices, use:

~~~PowerShell
Get-Pixoo
~~~

Here are a few things you can do with your Pixoo:

~~~PowerShell
Set-Pixoo -Channel Cloud # Switch to the cloud Channel

Set-Pixoo -Channel Visualizer # Switch to the visualizer

Set-Pixoo -Visualizer 20 # Switch to a hidden visualizer

Set-Pixoo -Stopwatch Start # Start a Stopwatch

Set-Pixoo -Stopwatch Reset # Reset a Stopwatch

Set-Pixoo -Timer "00:01:00" # Set a timer for one minute

Set-Pixoo -RedScore 1 -BlueScore 0 # Keep a scoreboard
~~~

If you have a Pixoo64, download LightScript and give it a try.

Happy LightScripting
