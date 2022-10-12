---

title: Making Philips Hue Rules in LightScript
author: StartAutomating
sourceURL: https://github.com/StartAutomating/LightScript/issues/28
tag: enhancement
---
Hue Rule expressions take the format `/resource/id/...`

This isn't exactly the most "user friendly" option.  When was the last time _you_ memorized dozens of numeric ids?

Set-HueRule was recently updated to make this a lot easier.

Now, when you Set-HueRule, you can provide the name of a sensor instead of the numeric ID in a condition:

~~~PowerShell
    Set-HueRule -Condition {
        "/sensors/SunroomDimmerSwitch/state/buttonevent" -eq "3003"
    } -Action {
        Set-HueLight -RoomName "Sunroom" -BrightnessIncrement -.1
    } -Name SunroomDimmerHoldDarken
~~~ 

Because "sensors" is followed by a non-integer, we can interpret it as a name.

We can do so by providing the resource and name to Get-HueBridge, and then appending on the rest of the uri.

For flexibility, we actually consider two possible names: The literal name, and de-CamelCased version of the name.  Thus even though my dimmer switch is actually called "Sunroom Dimmer Switch", Set-HueRule figures it out and sets the right rule for the right switch.

Custom Rules are an incredibly powerful part of the Hue ecosystem, and this makes _much_ easier to set up.

Happy LightScripting


